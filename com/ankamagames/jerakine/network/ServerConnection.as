package com.ankamagames.jerakine.network
{
    import flash.events.IEventDispatcher;
    import flash.utils.Dictionary;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import flash.net.Socket;
    import com.ankamagames.jerakine.messages.MessageHandler;
    import flash.utils.ByteArray;
    import flash.utils.Timer;
    import flash.net.SecureSocket;
    import flash.events.TimerEvent;
    import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
    import com.ankamagames.jerakine.replay.LogFrame;
    import com.ankamagames.jerakine.replay.LogTypeEnum;
    import flash.events.Event;
    import flash.events.ProgressEvent;
    import flash.events.IOErrorEvent;
    import flash.events.SecurityErrorEvent;
    import flash.utils.getTimer;
    import flash.utils.IDataInput;
    import com.ankamagames.jerakine.messages.ConnectedMessage;
    import flash.utils.setTimeout;
    import com.ankamagames.jerakine.network.messages.ServerConnectionClosedMessage;
    import com.ankamagames.jerakine.network.messages.ServerConnectionFailedMessage;
    import __AS3__.vec.*;

    [Event(="connect", type="flash.events.Event")]
    [Event(="close", type="flash.events.Event")]
    [Event(="ioError", type="flash.events.IOErrorEvent")]
    [Event(="securityError", type="flash.events.SecurityErrorEvent")]
    public class ServerConnection implements IEventDispatcher, IServerConnection 
    {

        public static var disabled:Boolean;
        public static var disabledIn:Boolean;
        public static var disabledOut:Boolean;
        public static var DEBUG_VERBOSE:Boolean = false;
        public static var DEBUG_LOW_LEVEL_VERBOSE:Boolean = false;
        private static const DEBUG_DATA:Boolean = true;
        private static const LATENCY_AVG_BUFFER_SIZE:uint = 50;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerConnection));

        protected var _socket:Socket;
        private var _rawParser:RawDataParser;
        private var _handler:MessageHandler;
        private var _remoteSrvHost:String;
        private var _remoteSrvPort:uint;
        private var _connecting:Boolean;
        private var _outputBuffer:Array;
        private var _splittedPacket:Boolean;
        private var _staticHeader:int;
        private var _splittedPacketId:uint;
        private var _splittedPacketLength:uint;
        private var _inputBuffer:ByteArray;
        private var _pauseBuffer:Array;
        private var _pause:Boolean;
        private var _latencyBuffer:Array;
        private var _latestSent:uint;
        private var _lastSent:uint;
        private var _timeoutTimer:Timer;
        private var _lagometer:ILagometer;
        private var _sendSequenceId:uint = 0;

        public function ServerConnection(host:String=null, port:int=0, secure:Boolean=false)
        {
            this._pauseBuffer = new Array();
            this._latencyBuffer = new Array();
            super();
            if (((secure) && (SecureSocket.isSupported)))
            {
                this._socket = new SecureSocket();
            }
            else
            {
                this._socket = new Socket(host, port);
            };
            this._remoteSrvHost = host;
            this._remoteSrvPort = port;
        }

        public function close():void
        {
            this._socket.close();
        }

        public function get rawParser():RawDataParser
        {
            return (this._rawParser);
        }

        public function set rawParser(value:RawDataParser):void
        {
            this._rawParser = value;
        }

        public function get handler():MessageHandler
        {
            return (this._handler);
        }

        public function set handler(value:MessageHandler):void
        {
            this._handler = value;
        }

        public function get pauseBuffer():Array
        {
            return (this._pauseBuffer);
        }

        public function get latencyAvg():uint
        {
            var latency:uint;
            if (this._latencyBuffer.length == 0)
            {
                return (0);
            };
            var total:uint;
            for each (latency in this._latencyBuffer)
            {
                total = (total + latency);
            };
            return ((total / this._latencyBuffer.length));
        }

        public function get latencySamplesCount():uint
        {
            return (this._latencyBuffer.length);
        }

        public function get latencySamplesMax():uint
        {
            return (LATENCY_AVG_BUFFER_SIZE);
        }

        public function get port():uint
        {
            return (this._remoteSrvPort);
        }

        public function get lastSent():uint
        {
            return (this._lastSent);
        }

        public function set lagometer(l:ILagometer):void
        {
            this._lagometer = l;
        }

        public function get lagometer():ILagometer
        {
            return (this._lagometer);
        }

        public function get sendSequenceId():uint
        {
            return (this._sendSequenceId);
        }

        public function get connected():Boolean
        {
            return (this._socket.connected);
        }

        public function connect(host:String, port:int):void
        {
            if (((((this._connecting) || (disabled))) || (((disabledIn) && (disabledOut)))))
            {
                return;
            };
            this._connecting = true;
            this._remoteSrvHost = host;
            this._remoteSrvPort = port;
            this.addListeners();
            _log.info((((("Connecting to " + host) + ":") + port) + "..."));
            this._socket.connect(host, port);
            this._timeoutTimer = new Timer(10000, 1);
            this._timeoutTimer.start();
            this._timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onSocketTimeOut);
        }

        private function getType(v:*):String
        {
            var className:String = getQualifiedClassName(v);
            if (className.indexOf("Vector") != -1)
            {
                className = className.split("__AS3__.vec::Vector.<").join("list{");
                className = className.split(">").join("}");
            }
            else
            {
                className = className.split("::").pop();
            };
            if ((v is INetworkMessage))
            {
                className = (className + (", id: " + INetworkMessage(v).getMessageId()));
            };
            return (className);
        }

        private function inspect(target:*, indent:String="", isArray:Boolean=false):String
        {
            var property:*;
            var v:*;
            var str:String = "";
            var content:Array = DescribeTypeCache.getVariables(target, true, false);
            if (!(isArray))
            {
                str = (str + this.getType(target));
            };
            for each (property in content)
            {
                v = target[property];
                str = (str + ("\n" + indent));
                if (isArray)
                {
                    str = (str + (("[" + property) + "]"));
                }
                else
                {
                    str = (str + property);
                };
                switch (true)
                {
                    case (v is Vector.<int>):
                    case (v is Vector.<uint>):
                    case (v is Vector.<Boolean>):
                    case (v is Vector.<String>):
                    case (v is Vector.<Number>):
                        str = (str + (((((" (" + this.getType(v)) + ", len:") + v.length) + ") = ") + v));
                        break;
                    case !((getQualifiedClassName(v).indexOf("Vector") == -1)):
                    case (v is Array):
                        str = (str + (((((" (" + this.getType(v)) + ", len:") + v.length) + ") = ") + this.inspect(v, (indent + "\t"), true)));
                        break;
                    case (v is String):
                        str = (str + ((' = "' + v) + '"'));
                        break;
                    case (v is uint):
                    case (v is int):
                    case (v is Boolean):
                    case (v is Number):
                        str = (str + (" = " + v));
                        break;
                    default:
                        str = (str + (" " + this.inspect(v, (indent + "\t"))));
                };
            };
            return (str);
        }

        public function send(msg:INetworkMessage):void
        {
            if (DEBUG_DATA)
            {
                _log.trace(("[SND] > " + ((DEBUG_VERBOSE) ? this.inspect(msg) : msg)));
            };
            LogFrame.log(LogTypeEnum.NETWORK_OUT, msg);
            if (((disabled) || (disabledOut)))
            {
                return;
            };
            if (!(msg.isInitialized))
            {
                _log.warn((("Sending non-initialized packet " + msg) + " !"));
            };
            if (!(this._socket.connected))
            {
                if (this._connecting)
                {
                    this._outputBuffer.push(msg);
                };
                return;
            };
            this.lowSend(msg);
        }

        public function toString():String
        {
            var status:String = "Server connection status:\n";
            status = (status + (("  Connected:       " + ((this._socket.connected) ? "Yes" : "No")) + "\n"));
            if (this._socket.connected)
            {
                status = (status + (((("  Connected to:    " + this._remoteSrvHost) + ":") + this._remoteSrvPort) + "\n"));
            }
            else
            {
                status = (status + (("  Connecting:      " + ((this._connecting) ? "Yes" : "No")) + "\n"));
            };
            if (this._connecting)
            {
                status = (status + (((("  Connecting to:   " + this._remoteSrvHost) + ":") + this._remoteSrvPort) + "\n"));
            };
            status = (status + (("  Raw parser:      " + this.rawParser) + "\n"));
            status = (status + (("  Message handler: " + this.handler) + "\n"));
            if (this._outputBuffer)
            {
                status = (status + (("  Output buffer:   " + this._outputBuffer.length) + " message(s)\n"));
            };
            if (this._inputBuffer)
            {
                status = (status + (("  Input buffer:    " + this._inputBuffer.length) + " byte(s)\n"));
            };
            if (this._splittedPacket)
            {
                status = (status + "  Splitted message in the input buffer:\n");
                status = (status + (("    Message ID:      " + this._splittedPacketId) + "\n"));
                status = (status + (("    Awaited length:  " + this._splittedPacketLength) + "\n"));
            };
            return (status);
        }

        public function pause():void
        {
            this._pause = true;
        }

        public function resume():void
        {
            var msg:INetworkMessage;
            this._pause = false;
            while (((this._pauseBuffer.length) && (!(this._pause))))
            {
                msg = this._pauseBuffer.shift();
                if (DEBUG_DATA)
                {
                    _log.trace(("[RCV] (after Resume) " + ((DEBUG_VERBOSE) ? this.inspect(msg) : msg)));
                };
                _log.logDirectly(new NetworkLogEvent(msg, true));
                this._handler.process(msg);
            };
            this._pauseBuffer = [];
        }

        public function stopConnectionTimeout():void
        {
            if (this._timeoutTimer)
            {
                this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onSocketTimeOut);
                this._timeoutTimer.stop();
                this._timeoutTimer = null;
            };
        }

        public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
        {
            this._socket.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        public function dispatchEvent(event:Event):Boolean
        {
            return (this._socket.dispatchEvent(event));
        }

        public function hasEventListener(type:String):Boolean
        {
            return (this._socket.hasEventListener(type));
        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
        {
            this._socket.removeEventListener(type, listener, useCapture);
        }

        public function willTrigger(type:String):Boolean
        {
            return (this._socket.willTrigger(type));
        }

        private function addListeners():void
        {
            this._socket.addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData, false, 0, true);
            this._socket.addEventListener(Event.CONNECT, this.onConnect, false, 0, true);
            this._socket.addEventListener(Event.CLOSE, this.onClose, false, 0, true);
            this._socket.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketError, false, 0, true);
            this._socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError, false, 0, true);
        }

        private function removeListeners():void
        {
            this._socket.removeEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
            this._socket.removeEventListener(Event.CONNECT, this.onConnect);
            this._socket.removeEventListener(Event.CLOSE, this.onClose);
            this._socket.removeEventListener(IOErrorEvent.IO_ERROR, this.onSocketError);
            this._socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
        }

        private function receive(src:IDataInput):void
        {
            var msg:INetworkMessage;
            if (DEBUG_LOW_LEVEL_VERBOSE)
            {
                _log.info(("Receive Event, byte available : " + src.bytesAvailable));
            };
            var count:uint;
            try
            {
                while (src.bytesAvailable > 0)
                {
                    msg = this.lowReceive(src);
                    if ((msg is INetworkDataContainerMessage))
                    {
                        while (INetworkDataContainerMessage(msg).content.bytesAvailable)
                        {
                            this.receive(INetworkDataContainerMessage(msg).content);
                        };
                    };
                    if (((!((msg == null))) && (!((msg is INetworkDataContainerMessage)))))
                    {
                        if (this._lagometer)
                        {
                            this._lagometer.pong(msg);
                        };
                        (msg as NetworkMessage).receptionTime = getTimer();
                        if (!(this._pause))
                        {
                            if (((((DEBUG_DATA) && (!((msg.getMessageId() == 176))))) && (!((msg.getMessageId() == 6362)))))
                            {
                                _log.trace(("[RCV] " + ((DEBUG_VERBOSE) ? this.inspect(msg) : msg)));
                            };
                            _log.logDirectly(new NetworkLogEvent(msg, true));
                            if (!(disabledIn))
                            {
                                this._handler.process(msg);
                            };
                        }
                        else
                        {
                            this._pauseBuffer.push(msg);
                        };
                    }
                    else
                    {
                        break;
                    };
                    count++;
                };
            }
            catch(e:Error)
            {
                if (e.getStackTrace())
                {
                    _log.error(("Error while reading socket. " + e.getStackTrace()));
                }
                else
                {
                    _log.error("Error while reading socket. No stack trace available");
                };
                close();
            };
        }

        private function getMessageId(firstOctet:uint):uint
        {
            return ((firstOctet >> NetworkMessage.BIT_RIGHT_SHIFT_LEN_PACKET_ID));
        }

        private function readMessageLength(staticHeader:uint, src:IDataInput):uint
        {
            var byteLenDynamicHeader:uint = (staticHeader & NetworkMessage.BIT_MASK);
            var messageLength:uint;
            switch (byteLenDynamicHeader)
            {
                case 0:
                    break;
                case 1:
                    messageLength = src.readUnsignedByte();
                    break;
                case 2:
                    messageLength = src.readUnsignedShort();
                    break;
                case 3:
                    messageLength = ((((src.readByte() & 0xFF) << 16) + ((src.readByte() & 0xFF) << 8)) + (src.readByte() & 0xFF));
                    break;
            };
            return (messageLength);
        }

        protected function lowSend(msg:INetworkMessage, autoFlush:Boolean=true):void
        {
            msg.pack(this._socket);
            this._latestSent = getTimer();
            this._lastSent = getTimer();
            this._sendSequenceId++;
            if (this._lagometer)
            {
                this._lagometer.ping(msg);
            };
            if (autoFlush)
            {
                this._socket.flush();
            };
        }

        protected function lowReceive(src:IDataInput):INetworkMessage
        {
            var msg:INetworkMessage;
            var staticHeader:uint;
            var messageId:uint;
            var messageLength:uint;
            if (!(this._splittedPacket))
            {
                if (src.bytesAvailable < 2)
                {
                    if (DEBUG_LOW_LEVEL_VERBOSE)
                    {
                        _log.info((("Not enought data to read the header, byte available : " + src.bytesAvailable) + " (needed : 2)"));
                    };
                    return (null);
                };
                staticHeader = src.readUnsignedShort();
                messageId = this.getMessageId(staticHeader);
                if (src.bytesAvailable >= (staticHeader & NetworkMessage.BIT_MASK))
                {
                    messageLength = this.readMessageLength(staticHeader, src);
                    if (src.bytesAvailable >= messageLength)
                    {
                        this.updateLatency();
                        msg = this._rawParser.parse(src, messageId, messageLength);
                        MEMORY_LOG[msg] = 1;
                        if (DEBUG_LOW_LEVEL_VERBOSE)
                        {
                            _log.info("Full parsing done");
                        };
                    }
                    else
                    {
                        if (DEBUG_LOW_LEVEL_VERBOSE)
                        {
                            _log.info((((("Not enought data to read msg content, byte available : " + src.bytesAvailable) + " (needed : ") + messageLength) + ")"));
                        };
                        this._staticHeader = -1;
                        this._splittedPacketLength = messageLength;
                        this._splittedPacketId = messageId;
                        this._splittedPacket = true;
                        this._socket.readBytes(this._inputBuffer, 0, src.bytesAvailable);
                        return (null);
                    };
                }
                else
                {
                    if (DEBUG_LOW_LEVEL_VERBOSE)
                    {
                        _log.info((((("Not enought data to read message ID, byte available : " + src.bytesAvailable) + " (needed : ") + (staticHeader & NetworkMessage.BIT_MASK)) + ")"));
                    };
                    this._staticHeader = staticHeader;
                    this._splittedPacketLength = messageLength;
                    this._splittedPacketId = messageId;
                    this._splittedPacket = true;
                    return (null);
                };
            }
            else
            {
                if (this._staticHeader != -1)
                {
                    this._splittedPacketLength = this.readMessageLength(this._staticHeader, src);
                    this._staticHeader = -1;
                };
                if ((src.bytesAvailable + this._inputBuffer.length) >= this._splittedPacketLength)
                {
                    src.readBytes(this._inputBuffer, this._inputBuffer.length, (this._splittedPacketLength - this._inputBuffer.length));
                    this._inputBuffer.position = 0;
                    this.updateLatency();
                    msg = this._rawParser.parse(this._inputBuffer, this._splittedPacketId, this._splittedPacketLength);
                    MEMORY_LOG[msg] = 1;
                    this._splittedPacket = false;
                    this._inputBuffer = new ByteArray();
                    return (msg);
                };
                src.readBytes(this._inputBuffer, this._inputBuffer.length, src.bytesAvailable);
                return (null);
            };
            return (msg);
        }

        private function updateLatency():void
        {
            if (((((this._pause) || ((this._pauseBuffer.length > 0)))) || ((this._latestSent == 0))))
            {
                return;
            };
            var packetReceived:uint = getTimer();
            var latency:uint = (packetReceived - this._latestSent);
            this._latestSent = 0;
            this._latencyBuffer.push(latency);
            if (this._latencyBuffer.length > LATENCY_AVG_BUFFER_SIZE)
            {
                this._latencyBuffer.shift();
            };
        }

        protected function onConnect(e:Event):void
        {
            var msg:INetworkMessage;
            this._connecting = false;
            if (this._timeoutTimer)
            {
                this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onSocketTimeOut);
                this._timeoutTimer.stop();
                this._timeoutTimer = null;
            };
            if (DEBUG_DATA)
            {
                _log.trace("Connection opened.");
            };
            for each (msg in this._outputBuffer)
            {
                this.lowSend(msg, false);
            };
            this._socket.flush();
            this._inputBuffer = new ByteArray();
            this._outputBuffer = new Array();
            if (this._handler)
            {
                this._handler.process(new ConnectedMessage());
            };
        }

        protected function onClose(e:Event):void
        {
            if (DEBUG_DATA)
            {
                _log.trace("Connection closed.");
            };
            setTimeout(this.removeListeners, 30000);
            if (this._lagometer)
            {
                this._lagometer.stop();
            };
            this._handler.process(new ServerConnectionClosedMessage(this));
            this._connecting = false;
            this._outputBuffer = new Array();
        }

        protected function onSocketData(pe:ProgressEvent):void
        {
            this.receive(this._socket);
        }

        protected function onSocketError(e:IOErrorEvent):void
        {
            if (this._lagometer)
            {
                this._lagometer.stop();
            };
            _log.error("Failure while opening socket.");
            this._connecting = false;
            this._handler.process(new ServerConnectionFailedMessage(this, e.text));
        }

        protected function onSocketTimeOut(e:Event):void
        {
            if (this._lagometer)
            {
                this._lagometer.stop();
            };
            _log.error("Failure while opening socket, timeout.");
            this._connecting = false;
            this._handler.process(new ServerConnectionFailedMessage(this, "timeout§§§"));
        }

        protected function onSecurityError(see:SecurityErrorEvent):void
        {
            if (this._lagometer)
            {
                this._lagometer.stop();
            };
            if (this._socket..connected)
            {
                _log.error(("Security error while connected : " + see.text));
                this._handler.process(new ServerConnectionFailedMessage(this, see.text));
            }
            else
            {
                _log.error(("Security error while disconnected : " + see.text));
            };
        }


    }
}//package com.ankamagames.jerakine.network

