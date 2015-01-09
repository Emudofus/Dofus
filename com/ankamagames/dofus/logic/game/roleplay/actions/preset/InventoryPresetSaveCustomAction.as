package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
    import com.ankamagames.jerakine.handlers.messages.Action;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class InventoryPresetSaveCustomAction implements Action 
    {

        public var presetId:uint;
        public var symbolId:uint;
        public var itemsUids:Vector.<uint>;
        public var itemsPositions:Vector.<uint>;

        public function InventoryPresetSaveCustomAction()
        {
            this.itemsUids = new Vector.<uint>();
            this.itemsPositions = new Vector.<uint>();
            super();
        }

        public static function create(presetId:uint, symbolId:uint, itemsUids:Vector.<uint>, itemsPositions:Vector.<uint>):InventoryPresetSaveCustomAction
        {
            var a:InventoryPresetSaveCustomAction = new (InventoryPresetSaveCustomAction)();
            a.presetId = presetId;
            a.symbolId = symbolId;
            a.itemsUids = itemsUids;
            a.itemsPositions = itemsPositions;
            return (a);
        }


    }
}//package com.ankamagames.dofus.logic.game.roleplay.actions.preset

