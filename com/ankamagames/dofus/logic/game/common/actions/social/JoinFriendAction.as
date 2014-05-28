package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinFriendAction extends Object implements Action
   {
      
      public function JoinFriendAction() {
         super();
      }
      
      public static function create(name:String) : JoinFriendAction {
         var a:JoinFriendAction = new JoinFriendAction();
         a.name = name;
         return a;
      }
      
      public var name:String;
   }
}
