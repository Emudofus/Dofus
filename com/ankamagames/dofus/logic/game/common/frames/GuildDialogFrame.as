package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.actions.*;
    import com.ankamagames.dofus.logic.game.common.actions.guild.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.dofus.network.messages.game.guild.*;
    import com.ankamagames.dofus.network.types.game.guild.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class GuildDialogFrame extends Object implements Frame
    {
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
            var _loc_2:GuildCreationValidAction = null;
            var _loc_3:GuildEmblem = null;
            var _loc_4:GuildCreationValidMessage = null;
            var _loc_5:GuildInvitationAnswerAction = null;
            var _loc_6:GuildInvitationAnswerMessage = null;
            switch(true)
            {
                case param1 is GuildCreationValidAction:
                {
                    _loc_2 = param1 as GuildCreationValidAction;
                    _loc_3 = new GuildEmblem();
                    _loc_3.symbolShape = _loc_2.upEmblemId;
                    _loc_3.symbolColor = _loc_2.upColorEmblem;
                    _loc_3.backgroundShape = _loc_2.backEmblemId;
                    _loc_3.backgroundColor = _loc_2.backColorEmblem;
                    _loc_4 = new GuildCreationValidMessage();
                    _loc_4.initGuildCreationValidMessage(_loc_2.guildName, _loc_3);
                    ConnectionsHandler.getConnection().send(_loc_4);
                    return true;
                }
                case param1 is GuildInvitationAnswerAction:
                {
                    _loc_5 = param1 as GuildInvitationAnswerAction;
                    _loc_6 = new GuildInvitationAnswerMessage();
                    _loc_6.initGuildInvitationAnswerMessage(_loc_5.accept);
                    ConnectionsHandler.getConnection().send(_loc_6);
                    return true;
                }
                case param1 is LeaveDialogMessage:
                {
                    Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
                    Kernel.getWorker().removeFrame(this);
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

    }
}
