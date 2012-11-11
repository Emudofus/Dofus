package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class DeleteObjectAction extends Object implements Action
    {
        public var objectUID:uint;
        public var quantity:uint;

        public function DeleteObjectAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : DeleteObjectAction
        {
            var _loc_3:* = new DeleteObjectAction;
            _loc_3.objectUID = param1;
            _loc_3.quantity = param2;
            return _loc_3;
        }// end function

    }
}
