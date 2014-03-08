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
      
      public function QuestItemCriterion(param1:String) {
         super(param1);
         this._questId = _criterionValue;
      }
      
      private var _questId:uint;
      
      override public function get text() : String {
         var _loc1_:* = "";
         var _loc2_:Quest = Quest.getQuestById(this._questId);
         if(!_loc2_)
         {
            return _loc1_;
         }
         var _loc3_:String = _loc2_.name;
         var _loc4_:String = _serverCriterionForm.slice(0,2);
         switch(_loc4_)
         {
            case "Qa":
               _loc1_ = I18n.getUiText("ui.grimoire.quest.active",[_loc3_]);
               break;
            case "Qc":
               _loc1_ = I18n.getUiText("ui.grimoire.quest.startable",[_loc3_]);
               break;
            case "Qf":
               _loc1_ = I18n.getUiText("ui.grimoire.quest.done",[_loc3_]);
               break loop0;
         }
         return _loc1_;
      }
      
      override public function get isRespected() : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:QuestItemCriterion = new QuestItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().infos.level;
      }
   }
}
