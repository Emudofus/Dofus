package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class TitleSelectRequestAction extends Object implements Action
    {
        public var titleId:int;

        public function TitleSelectRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : TitleSelectRequestAction
        {
            var _loc_2:* = new TitleSelectRequestAction;
            _loc_2.titleId = param1;
            return _loc_2;
        }// end function

    }
}
