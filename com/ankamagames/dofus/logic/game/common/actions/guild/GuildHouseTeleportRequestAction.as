package com.ankamagames.dofus.logic.game.common.actions.guild
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class GuildHouseTeleportRequestAction implements Action 
    {

        public var houseId:uint;


        public static function create(pHouseId:uint):GuildHouseTeleportRequestAction
        {
            var action:GuildHouseTeleportRequestAction = new (GuildHouseTeleportRequestAction)();
            action.houseId = pHouseId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.guild

