package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class AlignmentItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function AlignmentItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = AlignmentSide.getAlignmentSideById(int(_criterionValue)).name;
         var _loc2_:String = I18n.getUiText("ui.common.alignment");
         var _loc3_:* = ":";
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            _loc3_ = I18n.getUiText("ui.common.differentFrom") + I18n.getUiText("ui.common.colon");
         }
         return _loc2_ + " " + _loc3_ + " " + _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:AlignmentItemCriterion = new AlignmentItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().characteristics.alignmentInfos.alignmentSide;
      }
   }
}
