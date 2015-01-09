package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildCreationValidAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildCreationValidMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationValidAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildModificationValidMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationNameValidAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildModificationNameValidMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildModificationEmblemValidAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildModificationEmblemValidMessage;
    import com.ankamagames.dofus.logic.game.common.actions.guild.GuildInvitationAnswerAction;
    import com.ankamagames.dofus.network.messages.game.guild.GuildInvitationAnswerMessage;
    import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.enums.DialogTypeEnum;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;

    public class GuildDialogFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildDialogFrame));

        private var guildEmblem:GuildEmblem;


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
            var _local_2:GuildCreationValidAction;
            var _local_3:GuildCreationValidMessage;
            var _local_4:GuildModificationValidAction;
            var _local_5:GuildModificationValidMessage;
            var _local_6:GuildModificationNameValidAction;
            var _local_7:GuildModificationNameValidMessage;
            var _local_8:GuildModificationEmblemValidAction;
            var _local_9:GuildModificationEmblemValidMessage;
            var _local_10:GuildInvitationAnswerAction;
            var _local_11:GuildInvitationAnswerMessage;
            var _local_12:LeaveDialogMessage;
            switch (true)
            {
                case (msg is GuildCreationValidAction):
                    _local_2 = (msg as GuildCreationValidAction);
                    this.guildEmblem = new GuildEmblem();
                    this.guildEmblem.symbolShape = _local_2.upEmblemId;
                    this.guildEmblem.symbolColor = _local_2.upColorEmblem;
                    this.guildEmblem.backgroundShape = _local_2.backEmblemId;
                    this.guildEmblem.backgroundColor = _local_2.backColorEmblem;
                    _local_3 = new GuildCreationValidMessage();
                    _local_3.initGuildCreationValidMessage(_local_2.guildName, this.guildEmblem);
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is GuildModificationValidAction):
                    _local_4 = (msg as GuildModificationValidAction);
                    this.guildEmblem = new GuildEmblem();
                    this.guildEmblem.symbolShape = _local_4.upEmblemId;
                    this.guildEmblem.symbolColor = _local_4.upColorEmblem;
                    this.guildEmblem.backgroundShape = _local_4.backEmblemId;
                    this.guildEmblem.backgroundColor = _local_4.backColorEmblem;
                    _local_5 = new GuildModificationValidMessage();
                    _local_5.initGuildModificationValidMessage(_local_4.guildName, this.guildEmblem);
                    ConnectionsHandler.getConnection().send(_local_5);
                    return (true);
                case (msg is GuildModificationNameValidAction):
                    _local_6 = (msg as GuildModificationNameValidAction);
                    _local_7 = new GuildModificationNameValidMessage();
                    _local_7.initGuildModificationNameValidMessage(_local_6.guildName);
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is GuildModificationEmblemValidAction):
                    _local_8 = (msg as GuildModificationEmblemValidAction);
                    this.guildEmblem = new GuildEmblem();
                    this.guildEmblem.symbolShape = _local_8.upEmblemId;
                    this.guildEmblem.symbolColor = _local_8.upColorEmblem;
                    this.guildEmblem.backgroundShape = _local_8.backEmblemId;
                    this.guildEmblem.backgroundColor = _local_8.backColorEmblem;
                    _local_9 = new GuildModificationEmblemValidMessage();
                    _local_9.initGuildModificationEmblemValidMessage(this.guildEmblem);
                    ConnectionsHandler.getConnection().send(_local_9);
                    return (true);
                case (msg is GuildInvitationAnswerAction):
                    _local_10 = (msg as GuildInvitationAnswerAction);
                    _local_11 = new GuildInvitationAnswerMessage();
                    _local_11.initGuildInvitationAnswerMessage(_local_10.accept);
                    ConnectionsHandler.getConnection().send(_local_11);
                    this.leaveDialog();
                    return (true);
                case (msg is LeaveDialogMessage):
                    _local_12 = (msg as LeaveDialogMessage);
                    if ((((((_local_12.dialogType == DialogTypeEnum.DIALOG_GUILD_CREATE)) || ((_local_12.dialogType == DialogTypeEnum.DIALOG_GUILD_INVITATION)))) || ((_local_12.dialogType == DialogTypeEnum.DIALOG_GUILD_RENAME))))
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

