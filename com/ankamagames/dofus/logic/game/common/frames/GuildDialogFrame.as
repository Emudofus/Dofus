package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.guild.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.guild.*;
    import com.ankamagames.dofus.network.types.game.guild.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class GuildDialogFrame extends Object implements Frame
    {
        private var guildEmblem:GuildEmblem;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildDialogFrame));

        public function GuildDialogFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
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
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            switch(true)
            {
                case param1 is GuildCreationValidAction:
                {
                    _loc_2 = param1 as GuildCreationValidAction;
                    this.guildEmblem = new GuildEmblem();
                    this.guildEmblem.symbolShape = _loc_2.upEmblemId;
                    this.guildEmblem.symbolColor = _loc_2.upColorEmblem;
                    this.guildEmblem.backgroundShape = _loc_2.backEmblemId;
                    this.guildEmblem.backgroundColor = _loc_2.backColorEmblem;
                    _loc_3 = new GuildCreationValidMessage();
                    _loc_3.initGuildCreationValidMessage(_loc_2.guildName, this.guildEmblem);
                    ConnectionsHandler.getConnection().send(_loc_3);
                    return true;
                }
                case param1 is GuildModificationValidAction:
                {
                    _loc_4 = param1 as GuildModificationValidAction;
                    this.guildEmblem = new GuildEmblem();
                    this.guildEmblem.symbolShape = _loc_4.upEmblemId;
                    this.guildEmblem.symbolColor = _loc_4.upColorEmblem;
                    this.guildEmblem.backgroundShape = _loc_4.backEmblemId;
                    this.guildEmblem.backgroundColor = _loc_4.backColorEmblem;
                    _loc_5 = new GuildModificationValidMessage();
                    _loc_5.initGuildModificationValidMessage(_loc_4.guildName, this.guildEmblem);
                    ConnectionsHandler.getConnection().send(_loc_5);
                    return true;
                }
                case param1 is GuildModificationNameValidAction:
                {
                    _loc_6 = param1 as GuildModificationNameValidAction;
                    _loc_7 = new GuildModificationNameValidMessage();
                    _loc_7.initGuildModificationNameValidMessage(_loc_6.guildName);
                    ConnectionsHandler.getConnection().send(_loc_7);
                    return true;
                }
                case param1 is GuildModificationEmblemValidAction:
                {
                    _loc_8 = param1 as GuildModificationEmblemValidAction;
                    this.guildEmblem = new GuildEmblem();
                    this.guildEmblem.symbolShape = _loc_8.upEmblemId;
                    this.guildEmblem.symbolColor = _loc_8.upColorEmblem;
                    this.guildEmblem.backgroundShape = _loc_8.backEmblemId;
                    this.guildEmblem.backgroundColor = _loc_8.backColorEmblem;
                    _loc_9 = new GuildModificationEmblemValidMessage();
                    _loc_9.initGuildModificationEmblemValidMessage(this.guildEmblem);
                    ConnectionsHandler.getConnection().send(_loc_9);
                    return true;
                }
                case param1 is GuildInvitationAnswerAction:
                {
                    _loc_10 = param1 as GuildInvitationAnswerAction;
                    _loc_11 = new GuildInvitationAnswerMessage();
                    _loc_11.initGuildInvitationAnswerMessage(_loc_10.accept);
                    ConnectionsHandler.getConnection().send(_loc_11);
                    this.leaveDialog();
                    return true;
                }
                case param1 is LeaveDialogMessage:
                {
                    _loc_12 = param1 as LeaveDialogMessage;
                    if (_loc_12.dialogType == DialogTypeEnum.DIALOG_GUILD_CREATE || _loc_12.dialogType == DialogTypeEnum.DIALOG_GUILD_INVITATION || _loc_12.dialogType == DialogTypeEnum.DIALOG_GUILD_RENAME)
                    {
                        this.leaveDialog();
                    }
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
            KernelEventsManager.getInstance().processCallback(HookList.LeaveDialog);
            return true;
        }// end function

        private function leaveDialog() : void
        {
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
            Kernel.getWorker().removeFrame(this);
            return;
        }// end function

    }
}
