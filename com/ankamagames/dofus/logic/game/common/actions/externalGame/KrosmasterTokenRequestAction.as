package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class KrosmasterTokenRequestAction extends Object implements Action
    {

        public function KrosmasterTokenRequestAction()
        {
            return;
        }// end function

        public static function create() : KrosmasterTokenRequestAction
        {
            var _loc_1:* = new KrosmasterTokenRequestAction;
            return _loc_1;
        }// end function

    }
}
