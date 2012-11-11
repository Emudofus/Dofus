package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class LivingObjectDissociateAction extends Object implements Action
    {
        public var livingUID:uint;
        public var livingPosition:uint;

        public function LivingObjectDissociateAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : LivingObjectDissociateAction
        {
            var _loc_3:* = new LivingObjectDissociateAction;
            _loc_3.livingUID = param1;
            _loc_3.livingPosition = param2;
            return _loc_3;
        }// end function

    }
}
