package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuestObjectiveValidationAction extends Object implements Action
   {
      
      public function QuestObjectiveValidationAction() {
         super();
      }
      
      public static function create(questId:int, objectiveId:int) : QuestObjectiveValidationAction {
         var a:QuestObjectiveValidationAction = new QuestObjectiveValidationAction();
         a.questId = questId;
         a.objectiveId = objectiveId;
         return a;
      }
      
      public var questId:int;
      
      public var objectiveId:int;
   }
}
