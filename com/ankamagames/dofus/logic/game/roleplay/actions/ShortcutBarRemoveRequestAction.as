package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ShortcutBarRemoveRequestAction extends Object implements Action
    {
        public var barType:uint;
        public var slot:uint;

        public function ShortcutBarRemoveRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint) : ShortcutBarRemoveRequestAction
        {
            var _loc_3:* = new ShortcutBarRemoveRequestAction;
            _loc_3.barType = param1;
            _loc_3.slot = param2;
            return _loc_3;
        }// end function

    }
}
