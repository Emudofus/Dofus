package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.world.Area;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class AreaItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function AreaItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get isRespected() : Boolean {
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
            case ItemCriterionOperator.DIFFERENT:
               return super.isRespected;
         }
      }
      
      override public function get text() : String {
         var readableCriterion:String = null;
         var area:Area = Area.getAreaById(_criterionValue);
         if(!area)
         {
            return "error on AreaItemCriterion";
         }
         var areaName:String = area.name;
         switch(_operator.text)
         {
            case ItemCriterionOperator.EQUAL:
               readableCriterion = I18n.getUiText("ui.tooltip.beInArea",[areaName]);
               break;
            case ItemCriterionOperator.DIFFERENT:
               readableCriterion = I18n.getUiText("ui.tooltip.dontBeInArea",[areaName]);
               break;
         }
         return readableCriterion;
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:AreaItemCriterion = new AreaItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         return PlayedCharacterManager.getInstance().currentSubArea.area.id;
      }
   }
}
