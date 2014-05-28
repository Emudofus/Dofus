package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InventoryPresetUseAction extends Object implements Action
   {
      
      public function InventoryPresetUseAction() {
         super();
      }
      
      public static function create(presetId:uint) : InventoryPresetUseAction {
         var a:InventoryPresetUseAction = new InventoryPresetUseAction();
         a.presetId = presetId;
         return a;
      }
      
      public var presetId:uint;
   }
}
