package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementRewardRequestAction extends Object implements Action
   {
      
      public function AchievementRewardRequestAction() {
         super();
      }
      
      public static function create(param1:int) : AchievementRewardRequestAction {
         var _loc2_:AchievementRewardRequestAction = new AchievementRewardRequestAction();
         _loc2_.achievementId = param1;
         return _loc2_;
      }
      
      public var achievementId:int;
   }
}
