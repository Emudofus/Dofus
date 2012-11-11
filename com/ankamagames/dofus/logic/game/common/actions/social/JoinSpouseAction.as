package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class JoinSpouseAction extends Object implements Action
    {

        public function JoinSpouseAction()
        {
            return;
        }// end function

        public static function create() : JoinSpouseAction
        {
            var _loc_1:* = new JoinSpouseAction;
            return _loc_1;
        }// end function

    }
}
