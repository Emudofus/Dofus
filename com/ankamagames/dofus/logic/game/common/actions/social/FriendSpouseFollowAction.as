package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendSpouseFollowAction extends Object implements Action
   {
      
      public function FriendSpouseFollowAction() {
         super();
      }
      
      public static function create(param1:Boolean) : FriendSpouseFollowAction {
         var _loc2_:FriendSpouseFollowAction = new FriendSpouseFollowAction();
         _loc2_.enable = param1;
         return _loc2_;
      }
      
      public var enable:Boolean;
   }
}
