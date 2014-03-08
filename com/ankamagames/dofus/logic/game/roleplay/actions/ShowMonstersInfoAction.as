package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShowMonstersInfoAction extends Object implements Action
   {
      
      public function ShowMonstersInfoAction() {
         super();
      }
      
      public static function create(pFromShortcut:Boolean=true) : ShowMonstersInfoAction {
         var a:ShowMonstersInfoAction = new ShowMonstersInfoAction();
         a.fromShortcut = pFromShortcut;
         return a;
      }
      
      public var fromShortcut:Boolean;
   }
}
