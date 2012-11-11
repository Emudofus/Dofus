package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ObjectDropAction extends Object implements Action
    {
        public var objectUID:uint;
        public var objectGID:uint;
        public var quantity:uint;

        public function ObjectDropAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint) : ObjectDropAction
        {
            var _loc_4:* = new ObjectDropAction;
            new ObjectDropAction.objectUID = param1;
            _loc_4.objectGID = param2;
            _loc_4.quantity = param3;
            return _loc_4;
        }// end function

    }
}
