package com.ankamagames.dofus.logic.game.common.actions.prism
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PrismAttackRequestAction extends Object implements Action
    {

        public function PrismAttackRequestAction()
        {
            return;
        }// end function

        public static function create() : PrismAttackRequestAction
        {
            var _loc_1:* = new PrismAttackRequestAction;
            return _loc_1;
        }// end function

    }
}
