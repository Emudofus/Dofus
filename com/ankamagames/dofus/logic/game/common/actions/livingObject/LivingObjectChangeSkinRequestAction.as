package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class LivingObjectChangeSkinRequestAction extends Object implements Action
    {
        public var livingUID:uint;
        public var livingPosition:uint;
        public var skinId:uint;

        public function LivingObjectChangeSkinRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint) : LivingObjectChangeSkinRequestAction
        {
            var _loc_4:* = new LivingObjectChangeSkinRequestAction;
            new LivingObjectChangeSkinRequestAction.livingUID = param1;
            _loc_4.livingPosition = param2;
            _loc_4.skinId = param3;
            return _loc_4;
        }// end function

    }
}
