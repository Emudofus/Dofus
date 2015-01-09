package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HouseKickIndoorMerchantAction implements Action 
    {

        public var cellId:uint;


        public static function create(cellId:uint):HouseKickIndoorMerchantAction
        {
            var action:HouseKickIndoorMerchantAction = new (HouseKickIndoorMerchantAction)();
            action.cellId = cellId;
            return (action);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions

