package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementRewardRequestAction extends Object implements Action
   {
      
      public function AchievementRewardRequestAction() {
         super();
      }
      
      public static function create(achievementId:int) : AchievementRewardRequestAction {
         var action:AchievementRewardRequestAction = new AchievementRewardRequestAction();
         action.achievementId = achievementId;
         return action;
      }
      
      public var achievementId:int;
   }
}
