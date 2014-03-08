package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementDetailedListRequestAction extends Object implements Action
   {
      
      public function AchievementDetailedListRequestAction() {
         super();
      }
      
      public static function create(categoryId:int) : AchievementDetailedListRequestAction {
         var action:AchievementDetailedListRequestAction = new AchievementDetailedListRequestAction();
         action.categoryId = categoryId;
         return action;
      }
      
      public var categoryId:int;
   }
}
