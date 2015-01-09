package com.ankamagames.dofus.logic.game.common.actions.alliance
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AllianceInvitationAnswerAction implements Action 
    {

        public var accept:Boolean;


        public static function create(pAccept:Boolean):AllianceInvitationAnswerAction
        {
            var action:AllianceInvitationAnswerAction = new (AllianceInvitationAnswerAction)();
            action.accept = pAccept;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.alliance

