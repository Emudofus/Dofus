package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.communication.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class EmoteItemCriterion extends ItemCriterion implements IDataCenter
    {

        public function EmoteItemCriterion(param1:String)
        {
            super(param1);
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_2:* = 0;
            var _loc_1:* = (Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame).emotes;
            for each (_loc_2 in _loc_1)
            {
                
                if (_loc_2 == _criterionValue)
                {
                    return true;
                }
            }
            return false;
        }// end function

        override public function get text() : String
        {
            var _loc_1:* = I18n.getUiText("ui.tooltip.possessEmote");
            if (_operator.text == ItemCriterionOperator.DIFFERENT)
            {
                _loc_1 = I18n.getUiText("ui.tooltip.dontPossessEmote");
            }
            return _loc_1 + " \'" + Emoticon.getEmoticonById(_criterionValue).name + "\'";
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new EmoteItemCriterion(this.basicText);
            return _loc_1;
        }// end function

        override protected function getCriterion() : int
        {
            var _loc_2:* = 0;
            var _loc_1:* = (Kernel.getWorker().getFrame(EmoticonFrame) as EmoticonFrame).emotes;
            for each (_loc_2 in _loc_1)
            {
                
                if (_loc_2 == _criterionValue)
                {
                    return 1;
                }
            }
            return 0;
        }// end function

    }
}
