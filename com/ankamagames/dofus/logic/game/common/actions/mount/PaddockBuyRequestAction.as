package com.ankamagames.dofus.logic.game.common.actions.mount
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class PaddockBuyRequestAction extends Object implements Action
    {

        public function PaddockBuyRequestAction()
        {
            return;
        }// end function

        public static function create() : PaddockBuyRequestAction
        {
            return new PaddockBuyRequestAction;
        }// end function

    }
}
