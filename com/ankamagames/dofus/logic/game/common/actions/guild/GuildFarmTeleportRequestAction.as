package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildFarmTeleportRequestAction implements Action 
    {

        public var farmId:uint;


        public static function create(pFarmId:uint):GuildFarmTeleportRequestAction
        {
            var action:GuildFarmTeleportRequestAction = new (GuildFarmTeleportRequestAction)();
            action.farmId = pFarmId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

