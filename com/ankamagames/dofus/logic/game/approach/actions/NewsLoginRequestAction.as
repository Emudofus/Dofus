package com.ankamagames.dofus.logic.game.approach.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class NewsLoginRequestAction extends Object implements Action
    {

        public function NewsLoginRequestAction()
        {
            return;
        }// end function

        public static function create() : NewsLoginRequestAction
        {
            var _loc_1:* = new NewsLoginRequestAction;
            return _loc_1;
        }// end function

    }
}
