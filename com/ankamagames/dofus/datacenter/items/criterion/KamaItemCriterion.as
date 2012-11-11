package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class KamaItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function KamaItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = I18n.getUiText("ui.common.kamas");
            return _loc_1 + " " + _operator.text + " " + _criterionValue;
        }// end function

        override public function get isRespected() : Boolean
        {
            return _operator.compare(uint(this.getCriterion()), _criterionValue);
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new KamaItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayedCharacterManager.getInstance().characteristics.kamas;
        }// end function

    }
}
