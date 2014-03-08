package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendOrGuildMemberLevelUpWarningSetAction extends Object implements Action
   {
      
      public function FriendOrGuildMemberLevelUpWarningSetAction() {
         super();
      }
      
      public static function create(enable:Boolean) : FriendOrGuildMemberLevelUpWarningSetAction {
         var a:FriendOrGuildMemberLevelUpWarningSetAction = new FriendOrGuildMemberLevelUpWarningSetAction();
         a.enable = enable;
         return a;
      }
      
      public var enable:Boolean;
   }
}
