package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   
   public class RideItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function RideItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = null;
         if(_operator.text == ItemCriterionOperator.EQUAL && _criterionValue == 1 || _operator.text == ItemCriterionOperator.DIFFERENT && _criterionValue == 0)
         {
            _loc1_ = I18n.getUiText("ui.tooltip.mountEquiped");
         }
         if(_operator.text == ItemCriterionOperator.EQUAL && _criterionValue == 0 || _operator.text == ItemCriterionOperator.DIFFERENT && _criterionValue == 1)
         {
            _loc1_ = I18n.getUiText("ui.tooltip.mountNonEquiped");
         }
         return _loc1_;
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:RideItemCriterion = new RideItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         var _loc1_:Boolean = (Kernel.getWorker().getFrame(AbstractEntitiesFrame) as AbstractEntitiesFrame).playerIsOnRide;
         if(_loc1_)
         {
            return 1;
         }
         return 0;
      }
   }
}
