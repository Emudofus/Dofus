package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class StartZoomAction extends Object implements Action
    {
        public var playerId:uint;
        public var value:Number;

        public function StartZoomAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:Number) : StartZoomAction
        {
            var _loc_3:* = new StartZoomAction;
            _loc_3.playerId = param1;
            _loc_3.value = param2;
            return _loc_3;
        }// end function

    }
}
