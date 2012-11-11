package com.ankamagames.dofus.kernel.sound.manager
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.protocolAudio.*;
    import com.ankamagames.jerakine.sound.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;

    public class RegConnectionManager extends Object
    {
        private var _sock:Socket;
        private var _socketClientID:Number;
        private var _socketAvaible:Boolean;
        private var _buffer:Array;
        private var _isMain:Boolean = true;
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(RegConnectionManager));
        private static var _self:RegConnectionManager;

        public function RegConnectionManager(param1:SingletonEnforcer)
        {
            if (_self)
            {
                throw new Error("RegConnectionManager is a Singleton");
            }
            this.init();
            return;
        }// end function

        public function get socketClientID() : Number
        {
            return this._socketClientID;
        }// end function

        public function get socketAvailable() : Boolean
        {
            return this._socketAvaible;
        }// end function

        public function get isMain() : Boolean
        {
            return this._isMain;
        }// end function

        public function send(param1:String, ... args) : void
        {
            if (!this._socketAvaible)
            {
                this._buffer.push({method:param1, params:args});
                return;
            }
            if (param1 == ProtocolEnum.SAY_GOODBYE)
            {
                this._sock.writeUTFBytes(String(0));
                this._sock.writeUTFBytes("=>" + param1 + "();" + this._socketClientID + "=>" + ProtocolEnum.PLAY_SOUND + "(10,100)");
                this._sock.writeUTFBytes("|");
                this._sock.flush();
            }
            else
            {
                this._sock.writeUTFBytes(String(this._socketClientID));
                this._sock.writeUTFBytes("=>" + param1 + "(" + args + ")");
                this._sock.writeUTFBytes("|");
                this._sock.flush();
            }
            return;
        }// end function

        private function init() : void
        {
            this._socketClientID = new Date().time;
            if (AirScanner.isStreamingVersion())
            {
                _log.debug("init flash sound sender");
                this._sock = new FlashSoundSender(Dofus.getInstance().REG_LOCAL_CONNECTION_ID);
            }
            else
            {
                _log.debug("init socket");
                this._sock = new Socket();
            }
            this._sock.addEventListener(ProgressEvent.SOCKET_DATA, this.onData);
            this._sock.addEventListener(Event.CONNECT, this.onSocketConnect);
            this._sock.addEventListener(Event.CLOSE, this.onSocketClose);
            this._sock.addEventListener(IOErrorEvent.IO_ERROR, this.onSocketError);
            this._sock.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSocketSecurityError);
            if (CommandLineArguments.getInstance().hasArgument("reg-client-port"))
            {
                this._sock.connect("localhost", int(CommandLineArguments.getInstance().getArgument("reg-client-port")));
            }
            else
            {
                this._sock.connect("localhost", 8081);
            }
            this._buffer = [];
            return;
        }// end function

        private function showInformationPopup() : void
        {
            var _loc_1:* = null;
            if (UiModuleManager.getInstance().getModule("Ankama_Common"))
            {
                _loc_1 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                if (_loc_1)
                {
                    _loc_1.openPopup(I18n.getUiText("ui.popup.warning"), I18n.getUiText("ui.common.soundsDeactivated"), [I18n.getUiText("ui.common.ok")]);
                }
            }
            return;
        }// end function

        private function setAsMain(param1:Boolean) : void
        {
            if (param1 == this._isMain)
            {
                return;
            }
            this._isMain = param1;
            if (param1 == true)
            {
                _log.warn("[" + this._socketClientID + "] Je passe en main");
                if (SoundManager.getInstance().manager is RegSoundManager)
                {
                    (SoundManager.getInstance().manager as RegSoundManager).playMainClientSounds();
                }
            }
            else
            {
                _log.warn("[" + this._socketClientID + "] Je ne suis plus main");
                if (SoundManager.getInstance().manager is RegSoundManager)
                {
                    (SoundManager.getInstance().manager as RegSoundManager).stopMainClientSounds();
                }
            }
            return;
        }// end function

        private function onSocketClose(event:Event) : void
        {
            var e:* = event;
            this._socketAvaible = false;
            _log.error("The socket has been closed");
            try
            {
                this.showInformationPopup();
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function onData(event:ProgressEvent) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = NaN;
            var _loc_2:* = this._sock.readUTFBytes(event.bytesLoaded).split("|");
            for each (_loc_3 in _loc_2)
            {
                
                if (_loc_3 == "")
                {
                    return;
                }
                _log.info("[REG->DOFUS] " + _loc_3);
                _loc_4 = _loc_3.split("(")[0];
                switch(_loc_4)
                {
                    case ProtocolEnum.REG_SHUT_DOWN:
                    {
                        this._socketAvaible = false;
                        _log.error("The socket connection with REG has been lost");
                        this.showInformationPopup();
                        break;
                    }
                    case ProtocolEnum.REG_IS_UP:
                    {
                        this._socketAvaible = true;
                        _log.info("The socket connection with REG has been established");
                        break;
                    }
                    case ProtocolEnum.PING:
                    {
                        _log.info("receive ping request from reg, send pong");
                        this.send(ProtocolEnum.PONG);
                        break;
                    }
                    case ProtocolEnum.MAIN_CLIENT_IS:
                    {
                        _loc_5 = Number(_loc_3.split(":")[1]);
                        if (_loc_5 == this._socketClientID)
                        {
                            this.setAsMain(true);
                        }
                        else
                        {
                            this.setAsMain(false);
                        }
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function onSocketError(event:Event) : void
        {
            this._socketAvaible = false;
            _log.error("Connection to Reg failed");
            return;
        }// end function

        private function onSocketSecurityError(event:Event) : void
        {
            return;
        }// end function

        private function onSocketConnect(event:Event) : void
        {
            var _loc_2:* = null;
            this._socketAvaible = true;
            if (this._buffer.length)
            {
                while (this._buffer.length)
                {
                    
                    _loc_2 = this._buffer.shift();
                    CallWithParameters.call(this.send, ([_loc_2.method] as Array).concat(_loc_2.params));
                }
            }
            return;
        }// end function

        public static function getInstance() : RegConnectionManager
        {
            if (_self == null)
            {
                _self = new RegConnectionManager(new SingletonEnforcer());
            }
            return _self;
        }// end function

    }
}

import com.ankamagames.berilia.managers.*;

import com.ankamagames.dofus.kernel.sound.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.protocolAudio.*;

import com.ankamagames.jerakine.sound.*;

import com.ankamagames.jerakine.utils.misc.*;

import com.ankamagames.jerakine.utils.system.*;

import flash.events.*;

import flash.net.*;

import flash.utils.*;

class SingletonEnforcer extends Object
{

    function SingletonEnforcer()
    {
        return;
    }// end function

}

