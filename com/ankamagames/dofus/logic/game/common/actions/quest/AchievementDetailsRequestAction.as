package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementDetailsRequestAction extends Object implements Action
   {
      
      public function AchievementDetailsRequestAction() {
         super();
      }
      
      public static function create(achievementId:int) : AchievementDetailsRequestAction {
         var action:AchievementDetailsRequestAction = new AchievementDetailsRequestAction();
         action.achievementId = achievementId;
         return action;
      }
      
      public var achievementId:int;
   }
}
