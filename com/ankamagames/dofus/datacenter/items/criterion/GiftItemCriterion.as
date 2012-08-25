package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.dofus.datacenter.alignments.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class GiftItemCriterion extends ItemCriterion implements IDataCenter
    {
        private var _aliGiftId:uint;
        private var _aliGiftLevel:int = -1;

        public function GiftItemCriterion(param1:String)
        {
            super(param1);
            var _loc_2:* = String(_criterionValueText).split(",");
            if (_loc_2 && _loc_2.length > 0)
            {
                if (_loc_2.length > 2)
                {
                }
                else
                {
                    this._aliGiftId = uint(_loc_2[0]);
                    this._aliGiftLevel = int(_loc_2[1]);
                }
            }
            else
            {
                this._aliGiftId = uint(_criterionValue);
                this._aliGiftLevel = -1;
            }
            return;
        }// end function

        override public function get isRespected() : Boolean
        {
            var _loc_3:int = 0;
            var _loc_1:* = (Kernel.getWorker().getFrame(AlignmentFrame) as AlignmentFrame).playerRank;
            var _loc_2:* = AlignmentRankJntGift.getAlignmentRankJntGiftById(_loc_1);
            if (_loc_2 && _loc_2.gifts)
            {
                _loc_3 = 0;
                while (_loc_3 < _loc_2.gifts.length)
                {
                    
                    if (_loc_2.gifts[_loc_3] == this._aliGiftId)
                    {
                        if (this._aliGiftLevel != 0)
                        {
                            if (_loc_2.levels[_loc_3] > this._aliGiftLevel)
                            {
                                return true;
                            }
                            return false;
                        }
                        else
                        {
                            return true;
                        }
                    }
                    _loc_3++;
                }
            }
            return false;
        }// end function

        override public function get text() : String
        {
            var _loc_1:Array = null;
            if (_operator.text == ">")
            {
                _loc_1 = _criterionValueText.split(",");
                return I18n.getUiText("ui.pvp.giftRequired", [AlignmentGift.getAlignmentGiftById(this._aliGiftId).name + " > " + this._aliGiftLevel]);
            }
            return I18n.getUiText("ui.pvp.giftRequired", [AlignmentGift.getAlignmentGiftById(this._aliGiftId).name]);
        }// end function

        override public function clone() : IItemCriterion
        {
            var _loc_1:* = new GiftItemCriterion(this.basicText);
            return _loc_1;
        }// end function

    }
}
