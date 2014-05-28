package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShortcutBarRemoveRequestAction extends Object implements Action
   {
      
      public function ShortcutBarRemoveRequestAction() {
         super();
      }
      
      public static function create(barType:uint, slot:uint) : ShortcutBarRemoveRequestAction {
         var a:ShortcutBarRemoveRequestAction = new ShortcutBarRemoveRequestAction();
         a.barType = barType;
         a.slot = slot;
         return a;
      }
      
      public var barType:uint;
      
      public var slot:uint;
   }
}
