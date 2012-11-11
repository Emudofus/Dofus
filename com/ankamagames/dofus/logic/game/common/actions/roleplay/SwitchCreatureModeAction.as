package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class SwitchCreatureModeAction extends Object implements Action
    {
        public var isActivated:Boolean;

        public function SwitchCreatureModeAction()
        {
            return;
        }// end function

        public static function create(param1:Boolean = false) : SwitchCreatureModeAction
        {
            var _loc_2:* = new SwitchCreatureModeAction;
            _loc_2.isActivated = param1;
            return _loc_2;
        }// end function

    }
}
