package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PrismCurrentBonusRequestAction extends Object implements Action
    {

        public function PrismCurrentBonusRequestAction()
        {
            return;
        }// end function

        public static function create() : PrismCurrentBonusRequestAction
        {
            var _loc_1:* = new PrismCurrentBonusRequestAction;
            return _loc_1;
        }// end function

    }
}
