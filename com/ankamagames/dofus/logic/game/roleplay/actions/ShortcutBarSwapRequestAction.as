package com.ankamagames.dofus.logic.game.roleplay.actions
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class ShortcutBarSwapRequestAction extends Object implements Action
    {
        public var barType:uint;
        public var firstSlot:uint;
        public var secondSlot:uint;

        public function ShortcutBarSwapRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint) : ShortcutBarSwapRequestAction
        {
            var _loc_4:* = new ShortcutBarSwapRequestAction;
            new ShortcutBarSwapRequestAction.barType = param1;
            _loc_4.firstSlot = param2;
            _loc_4.secondSlot = param3;
            return _loc_4;
        }// end function

    }
}
