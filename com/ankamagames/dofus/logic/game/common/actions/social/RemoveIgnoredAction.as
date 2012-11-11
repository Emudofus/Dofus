package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class RemoveIgnoredAction extends Object implements Action
    {
        public var name:String;

        public function RemoveIgnoredAction()
        {
            return;
        }// end function

        public static function create(param1:String) : RemoveIgnoredAction
        {
            var _loc_2:* = new RemoveIgnoredAction;
            _loc_2.name = param1;
            return _loc_2;
        }// end function

    }
}
