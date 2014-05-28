package com.ankamagames.dofus.logic.game.common.actions.quest
{
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class QuestListRequestAction extends Object implements Action
   {
      
      public function QuestListRequestAction() {
         super();
      }
      
      public static function create() : QuestListRequestAction {
         return new QuestListRequestAction();
      }
   }
}
