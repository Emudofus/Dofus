package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildKickRequestAction implements Action 
    {

        public var targetId:uint;


        public static function create(pTargetId:uint):GuildKickRequestAction
        {
            var action:GuildKickRequestAction = new (GuildKickRequestAction)();
            action.targetId = pTargetId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

