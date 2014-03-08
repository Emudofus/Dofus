package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AddIgnoredAction extends Object implements Action
   {
      
      public function AddIgnoredAction() {
         super();
      }
      
      public static function create(name:String) : AddIgnoredAction {
         var a:AddIgnoredAction = new AddIgnoredAction();
         a.name = name;
         return a;
      }
      
      public var name:String;
   }
}
