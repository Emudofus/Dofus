package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   
   public class RideItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function RideItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         var readableCriterion:String = null;
         if((_operator.text == ItemCriterionOperator.EQUAL) && (_criterionValue == 1) || (_operator.text == ItemCriterionOperator.DIFFERENT) && (_criterionValue == 0))
         {
            readableCriterion = I18n.getUiText("ui.tooltip.mountEquiped");
         }
         if((_operator.text == ItemCriterionOperator.EQUAL) && (_criterionValue == 0) || (_operator.text == ItemCriterionOperator.DIFFERENT) && (_criterionValue == 1))
         {
            readableCriterion = I18n.getUiText("ui.tooltip.mountNonEquiped");
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:RideItemCriterion = new RideItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         var isOnRide:Boolean = (Kernel.getWorker().getFrame(AbstractEntitiesFrame) as AbstractEntitiesFrame).playerIsOnRide;
         if(isOnRide)
         {
            return 1;
         }
         return 0;
      }
   }
}
