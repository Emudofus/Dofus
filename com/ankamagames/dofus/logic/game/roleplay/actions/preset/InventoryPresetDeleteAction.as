package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InventoryPresetDeleteAction extends Object implements Action
   {
      
      public function InventoryPresetDeleteAction() {
         super();
      }
      
      public static function create(presetId:uint) : InventoryPresetDeleteAction {
         var a:InventoryPresetDeleteAction = new InventoryPresetDeleteAction();
         a.presetId = presetId;
         return a;
      }
      
      public var presetId:uint;
   }
}
