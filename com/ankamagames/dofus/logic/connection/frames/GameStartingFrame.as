package com.ankamagames.dofus.logic.connection.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.kernel.sound.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.logic.connection.messages.*;
    import com.ankamagames.dofus.logic.game.common.actions.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.misc.utils.*;
    import com.ankamagames.dofus.misc.utils.mapeditor.*;
    import com.ankamagames.dofus.network.messages.server.basic.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class GameStartingFrame extends Object implements Frame
    {
        private var _worker:Worker;
        private var m:MapEditorManager;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GameStartingFrame));

        public function GameStartingFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            this._worker = Kernel.getWorker();
            this.m = new MapEditorManager();
            Dofus.getInstance().renameApp("Dofus");
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:DelayedSystemMessageDisplayMessage = null;
            var _loc_3:SystemMessageDisplayMessage = null;
            var _loc_4:DelayedSystemMessageDisplayMessage = null;
            switch(true)
            {
                case param1 is DelayedSystemMessageDisplayMessage:
                {
                    _loc_2 = param1 as DelayedSystemMessageDisplayMessage;
                    this.systemMessageDisplay(_loc_2);
                    return true;
                }
                case param1 is SystemMessageDisplayMessage:
                {
                    _loc_3 = param1 as SystemMessageDisplayMessage;
                    if (_loc_3.hangUp)
                    {
                        ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.DISCONNECTED_BY_POPUP);
                        _loc_4 = new DelayedSystemMessageDisplayMessage();
                        _loc_4.initDelayedSystemMessageDisplayMessage(_loc_3.hangUp, _loc_3.msgId, _loc_3.parameters);
                        DisconnectionHandlerFrame.messagesAfterReset.push(_loc_4);
                    }
                    this.systemMessageDisplay(_loc_3);
                    return true;
                }
                case param1 is OpenMainMenuAction:
                {
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMainMenu);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

        private function systemMessageDisplay(param1:SystemMessageDisplayMessage) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:uint = 0;
            var _loc_2:* = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            var _loc_3:* = new Array();
            for each (_loc_4 in param1.parameters)
            {
                
                _loc_3.push(_loc_4);
            }
            if (InfoMessage.getInfoMessageById(40000 + param1.msgId) && InfoMessage.getInfoMessageById(40000 + param1.msgId).textId)
            {
                _loc_5 = InfoMessage.getInfoMessageById(40000 + param1.msgId).textId;
            }
            else
            {
                _log.error("Information message " + (40000 + param1.msgId) + " cannot be found.");
                _loc_5 = InfoMessage.getInfoMessageById(207).textId;
                _loc_3 = new Array();
                _loc_3.push(param1.msgId);
            }
            var _loc_6:* = I18n.getText(_loc_5);
            if (I18n.getText(_loc_5))
            {
                _loc_6 = ParamsDecoder.applyParams(_loc_6, _loc_3);
            }
            else
            {
                return;
            }
            _loc_2.openPopup(I18n.getUiText("ui.popup.warning"), _loc_6, [I18n.getUiText("ui.common.ok")], null, null, null, null, false, true);
            SoundManager.getInstance().manager.removeAllSounds();
            return;
        }// end function

    }
}
