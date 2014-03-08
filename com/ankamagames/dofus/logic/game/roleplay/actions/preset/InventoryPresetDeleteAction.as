package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InventoryPresetDeleteAction extends Object implements Action
   {
      
      public function InventoryPresetDeleteAction() {
         super();
      }
      
      public static function create(param1:uint) : InventoryPresetDeleteAction {
         var _loc2_:InventoryPresetDeleteAction = new InventoryPresetDeleteAction();
         _loc2_.presetId = param1;
         return _loc2_;
      }
      
      public var presetId:uint;
   }
}
