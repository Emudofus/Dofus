package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShortcutBarSwapRequestAction extends Object implements Action
   {
      
      public function ShortcutBarSwapRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint, param3:uint) : ShortcutBarSwapRequestAction {
         var _loc4_:ShortcutBarSwapRequestAction = new ShortcutBarSwapRequestAction();
         _loc4_.barType = param1;
         _loc4_.firstSlot = param2;
         _loc4_.secondSlot = param3;
         return _loc4_;
      }
      
      public var barType:uint;
      
      public var firstSlot:uint;
      
      public var secondSlot:uint;
   }
}
