package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AchievementDetailedListRequestAction extends Object implements Action
   {
      
      public function AchievementDetailedListRequestAction() {
         super();
      }
      
      public static function create(param1:int) : AchievementDetailedListRequestAction {
         var _loc2_:AchievementDetailedListRequestAction = new AchievementDetailedListRequestAction();
         _loc2_.categoryId = param1;
         return _loc2_;
      }
      
      public var categoryId:int;
   }
}
