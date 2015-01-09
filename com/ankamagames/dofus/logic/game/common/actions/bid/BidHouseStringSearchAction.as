package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class BidHouseStringSearchAction implements Action 
    {

        public var searchString:String;


        public static function create(pSearchString:String):BidHouseStringSearchAction
        {
            var a:BidHouseStringSearchAction = new (BidHouseStringSearchAction)();
            a.searchString = pSearchString;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.bid

