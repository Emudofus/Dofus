package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class BonesItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function BonesItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get text() : String
        {
            if (_criterionValue == 0 && _criterionValueText == "B")
            {
                return I18n.getUiText("ui.criterion.initialBones");
            }
            return I18n.getUiText("ui.criterion.bones") + " " + _operator.text + " " + _criterionValue.toString();
        }// end function

        override public function get isRespected() : Boolean
        {
            if (_criterionValue == 0 && _criterionValueText == "B")
            {
                return PlayedCharacterManager.getInstance().infos.entityLook.bonesId == 1;
            }
            return PlayedCharacterManager.getInstance().infos.entityLook.bonesId == _criterionValue;
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new BonesItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            return PlayedCharacterManager.getInstance().infos.entityLook.bonesId;
        }// end function

    }
}
