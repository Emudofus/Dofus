package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ObjectUseOnCellAction extends Object implements Action
    {
        public var targetedCell:uint;
        public var objectUID:uint;

        public function ObjectUseOnCellAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : ObjectUseOnCellAction
        {
            var _loc_3:* = new ObjectUseOnCellAction;
            _loc_3.targetedCell = param2;
            _loc_3.objectUID = param1;
            return _loc_3;
        }// end function

    }
}
