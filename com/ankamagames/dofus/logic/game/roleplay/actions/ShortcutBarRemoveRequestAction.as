package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShortcutBarRemoveRequestAction extends Object implements Action
   {
      
      public function ShortcutBarRemoveRequestAction() {
         super();
      }
      
      public static function create(param1:uint, param2:uint) : ShortcutBarRemoveRequestAction {
         var _loc3_:ShortcutBarRemoveRequestAction = new ShortcutBarRemoveRequestAction();
         _loc3_.barType = param1;
         _loc3_.slot = param2;
         return _loc3_;
      }
      
      public var barType:uint;
      
      public var slot:uint;
   }
}
