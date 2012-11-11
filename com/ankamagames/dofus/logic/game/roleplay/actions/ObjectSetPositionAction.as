package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ObjectSetPositionAction extends Object implements Action
    {
        public var objectUID:uint;
        public var position:uint;
        public var quantity:uint;

        public function ObjectSetPositionAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint = 1) : ObjectSetPositionAction
        {
            var _loc_4:* = new ObjectSetPositionAction;
            new ObjectSetPositionAction.objectUID = param1;
            _loc_4.quantity = param3;
            _loc_4.position = param2;
            return _loc_4;
        }// end function

    }
}
