package com.ankamagames.dofus.logic.game.common.actions.humanVendor
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class LeaveShopStockAction implements Action 
    {


        public static function create():LeaveShopStockAction
        {
            var a:LeaveShopStockAction = new (LeaveShopStockAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.humanVendor

