package com.ankamagames.dofus.logic.game.common.actions.bid
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class LeaveBidHouseAction implements Action 
    {


        public static function create():LeaveBidHouseAction
        {
            var a:LeaveBidHouseAction = new (LeaveBidHouseAction)();
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.actions.bid

