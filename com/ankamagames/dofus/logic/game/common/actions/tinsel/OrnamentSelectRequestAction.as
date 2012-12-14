package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OrnamentSelectRequestAction extends Object implements Action
    {
        public var ornamentId:int;

        public function OrnamentSelectRequestAction()
        {
            return;
        }// end function

        public static function create(param1:int) : OrnamentSelectRequestAction
        {
            var _loc_2:* = new OrnamentSelectRequestAction;
            _loc_2.ornamentId = param1;
            return _loc_2;
        }// end function

    }
}
