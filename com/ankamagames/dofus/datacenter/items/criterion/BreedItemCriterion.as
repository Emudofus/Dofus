package com.ankamagames.dofus.datacenter.items.criterion
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.datacenter.breeds.Breed;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class BreedItemCriterion extends ItemCriterion implements IDataCenter
   {
      
      public function BreedItemCriterion(param1:String) {
         super(param1);
      }
      
      override public function get text() : String {
         var _loc1_:String = Breed.getBreedById(Number(_criterionValue)).shortName;
         if(_operator.text == ItemCriterionOperator.EQUAL)
         {
            return I18n.getUiText("ui.tooltip.beABreed",[_loc1_]);
         }
         if(_operator.text == ItemCriterionOperator.DIFFERENT)
         {
            return I18n.getUiText("ui.tooltip.dontBeABreed",[_loc1_]);
         }
         return "";
      }
      
      override public function clone() : IItemCriterion {
         var _loc1_:BreedItemCriterion = new BreedItemCriterion(this.basicText);
         return _loc1_;
      }
      
      override protected function getCriterion() : int {
         var _loc1_:int = PlayedCharacterManager.getInstance().infos.breed;
         return _loc1_;
      }
   }
}
