package com.ankamagames.dofus.logic.game.fight.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class BannerEmptySlotClickAction extends Object implements Action
    {

        public function BannerEmptySlotClickAction()
        {
            return;
        }// end function

        public static function create() : BannerEmptySlotClickAction
        {
            var _loc_1:* = new BannerEmptySlotClickAction;
            return _loc_1;
        }// end function

    }
}
