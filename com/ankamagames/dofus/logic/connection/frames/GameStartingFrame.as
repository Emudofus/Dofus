package com.ankamagames.dofus.logic.connection.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.messages.Worker;
    import com.ankamagames.dofus.misc.utils.mapeditor.MapEditorManager;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.connection.messages.GameStartingMessage;
    import com.ankamagames.dofus.logic.connection.messages.DelayedSystemMessageDisplayMessage;
    import com.ankamagames.dofus.network.messages.server.basic.SystemMessageDisplayMessage;
    import com.ankamagames.dofus.logic.common.actions.AgreementAgreedAction;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
    import com.ankamagames.dofus.logic.common.frames.DisconnectionHandlerFrame;
    import com.ankamagames.jerakine.data.XmlConfig;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.jerakine.managers.OptionManager;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.common.actions.OpenMainMenuAction;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.managers.UiModuleManager;
    import com.ankamagames.dofus.datacenter.communication.InfoMessage;
    import com.ankamagames.dofus.misc.utils.ParamsDecoder;
    import com.ankamagames.dofus.kernel.sound.SoundManager;

    public class GameStartingFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GameStartingFrame));

        private var _worker:Worker;
        private var m:MapEditorManager;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            this._worker = Kernel.getWorker();
            this.m = new MapEditorManager();
            Kernel.getWorker().process(new GameStartingMessage());
            Dofus.getInstance().renameApp("Dofus");
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:DelayedSystemMessageDisplayMessage;
            var _local_3:SystemMessageDisplayMessage;
            var _local_4:AgreementAgreedAction;
            var _local_5:String;
            var dsmdmsg2:DelayedSystemMessageDisplayMessage;
            switch (true)
            {
                case (msg is DelayedSystemMessageDisplayMessage):
                    _local_2 = (msg as DelayedSystemMessageDisplayMessage);
                    this.systemMessageDisplay(_local_2);
                    return (true);
                case (msg is SystemMessageDisplayMessage):
                    _local_3 = (msg as SystemMessageDisplayMessage);
                    if (_local_3.hangUp)
                    {
                        ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.DISCONNECTED_BY_POPUP);
                        dsmdmsg2 = new DelayedSystemMessageDisplayMessage();
                        dsmdmsg2.initDelayedSystemMessageDisplayMessage(_local_3.hangUp, _local_3.msgId, _local_3.parameters);
                        DisconnectionHandlerFrame.messagesAfterReset.push(dsmdmsg2);
                    };
                    this.systemMessageDisplay(_local_3);
                    return (true);
                case (msg is AgreementAgreedAction):
                    _local_4 = AgreementAgreedAction(msg);
                    if (_local_4.fileName == "tou")
                    {
                        _local_5 = ((XmlConfig.getInstance().getEntry("config.lang.current") + "#") + (I18n.getUiText("ui.legal.tou1") + I18n.getUiText("ui.legal.tou2")).length);
                        OptionManager.getOptionManager("dofus")["legalAgreementTou"] = _local_5;
                    };
                    if (_local_4.fileName == "modstou")
                    {
                        _local_5 = ((XmlConfig.getInstance().getEntry("config.lang.current") + "#") + I18n.getUiText("ui.legal.modstou").length);
                        OptionManager.getOptionManager("dofus")["legalAgreementModsTou"] = _local_5;
                    };
                    return (true);
                case (msg is OpenMainMenuAction):
                    KernelEventsManager.getInstance().processCallback(HookList.OpenMainMenu);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        private function systemMessageDisplay(msg:SystemMessageDisplayMessage):void
        {
            var i:*;
            var textId:uint;
            var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
            var a:Array = new Array();
            for each (i in msg.parameters)
            {
                a.push(i);
            };
            if (((InfoMessage.getInfoMessageById((40000 + msg.msgId))) && (InfoMessage.getInfoMessageById((40000 + msg.msgId)).textId)))
            {
                textId = InfoMessage.getInfoMessageById((40000 + msg.msgId)).textId;
            }
            else
            {
                _log.error((("Information message " + (40000 + msg.msgId)) + " cannot be found."));
                textId = InfoMessage.getInfoMessageById(207).textId;
                a = new Array();
                a.push(msg.msgId);
            };
            var msgContent:String = I18n.getText(textId);
            if (msgContent)
            {
                msgContent = ParamsDecoder.applyParams(msgContent, a);
            }
            else
            {
                return;
            };
            commonMod.openPopup(I18n.getUiText("ui.popup.warning"), msgContent, [I18n.getUiText("ui.common.ok")], null, null, null, null, false, true);
            SoundManager.getInstance().manager.removeAllSounds();
        }


    }
}//package com.ankamagames.dofus.logic.connection.frames

