package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuestStartRequestAction extends Object implements Action
   {
      
      public function QuestStartRequestAction() {
         super();
      }
      
      public static function create(questId:int) : QuestStartRequestAction {
         var a:QuestStartRequestAction = new QuestStartRequestAction();
         a.questId = questId;
         return a;
      }
      
      public var questId:int;
   }
}
