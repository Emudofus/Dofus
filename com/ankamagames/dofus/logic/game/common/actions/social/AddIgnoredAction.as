package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class AddIgnoredAction extends Object implements Action
    {
        public var name:String;

        public function AddIgnoredAction()
        {
            return;
        }// end function

        public static function create(param1:String) : AddIgnoredAction
        {
            var _loc_2:* = new AddIgnoredAction;
            _loc_2.name = param1;
            return _loc_2;
        }// end function

    }
}
