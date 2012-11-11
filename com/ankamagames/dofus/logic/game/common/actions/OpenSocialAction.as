package com.ankamagames.dofus.logic.game.common.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class OpenSocialAction extends Object implements Action
    {
        public var name:String;

        public function OpenSocialAction()
        {
            return;
        }// end function

        public static function create(param1:String = null) : OpenSocialAction
        {
            var _loc_2:* = new OpenSocialAction;
            _loc_2.name = param1;
            return _loc_2;
        }// end function

    }
}
