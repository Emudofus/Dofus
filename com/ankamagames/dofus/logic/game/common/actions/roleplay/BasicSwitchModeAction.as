package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class BasicSwitchModeAction extends Object implements Action
    {
        public var type:int;

        public function BasicSwitchModeAction()
        {
            return;
        }// end function

        public static function create(param1:int) : BasicSwitchModeAction
        {
            var _loc_2:* = new BasicSwitchModeAction;
            _loc_2.type = param1;
            return _loc_2;
        }// end function

    }
}
