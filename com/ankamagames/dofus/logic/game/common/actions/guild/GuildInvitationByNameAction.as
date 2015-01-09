package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildInvitationByNameAction implements Action 
    {

        public var target:String;


        public static function create(pTarget:String):GuildInvitationByNameAction
        {
            var action:GuildInvitationByNameAction = new (GuildInvitationByNameAction)();
            action.target = pTarget;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

