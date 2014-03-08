package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuestStartRequestAction extends Object implements Action
   {
      
      public function QuestStartRequestAction() {
         super();
      }
      
      public static function create(param1:int) : QuestStartRequestAction {
         var _loc2_:QuestStartRequestAction = new QuestStartRequestAction();
         _loc2_.questId = param1;
         return _loc2_;
      }
      
      public var questId:int;
   }
}
