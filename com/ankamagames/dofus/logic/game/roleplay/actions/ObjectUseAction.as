package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ObjectUseAction extends Object implements Action
    {
        public var objectUID:uint;
        public var useOnCell:Boolean;
        public var quantity:int;

        public function ObjectUseAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:int = 1, param3:Boolean = false) : ObjectUseAction
        {
            var _loc_4:* = new ObjectUseAction;
            new ObjectUseAction.objectUID = param1;
            _loc_4.quantity = param2;
            _loc_4.useOnCell = param3;
            return _loc_4;
        }// end function

    }
}
