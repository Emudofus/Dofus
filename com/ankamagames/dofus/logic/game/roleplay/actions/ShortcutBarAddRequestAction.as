package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShortcutBarAddRequestAction extends Object implements Action
   {
      
      public function ShortcutBarAddRequestAction() {
         super();
      }
      
      public static function create(barType:uint, id:uint, slot:uint) : ShortcutBarAddRequestAction {
         var a:ShortcutBarAddRequestAction = new ShortcutBarAddRequestAction();
         a.barType = barType;
         a.id = id;
         a.slot = slot;
         return a;
      }
      
      public var barType:uint;
      
      public var id:uint;
      
      public var slot:uint;
   }
}
