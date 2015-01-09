package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildInvitationAction implements Action 
    {

        public var targetId:uint;


        public static function create(pTargetId:uint):GuildInvitationAction
        {
            var action:GuildInvitationAction = new (GuildInvitationAction)();
            action.targetId = pTargetId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

