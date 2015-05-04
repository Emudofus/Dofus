package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   
   public class MaxRankCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function MaxRankCriterion(param1:String)
      {
         super(param1);
      }
      
      override public function get text() : String
      {
         var _loc1_:String = String(_criterionValue);
         var _loc2_:String = I18n.getUiText("ui.common.pvpMaxRank");
         var _loc3_:* = ">";
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            _loc3_ = I18n.getUiText("ui.common.differentFrom") + " >";
         }
         return _loc2_ + " " + _loc3_ + " " + _loc1_;
      }
      
      override public function clone() : IItemCriterion
      {
         var _loc1_:MaxRankCriterion = new MaxRankCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int
      {
         var _loc1_:PartyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
         return _loc1_.arenaRanks[1];
      }
   }
}
