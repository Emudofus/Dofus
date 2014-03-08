package com.ankamagames.dofus.logic.game.roleplay.actions.preset
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class InventoryPresetItemUpdateRequestAction extends Object implements Action
   {
      
      public function InventoryPresetItemUpdateRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint) : InventoryPresetItemUpdateRequestAction {
         var _loc4_:InventoryPresetItemUpdateRequestAction = new InventoryPresetItemUpdateRequestAction();
         _loc4_.presetId = param1;
         _loc4_.position = param2;
         _loc4_.objUid = param3;
         return _loc4_;
      }
      
      public var presetId:uint;
      
      public var position:uint;
      
      public var objUid:uint;
   }
}
