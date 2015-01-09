package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HouseKickAction implements Action 
    {

        public var id:uint;


        public static function create(id:uint):HouseKickAction
        {
            var action:HouseKickAction = new (HouseKickAction)();
            action.id = id;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

