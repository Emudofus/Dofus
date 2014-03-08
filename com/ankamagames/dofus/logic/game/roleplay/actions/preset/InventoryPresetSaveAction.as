package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InventoryPresetSaveAction extends Object implements Action
   {
      
      public function InventoryPresetSaveAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:Boolean) : InventoryPresetSaveAction {
         var _loc4_:InventoryPresetSaveAction = new InventoryPresetSaveAction();
         _loc4_.presetId = param1;
         _loc4_.symbolId = param2;
         _loc4_.saveEquipment = param3;
         return _loc4_;
      }
      
      public var presetId:uint;
      
      public var symbolId:uint;
      
      public var saveEquipment:Boolean;
   }
}
