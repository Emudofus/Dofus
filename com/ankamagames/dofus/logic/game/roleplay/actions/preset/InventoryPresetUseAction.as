package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class InventoryPresetUseAction extends Object implements Action
    {
        public var presetId:uint;

        public function InventoryPresetUseAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : InventoryPresetUseAction
        {
            var _loc_2:* = new InventoryPresetUseAction;
            _loc_2.presetId = param1;
            return _loc_2;
        }// end function

    }
}
