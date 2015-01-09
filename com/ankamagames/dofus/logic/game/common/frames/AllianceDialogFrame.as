package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceCreationValidAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceCreationValidMessage;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationValidAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationValidMessage;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationNameAndTagValidAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationNameAndTagValidMessage;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceModificationEmblemValidAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceModificationEmblemValidMessage;
    import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceInvitationAnswerAction;
    import com.ankamagames.dofus.network.messages.game.alliance.AllianceInvitationAnswerMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;

    public class AllianceDialogFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceDialogFrame));

        private var allianceEmblem:GuildEmblem;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:AllianceCreationValidAction;
            var _local_3:AllianceCreationValidMessage;
            var _local_4:AllianceModificationValidAction;
            var _local_5:AllianceModificationValidMessage;
            var _local_6:AllianceModificationNameAndTagValidAction;
            var _local_7:AllianceModificationNameAndTagValidMessage;
            var _local_8:AllianceModificationEmblemValidAction;
            var _local_9:AllianceModificationEmblemValidMessage;
            var _local_10:AllianceInvitationAnswerAction;
            var _local_11:AllianceInvitationAnswerMessage;
            var _local_12:LeaveDialogMessage;
            switch (true)
            {
                case (msg is AllianceCreationValidAction):
                    _local_2 = (msg as AllianceCreationValidAction);
                    this.allianceEmblem = new GuildEmblem();
                    this.allianceEmblem.symbolShape = _local_2.upEmblemId;
                    this.allianceEmblem.symbolColor = _local_2.upColorEmblem;
                    this.allianceEmblem.backgroundShape = _local_2.backEmblemId;
                    this.allianceEmblem.backgroundColor = _local_2.backColorEmblem;
                    _local_3 = new AllianceCreationValidMessage();
                    _local_3.initAllianceCreationValidMessage(_local_2.allianceName, _local_2.allianceTag, this.allianceEmblem);
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is AllianceModificationValidAction):
                    _local_4 = (msg as AllianceModificationValidAction);
                    this.allianceEmblem = new GuildEmblem();
                    this.allianceEmblem.symbolShape = _local_4.upEmblemId;
                    this.allianceEmblem.symbolColor = _local_4.upColorEmblem;
                    this.allianceEmblem.backgroundShape = _local_4.backEmblemId;
                    this.allianceEmblem.backgroundColor = _local_4.backColorEmblem;
                    _local_5 = new AllianceModificationValidMessage();
                    _local_5.initAllianceModificationValidMessage(_local_4.name, _local_4.tag, this.allianceEmblem);
                    ConnectionsHandler.getConnection().send(_local_5);
                    return (true);
                case (msg is AllianceModificationNameAndTagValidAction):
                    _local_6 = (msg as AllianceModificationNameAndTagValidAction);
                    _local_7 = new AllianceModificationNameAndTagValidMessage();
                    _local_7.initAllianceModificationNameAndTagValidMessage(_local_6.name, _local_6.tag);
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is AllianceModificationEmblemValidAction):
                    _local_8 = (msg as AllianceModificationEmblemValidAction);
                    this.allianceEmblem = new GuildEmblem();
                    this.allianceEmblem.symbolShape = _local_8.upEmblemId;
                    this.allianceEmblem.symbolColor = _local_8.upColorEmblem;
                    this.allianceEmblem.backgroundShape = _local_8.backEmblemId;
                    this.allianceEmblem.backgroundColor = _local_8.backColorEmblem;
                    _local_9 = new AllianceModificationEmblemValidMessage();
                    _local_9.initAllianceModificationEmblemValidMessage(this.allianceEmblem);
                    ConnectionsHandler.getConnection().send(_local_9);
                    return (true);
                case (msg is AllianceInvitationAnswerAction):
                    _local_10 = (msg as AllianceInvitationAnswerAction);
                    _local_11 = new AllianceInvitationAnswerMessage();
                    _local_11.initAllianceInvitationAnswerMessage(_local_10.accept);
                    ConnectionsHandler.getConnection().send(_local_11);
                    this.leaveDialog();
                    return (true);
                case (msg is LeaveDialogMessage):
                    _local_12 = (msg as LeaveDialogMessage);
                    if ((((((_local_12.dialogType == DialogTypeEnum.DIALOG_ALLIANCE_CREATE)) || ((_local_12.dialogType == DialogTypeEnum.DIALOG_ALLIANCE_INVITATION)))) || ((_local_12.dialogType == DialogTypeEnum.DIALOG_ALLIANCE_RENAME))))
                    {
                        this.leaveDialog();
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
            return (true);
        }

        private function leaveDialog():void
        {
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
            Kernel.getWorker().removeFrame(this);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

