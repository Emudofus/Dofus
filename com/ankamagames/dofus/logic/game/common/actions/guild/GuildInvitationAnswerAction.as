package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildInvitationAnswerAction implements Action 
    {

        public var accept:Boolean;


        public static function create(pAccept:Boolean):GuildInvitationAnswerAction
        {
            var action:GuildInvitationAnswerAction = new (GuildInvitationAnswerAction)();
            action.accept = pAccept;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

