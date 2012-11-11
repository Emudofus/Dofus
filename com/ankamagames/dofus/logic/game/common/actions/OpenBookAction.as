package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenBookAction extends Object implements Action
    {
        private var _name:String;
        public var value:String;
        public var param:Object;

        public function OpenBookAction()
        {
            return;
        }// end function

        public static function create(param1:String = null, param2:Object = null) : OpenBookAction
        {
            var _loc_3:* = new OpenBookAction;
            _loc_3.value = param1;
            _loc_3.param = param2;
            return _loc_3;
        }// end function

    }
}
