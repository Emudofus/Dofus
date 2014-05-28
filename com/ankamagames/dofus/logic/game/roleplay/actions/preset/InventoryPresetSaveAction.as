package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InventoryPresetSaveAction extends Object implements Action
   {
      
      public function InventoryPresetSaveAction() {
         super();
      }
      
      public static function create(presetId:uint, symbolId:uint, saveEquipment:Boolean) : InventoryPresetSaveAction {
         var a:InventoryPresetSaveAction = new InventoryPresetSaveAction();
         a.presetId = presetId;
         a.symbolId = symbolId;
         a.saveEquipment = saveEquipment;
         return a;
      }
      
      public var presetId:uint;
      
      public var symbolId:uint;
      
      public var saveEquipment:Boolean;
   }
}
