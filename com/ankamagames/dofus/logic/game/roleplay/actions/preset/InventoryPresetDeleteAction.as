package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class InventoryPresetDeleteAction extends Object implements Action
    {
        public var presetId:uint;

        public function InventoryPresetDeleteAction()
        {
            return;
        }// end function

        public static function create(param1:uint) : InventoryPresetDeleteAction
        {
            var _loc_2:* = new InventoryPresetDeleteAction;
            _loc_2.presetId = param1;
            return _loc_2;
        }// end function

    }
}
