package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendOrGuildMemberLevelUpWarningSetAction extends Object implements Action
   {
      
      public function FriendOrGuildMemberLevelUpWarningSetAction() {
         super();
      }
      
      public static function create(param1:Boolean) : FriendOrGuildMemberLevelUpWarningSetAction {
         var _loc2_:FriendOrGuildMemberLevelUpWarningSetAction = new FriendOrGuildMemberLevelUpWarningSetAction();
         _loc2_.enable = param1;
         return _loc2_;
      }
      
      public var enable:Boolean;
   }
}
