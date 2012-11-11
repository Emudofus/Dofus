package com.ankamagames.dofus.logic.game.common.actions.social
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class MemberWarningSetAction extends Object implements Action
    {
        public var enable:Boolean;

        public function MemberWarningSetAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : MemberWarningSetAction
        {
            var _loc_2:* = new MemberWarningSetAction;
            _loc_2.enable = param1;
            return _loc_2;
        }// end function

    }
}
