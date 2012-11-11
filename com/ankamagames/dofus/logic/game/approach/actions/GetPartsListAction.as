package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GetPartsListAction extends Object implements Action
    {

        public function GetPartsListAction()
        {
            return;
        }// end function

        public static function create() : GetPartsListAction
        {
            var _loc_1:* = new GetPartsListAction;
            return _loc_1;
        }// end function

    }
}
