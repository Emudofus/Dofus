package com.ankamagames.dofus.logic.game.common.actions.alignment
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class SetEnablePVPRequestAction extends Object implements Action
    {
        public var enable:Boolean;

        public function SetEnablePVPRequestAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean) : SetEnablePVPRequestAction
        {
            var _loc_2:* = new SetEnablePVPRequestAction;
            _loc_2.enable = param1;
            return _loc_2;
        }// end function

    }
}
