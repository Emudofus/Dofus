package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class SpouseRequestAction extends Object implements Action
    {

        public function SpouseRequestAction()
        {
            return;
        }// end function

        public static function create() : SpouseRequestAction
        {
            var _loc_1:* = new SpouseRequestAction;
            return _loc_1;
        }// end function

    }
}
