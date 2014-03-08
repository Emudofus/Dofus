package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinFriendAction extends Object implements Action
   {
      
      public function JoinFriendAction() {
         super();
      }
      
      public static function create(param1:String) : JoinFriendAction {
         var _loc2_:JoinFriendAction = new JoinFriendAction();
         _loc2_.name = param1;
         return _loc2_;
      }
      
      public var name:String;
   }
}
