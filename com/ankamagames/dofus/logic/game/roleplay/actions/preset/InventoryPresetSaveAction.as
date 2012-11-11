package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class InventoryPresetSaveAction extends Object implements Action
    {
        public var presetId:uint;
        public var symbolId:uint;
        public var saveEquipment:Boolean;

        public function InventoryPresetSaveAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:Boolean) : InventoryPresetSaveAction
        {
            var _loc_4:* = new InventoryPresetSaveAction;
            new InventoryPresetSaveAction.presetId = param1;
            _loc_4.symbolId = param2;
            _loc_4.saveEquipment = param3;
            return _loc_4;
        }// end function

    }
}
