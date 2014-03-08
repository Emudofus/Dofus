package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.network.types.game.context.roleplay.quest.QuestActiveInformations;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.QuestFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class QuestItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function QuestItemCriterion(pCriterion:String) {
         super(pCriterion);
         this._questId = _criterionValue;
      }
      
      private var _questId:uint;
      
      override public function get text() : String {
         var readableCriterion:String = "";
         var quest:Quest = Quest.getQuestById(this._questId);
         if(!quest)
         {
            return readableCriterion;
         }
         var readableCriterionValue:String = quest.name;
         var s:String = _serverCriterionForm.slice(0,2);
         switch(s)
         {
            case "Qa":
               readableCriterion = I18n.getUiText("ui.grimoire.quest.active",[readableCriterionValue]);
               break;
            case "Qc":
               readableCriterion = I18n.getUiText("ui.grimoire.quest.startable",[readableCriterionValue]);
               break;
            case "Qf":
               readableCriterion = I18n.getUiText("ui.grimoire.quest.done",[readableCriterionValue]);
               break;
         }
         return readableCriterion;
      }
      
      override public function get isRespected() : Boolean {
         var questA:QuestActiveInformations = null;
         var quest:Quest = Quest.getQuestById(this._questId);
         if(!quest)
         {
            return false;
         }
         var questFrame:QuestFrame = Kernel.getWorker().getFrame(QuestFrame) as QuestFrame;
         var s:String = _serverCriterionForm.slice(0,2);
         switch(s)
         {
            case "Qa":
               for each (questA in questFrame.getActiveQuests())
               {
                  if(questA.questId == this._questId)
                  {
                     return true;
                  }
               }
               break;
            case "Qc":
               return true;
            case "Qf":
               return !(questFrame.getCompletedQuests().indexOf(this._questId) == -1);
         }
         return false;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:QuestItemCriterion = new QuestItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().infos.level;
      }
   }
}
