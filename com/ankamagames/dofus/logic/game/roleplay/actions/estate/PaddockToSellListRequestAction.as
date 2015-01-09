package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
    import com.ankamagames.jerakine.handlers.messages.Action;

    public class PaddockToSellListRequestAction implements Action 
    {

        public var pageIndex:uint;


        public static function create(pageIndex:uint):PaddockToSellListRequestAction
        {
            var a:PaddockToSellListRequestAction = new (PaddockToSellListRequestAction)();
            a.pageIndex = pageIndex;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions.estate

