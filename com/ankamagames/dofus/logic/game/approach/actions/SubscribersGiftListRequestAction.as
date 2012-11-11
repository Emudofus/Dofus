package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class SubscribersGiftListRequestAction extends Object implements Action
    {

        public function SubscribersGiftListRequestAction()
        {
            return;
        }// end function

        public static function create() : SubscribersGiftListRequestAction
        {
            var _loc_1:* = new SubscribersGiftListRequestAction;
            return _loc_1;
        }// end function

    }
}
