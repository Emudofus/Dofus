package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class EnemiesListRequestAction extends Object implements Action
    {

        public function EnemiesListRequestAction()
        {
            return;
        }// end function

        public static function create() : EnemiesListRequestAction
        {
            var _loc_1:* = new EnemiesListRequestAction;
            return _loc_1;
        }// end function

    }
}
