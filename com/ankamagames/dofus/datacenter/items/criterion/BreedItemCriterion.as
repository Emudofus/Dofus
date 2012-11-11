package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.breeds.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class BreedItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function BreedItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = Breed.getBreedById(Number(_criterionValue)).shortName;
            if (_operator.text == ItemCriterionOperator.EQUAL)
            {
                return I18n.getUiText("ui.tooltip.beABreed", [_loc_1]);
            }
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                return I18n.getUiText("ui.tooltip.dontBeABreed", [_loc_1]);
            }
            return "";
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new BreedItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_1:* = PlayedCharacterManager.getInstance().infos.breed;
            return _loc_1;
        }// end function

    }
}
