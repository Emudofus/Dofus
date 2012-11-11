package com.ankamagames.jerakine.network
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.messages.*;
    import com.ankamagames.jerakine.replay.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class ServerConnection extends Socket implements IEventDispatcher, IServerConnection
    {
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
        public static var disabled:Boolean;
        public static var disabledIn:Boolean;
        public static var disabledOut:Boolean;
        private static const DEBUG_DATA:Boolean = true;
        private static const LATENCY_AVG_BUFFER_SIZE:uint = 50;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerConnection));

        public function ServerConnection(param1:String = null, param2:int = 0)
        {
            this._pauseBuffer = new Array();
            this._latencyBuffer = new Array();
            super(param1, param2);
            this._remoteSrvHost = param1;
            this._remoteSrvPort = param2;
            return;
        }// end function

        public function get rawParser() : RawDataParser
        {
            return this._rawParser;
        }// end function

        public function set rawParser(param1:RawDataParser) : void
        {
            this._rawParser = param1;
            return;
        }// end function

        public function get handler() : MessageHandler
        {
            return this._handler;
        }// end function

        public function set handler(param1:MessageHandler) : void
        {
            this._handler = param1;
            return;
        }// end function

        public function get latencyAvg() : uint
        {
            var _loc_2:* = 0;
            if (this._latencyBuffer.length == 0)
            {
                return 0;
            }
            var _loc_1:* = 0;
            for each (_loc_2 in this._latencyBuffer)
            {
                
                _loc_1 = _loc_1 + _loc_2;
            }
            return _loc_1 / this._latencyBuffer.length;
        }// end function

        public function get latencySamplesCount() : uint
        {
            return this._latencyBuffer.length;
        }// end function

        public function get latencySamplesMax() : uint
        {
            return LATENCY_AVG_BUFFER_SIZE;
        }// end function

        public function get port() : uint
        {
            return this._remoteSrvPort;
        }// end function

        public function get lastSent() : uint
        {
            return this._lastSent;
        }// end function

        public function set lagometer(param1:ILagometer) : void
        {
            this._lagometer = param1;
            return;
        }// end function

        public function get lagometer() : ILagometer
        {
            return this._lagometer;
        }// end function

        override public function connect(param1:String, param2:int) : void
        {
            if (this._connecting || disabled || disabledIn && disabledOut)
            {
                return;
            }
            this._connecting = true;
            this._remoteSrvHost = param1;
            this._remoteSrvPort = param2;
            this.addListeners();
            _log.trace("Connecting to " + param1 + ":" + param2 + "...");
            super.connect(param1, param2);
            this._timeoutTimer = new Timer(10000, 1);
            this._timeoutTimer.start();
            this._timeoutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onSocketTimeOut);
            return;
        }// end function

        public function send(param1:INetworkMessage) : void
        {
            if (DEBUG_DATA)
            {
                _log.trace("[SND] " + param1);
            }
            LogFrame.log(LogTypeEnum.NETWORK_OUT, param1);
            if (disabled || disabledOut)
            {
                return;
            }
            if (!param1.isInitialized)
            {
                _log.warn("Sending non-initialized packet " + param1 + " !");
            }
            if (!connected)
            {
                if (this._connecting)
                {
                    this._outputBuffer.push(param1);
                }
                return;
            }
            if (this._lagometer)
            {
                this._lagometer.ping();
            }
            this.lowSend(param1);
            return;
        }// end function

        override public function toString() : String
        {
            var _loc_1:* = "Server connection status:\n";
            _loc_1 = _loc_1 + ("  Connected:       " + (connected ? ("Yes") : ("No")) + "\n");
            if (connected)
            {
                _loc_1 = _loc_1 + ("  Connected to:    " + this._remoteSrvHost + ":" + this._remoteSrvPort + "\n");
            }
            else
            {
                _loc_1 = _loc_1 + ("  Connecting:      " + (this._connecting ? ("Yes") : ("No")) + "\n");
            }
            if (this._connecting)
            {
                _loc_1 = _loc_1 + ("  Connecting to:   " + this._remoteSrvHost + ":" + this._remoteSrvPort + "\n");
            }
            _loc_1 = _loc_1 + ("  Raw parser:      " + this.rawParser + "\n");
            _loc_1 = _loc_1 + ("  Message handler: " + this.handler + "\n");
            if (this._outputBuffer)
            {
                _loc_1 = _loc_1 + ("  Output buffer:   " + this._outputBuffer.length + " message(s)\n");
            }
            if (this._inputBuffer)
            {
                _loc_1 = _loc_1 + ("  Input buffer:    " + this._inputBuffer.length + " byte(s)\n");
            }
            if (this._splittedPacket)
            {
                _loc_1 = _loc_1 + "  Splitted message in the input buffer:\n";
                _loc_1 = _loc_1 + ("    Message ID:      " + this._splittedPacketId + "\n");
                _loc_1 = _loc_1 + ("    Awaited length:  " + this._splittedPacketLength + "\n");
            }
            return _loc_1;
        }// end function

        public function pause() : void
        {
            this._pause = true;
            return;
        }// end function

        public function resume() : void
        {
            var _loc_1:* = null;
            this._pause = false;
            while (this._pauseBuffer.length && !this._pause)
            {
                
                _loc_1 = this._pauseBuffer.shift();
                if (DEBUG_DATA)
                {
                    _log.trace("[RCV] " + _loc_1);
                }
                _log.logDirectly(new NetworkLogEvent(_loc_1, true));
                this._handler.process(_loc_1);
            }
            this._pauseBuffer = [];
            return;
        }// end function

        public function stopConnectionTimeout() : void
        {
            if (this._timeoutTimer)
            {
                this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onSocketTimeOut);
                this._timeoutTimer.stop();
                this._timeoutTimer = null;
            }
            return;
        }// end function

        private function addListeners() : void
        {
            addEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData, false, 0, true);
            addEventListener(Event.CONNECT, this.onConnect, false, 0, true);
            addEventListener(Event.CLOSE, this.onClose, false, 0, true);
            addEventListener(IOErrorEvent.IO_ERROR, this.onSocketError, false, 0, true);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError, false, 0, true);
            return;
        }// end function

        private function removeListeners() : void
        {
            removeEventListener(ProgressEvent.SOCKET_DATA, this.onSocketData);
            removeEventListener(Event.CONNECT, this.onConnect);
            removeEventListener(Event.CLOSE, this.onClose);
            removeEventListener(IOErrorEvent.IO_ERROR, this.onSocketError);
            removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            return;
        }// end function

        private function receive(param1:IDataInput) : void
        {
            var msg:INetworkMessage;
            var src:* = param1;
            if (this._lagometer)
            {
                this._lagometer.pong();
            }
            var count:uint;
            try
            {
                while (src.bytesAvailable > 0)
                {
                    
                    msg = this.lowReceive(src);
                    if (msg is INetworkDataContainerMessage)
                    {
                        while (INetworkDataContainerMessage(msg).content.bytesAvailable)
                        {
                            
                            this.receive(INetworkDataContainerMessage(msg).content);
                        }
                    }
                    if (msg != null && !(msg is INetworkDataContainerMessage))
                    {
                        if (!this._pause)
                        {
                            if (DEBUG_DATA)
                            {
                                _log.trace("[RCV] " + msg);
                            }
                            _log.logDirectly(new NetworkLogEvent(msg, true));
                            if (!disabledIn)
                            {
                                this._handler.process(msg);
                            }
                        }
                        else
                        {
                            this._pauseBuffer.push(msg);
                        }
                    }
                    else
                    {
                        break;
                    }
                    count = (count + 1);
                }
            }
            catch (e:Error)
            {
                if (e.getStackTrace())
                {
                    _log.error("Error while reading socket. " + e.getStackTrace());
                }
                else
                {
                    _log.error("Error while reading socket. No stack trace available");
                }
                close();
            }
            return;
        }// end function

        private function getMessageId(param1:uint) : uint
        {
            return param1 >> NetworkMessage.BIT_RIGHT_SHIFT_LEN_PACKET_ID;
        }// end function

        private function readMessageLength(param1:uint, param2:IDataInput) : uint
        {
            var _loc_3:* = param1 & NetworkMessage.BIT_MASK;
            var _loc_4:* = 0;
            switch(_loc_3)
            {
                case 0:
                {
                    break;
                }
                case 1:
                {
                    _loc_4 = param2.readUnsignedByte();
                    break;
                }
                case 2:
                {
                    _loc_4 = param2.readUnsignedShort();
                    break;
                }
                case 3:
                {
                    _loc_4 = ((param2.readByte() & 255) << 16) + ((param2.readByte() & 255) << 8) + (param2.readByte() & 255);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_4;
        }// end function

        protected function lowSend(param1:INetworkMessage, param2:Boolean = true) : void
        {
            param1.pack(this);
            this._latestSent = getTimer();
            this._lastSent = getTimer();
            if (param2)
            {
                flush();
            }
            return;
        }// end function

        protected function lowReceive(param1:IDataInput) : INetworkMessage
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (!this._splittedPacket)
            {
                if (param1.bytesAvailable < 2)
                {
                    return null;
                }
                _loc_3 = param1.readUnsignedShort();
                _loc_4 = this.getMessageId(_loc_3);
                if (param1.bytesAvailable >= (_loc_3 & NetworkMessage.BIT_MASK))
                {
                    _loc_5 = this.readMessageLength(_loc_3, param1);
                    if (param1.bytesAvailable >= _loc_5)
                    {
                        this.updateLatency();
                        _loc_2 = this._rawParser.parse(param1, _loc_4, _loc_5);
                        MEMORY_LOG[_loc_2] = 1;
                    }
                    else
                    {
                        this._staticHeader = -1;
                        this._splittedPacketLength = _loc_5;
                        this._splittedPacketId = _loc_4;
                        this._splittedPacket = true;
                        readBytes(this._inputBuffer, 0, param1.bytesAvailable);
                        return null;
                    }
                }
                else
                {
                    this._staticHeader = _loc_3;
                    this._splittedPacketLength = _loc_5;
                    this._splittedPacketId = _loc_4;
                    this._splittedPacket = true;
                    return null;
                }
            }
            else
            {
                if (this._staticHeader != -1)
                {
                    this._splittedPacketLength = this.readMessageLength(this._staticHeader, param1);
                    this._staticHeader = -1;
                }
                if (param1.bytesAvailable + this._inputBuffer.length >= this._splittedPacketLength)
                {
                    param1.readBytes(this._inputBuffer, this._inputBuffer.length, this._splittedPacketLength - this._inputBuffer.length);
                    this._inputBuffer.position = 0;
                    this.updateLatency();
                    _loc_2 = this._rawParser.parse(this._inputBuffer, this._splittedPacketId, this._splittedPacketLength);
                    MEMORY_LOG[_loc_2] = 1;
                    this._splittedPacket = false;
                    this._inputBuffer = new ByteArray();
                    return _loc_2;
                }
                param1.readBytes(this._inputBuffer, this._inputBuffer.length, param1.bytesAvailable);
                return null;
            }
            return _loc_2;
        }// end function

        private function updateLatency() : void
        {
            if (this._pause || this._pauseBuffer.length > 0 || this._latestSent == 0)
            {
                return;
            }
            var _loc_1:* = getTimer();
            var _loc_2:* = _loc_1 - this._latestSent;
            this._latestSent = 0;
            this._latencyBuffer.push(_loc_2);
            if (this._latencyBuffer.length > LATENCY_AVG_BUFFER_SIZE)
            {
                this._latencyBuffer.shift();
            }
            return;
        }// end function

        protected function onConnect(event:Event) : void
        {
            var _loc_2:* = null;
            this._connecting = false;
            if (this._timeoutTimer)
            {
                this._timeoutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onSocketTimeOut);
                this._timeoutTimer.stop();
                this._timeoutTimer = null;
            }
            if (DEBUG_DATA)
            {
                _log.trace("Connection opened.");
            }
            for each (_loc_2 in this._outputBuffer)
            {
                
                this.lowSend(_loc_2, false);
            }
            flush();
            this._inputBuffer = new ByteArray();
            this._outputBuffer = new Array();
            return;
        }// end function

        protected function onClose(event:Event) : void
        {
            if (DEBUG_DATA)
            {
                _log.trace("Connection closed.");
            }
            setTimeout(this.removeListeners, 30000);
            if (this._lagometer)
            {
                this._lagometer.stop();
            }
            this._handler.process(new ServerConnectionClosedMessage(this));
            this._connecting = false;
            this._outputBuffer = new Array();
            return;
        }// end function

        protected function onSocketData(event:ProgressEvent) : void
        {
            this.receive(this);
            return;
        }// end function

        protected function onSocketError(event:IOErrorEvent) : void
        {
            if (this._lagometer)
            {
                this._lagometer.stop();
            }
            _log.error("Failure while opening socket.");
            this._connecting = false;
            this._handler.process(new ServerConnectionFailedMessage(this, event.text));
            return;
        }// end function

        protected function onSocketTimeOut(event:Event) : void
        {
            if (this._lagometer)
            {
                this._lagometer.stop();
            }
            _log.error("Failure while opening socket, timeout.");
            this._connecting = false;
            this._handler.process(new ServerConnectionFailedMessage(this, "timeout§§§"));
            return;
        }// end function

        protected function onSecurityError(event:SecurityErrorEvent) : void
        {
            if (this._lagometer)
            {
                this._lagometer.stop();
            }
            if (this.connected)
            {
                _log.error("Security error while connected : " + event.text);
                this._handler.process(new ServerConnectionFailedMessage(this, event.text));
            }
            else
            {
                _log.error("Security error while disconnected : " + event.text);
            }
            return;
        }// end function

    }
}
