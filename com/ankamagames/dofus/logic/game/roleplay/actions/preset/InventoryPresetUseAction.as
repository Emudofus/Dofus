package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InventoryPresetUseAction extends Object implements Action
   {
      
      public function InventoryPresetUseAction() {
         super();
      }
      
      public static function create(param1:uint) : InventoryPresetUseAction {
         var _loc2_:InventoryPresetUseAction = new InventoryPresetUseAction();
         _loc2_.presetId = param1;
         return _loc2_;
      }
      
      public var presetId:uint;
   }
}
