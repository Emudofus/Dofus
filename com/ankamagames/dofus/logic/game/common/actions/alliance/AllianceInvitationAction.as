package com.ankamagames.dofus.logic.game.common.actions.alliance
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class AllianceInvitationAction implements Action 
    {

        public var targetId:uint;


        public static function create(pTargetId:uint):AllianceInvitationAction
        {
            var action:AllianceInvitationAction = new (AllianceInvitationAction)();
            action.targetId = pTargetId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.alliance

