package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HouseGuildRightsChangeAction implements Action 
    {

        public var rights:int;


        public static function create(rights:int):HouseGuildRightsChangeAction
        {
            var action:HouseGuildRightsChangeAction = new (HouseGuildRightsChangeAction)();
            action.rights = rights;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

