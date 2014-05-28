package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InventoryPresetItemUpdateRequestAction extends Object implements Action
   {
      
      public function InventoryPresetItemUpdateRequestAction() {
         super();
      }
      
      public static function create(presetId:uint, position:uint, objUid:uint) : InventoryPresetItemUpdateRequestAction {
         var a:InventoryPresetItemUpdateRequestAction = new InventoryPresetItemUpdateRequestAction();
         a.presetId = presetId;
         a.position = position;
         a.objUid = objUid;
         return a;
      }
      
      public var presetId:uint;
      
      public var position:uint;
      
      public var objUid:uint;
   }
}
