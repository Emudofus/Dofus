package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class BreedItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function BreedItemCriterion(pCriterion:String) {
         super(pCriterion);
      }
      
      override public function get text() : String {
         var readableCriterionRef:String = Breed.getBreedById(Number(_criterionValue)).shortName;
         if(_operator.text == ItemCriterionOperator.EQUAL)
         {
            return I18n.getUiText("ui.tooltip.beABreed",[readableCriterionRef]);
         }
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            return I18n.getUiText("ui.tooltip.dontBeABreed",[readableCriterionRef]);
         }
         trace("Le critère \'" + _operator.text + "\' n\'est pas correct pour la race (\'=\' ou \'!\')");
         return "";
      }
      
      override public function clone() : IItemCriterion {
         var clonedCriterion:BreedItemCriterion = new BreedItemCriterion(this.basicText);
         return clonedCriterion;
      }
      
      override protected function getCriterion() : int {
         var breed:int = PlayedCharacterManager.getInstance().infos.breed;
         return breed;
      }
   }
}
