package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.*;

    public class InventoryPresetItemUpdateRequestAction extends Object implements Action
    {
        public var presetId:uint;
        public var position:uint;
        public var objUid:uint;

        public function InventoryPresetItemUpdateRequestAction()
        {
            return;
        }// end function

        public static function create(param1:uint, param2:uint, param3:uint) : InventoryPresetItemUpdateRequestAction
        {
            var _loc_4:* = new InventoryPresetItemUpdateRequestAction;
            new InventoryPresetItemUpdateRequestAction.presetId = param1;
            _loc_4.position = param2;
            _loc_4.objUid = param3;
            return _loc_4;
        }// end function

    }
}
