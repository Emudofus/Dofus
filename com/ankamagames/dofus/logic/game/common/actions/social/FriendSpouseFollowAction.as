package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendSpouseFollowAction extends Object implements Action
   {
      
      public function FriendSpouseFollowAction() {
         super();
      }
      
      public static function create(enable:Boolean) : FriendSpouseFollowAction {
         var a:FriendSpouseFollowAction = new FriendSpouseFollowAction();
         a.enable = enable;
         return a;
      }
      
      public var enable:Boolean;
   }
}
