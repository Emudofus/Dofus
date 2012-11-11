package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class GiftAssignRequestAction extends Object implements Action
    {
        public var giftId:uint;
        public var characterId:uint;

        public function GiftAssignRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : GiftAssignRequestAction
        {
            var _loc_3:* = new GiftAssignRequestAction;
            _loc_3.giftId = param1;
            _loc_3.characterId = param2;
            return _loc_3;
        }// end function

    }
}
