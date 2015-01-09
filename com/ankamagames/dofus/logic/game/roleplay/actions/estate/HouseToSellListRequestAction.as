package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class HouseToSellListRequestAction implements Action 
    {

        public var pageIndex:uint;


        public static function create(pageIndex:uint):HouseToSellListRequestAction
        {
            var a:HouseToSellListRequestAction = new (HouseToSellListRequestAction)();
            a.pageIndex = pageIndex;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions.estate

