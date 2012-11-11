package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class KrosmasterInventoryRequestAction extends Object implements Action
    {

        public function KrosmasterInventoryRequestAction()
        {
            return;
        }// end function

        public static function create() : KrosmasterInventoryRequestAction
        {
            var _loc_1:* = new KrosmasterInventoryRequestAction;
            return _loc_1;
        }// end function

    }
}
