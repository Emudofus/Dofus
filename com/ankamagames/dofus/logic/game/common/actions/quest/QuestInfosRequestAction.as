package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuestInfosRequestAction extends Object implements Action
   {
      
      public function QuestInfosRequestAction() {
         super();
      }
      
      public static function create(questId:int) : QuestInfosRequestAction {
         var a:QuestInfosRequestAction = new QuestInfosRequestAction();
         a.questId = questId;
         return a;
      }
      
      public var questId:int;
   }
}
