package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AddFriendAction extends Object implements Action
   {
      
      public function AddFriendAction() {
         super();
      }
      
      public static function create(name:String) : AddFriendAction {
         var a:AddFriendAction = new AddFriendAction();
         a.name = name;
         return a;
      }
      
      public var name:String;
   }
}
