package com.ankamagames.dofus.logic.connection.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.common.basic.*;
    import com.ankamagames.dofus.network.messages.handshake.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.events.*;
    import flash.utils.*;

    public class HandshakeFrame extends Object implements Frame
    {
        private var _timeOutTimer:Timer;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(HandshakeFrame));

        public function HandshakeFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.HIGHEST;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            ConnectionsHandler.hasReceivedMsg = true;
            if (param1 is INetworkMessage && this._timeOutTimer)
            {
                this._timeOutTimer.stop();
            }
            switch(true)
            {
                case param1 is ProtocolRequired:
                {
                    _loc_2 = param1 as ProtocolRequired;
                    if (_loc_2.requiredVersion > Metadata.PROTOCOL_BUILD)
                    {
                        _log.fatal("Current protocol build is " + Metadata.PROTOCOL_BUILD + ", required build is " + _loc_2.requiredVersion + ".");
                        Kernel.panic(PanicMessages.PROTOCOL_TOO_OLD, [Metadata.PROTOCOL_BUILD, _loc_2.requiredVersion]);
                    }
                    if (_loc_2.currentVersion < Metadata.PROTOCOL_REQUIRED_BUILD)
                    {
                        _log.fatal("Current protocol build (" + Metadata.PROTOCOL_BUILD + ") is too new for the server version (" + _loc_2.currentVersion + ").");
                        _loc_3 = Kernel.getWorker().getFrame(AuthorizedFrame) as AuthorizedFrame;
                        if (BuildInfos.BUILD_TYPE >= BuildTypeEnum.TESTING || _loc_3.isFantomas())
                        {
                            _loc_4 = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                            _loc_4.openPopup(I18n.getUiText("ui.popup.warning"), I18n.getUiText("ui.popup.protocolError", [Metadata.PROTOCOL_BUILD, _loc_2.currentVersion]), [I18n.getUiText("ui.common.ok")]);
                        }
                    }
                    Kernel.getWorker().removeFrame(this);
                    return true;
                }
                case param1 is ConnectedMessage:
                {
                    this._timeOutTimer = new Timer(3000, 1);
                    this._timeOutTimer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
                    this._timeOutTimer.start();
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function onTimeOut(event:TimerEvent) : void
        {
            var _loc_2:* = new BasicPingMessage();
            _loc_2.initBasicPingMessage(true);
            ConnectionsHandler.getConnection().send(_loc_2);
            return;
        }// end function

        public function pulled() : Boolean
        {
            if (this._timeOutTimer)
            {
                this._timeOutTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimeOut);
            }
            return true;
        }// end function

    }
}
