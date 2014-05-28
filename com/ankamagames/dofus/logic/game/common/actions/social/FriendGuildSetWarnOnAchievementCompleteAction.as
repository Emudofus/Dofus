package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendGuildSetWarnOnAchievementCompleteAction extends Object implements Action
   {
      
      public function FriendGuildSetWarnOnAchievementCompleteAction() {
         super();
      }
      
      public static function create(enable:Boolean) : FriendGuildSetWarnOnAchievementCompleteAction {
         var a:FriendGuildSetWarnOnAchievementCompleteAction = new FriendGuildSetWarnOnAchievementCompleteAction();
         a.enable = enable;
         return a;
      }
      
      public var enable:Boolean;
   }
}
