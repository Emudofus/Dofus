﻿package com.ankamagames.dofus.datacenter.items.criterion
{
    import com.ankamagames.jerakine.interfaces.IDataCenter;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.AlignmentFrame;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentRankJntGift;
    import com.ankamagames.jerakine.data.I18n;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentGift;

    public class GiftItemCriterion extends ItemCriterion implements IDataCenter 
    {

        private var _aliGiftId:uint;
        private var _aliGiftLevel:int = -1;

        public function GiftItemCriterion(pCriterion:String)
        {
            super(pCriterion);
            var arrayParams:Array = String(_criterionValueText).split(",");
            if (((arrayParams) && ((arrayParams.length > 0))))
            {
                if (arrayParams.length > 2)
                {
                    trace((("Les paramètres pour le don sont mauvais ! (" + _serverCriterionForm) + ")"));
                }
                else
                {
                    this._aliGiftId = uint(arrayParams[0]);
                    this._aliGiftLevel = int(arrayParams[1]);
                };
            }
            else
            {
                this._aliGiftId = uint(_criterionValue);
                this._aliGiftLevel = -1;
            };
        }

        override public function get isRespected():Boolean
        {
            var rgI:int;
            var rank:int = (Kernel.getWorker().getFrame(AlignmentFrame) as AlignmentFrame).playerRank;
            var rankGift:AlignmentRankJntGift = AlignmentRankJntGift.getAlignmentRankJntGiftById(rank);
            if (((rankGift) && (rankGift.gifts)))
            {
                rgI = 0;
                while (rgI < rankGift.gifts.length)
                {
                    if (rankGift.gifts[rgI] == this._aliGiftId)
                    {
                        if (this._aliGiftLevel != 0)
                        {
                            if (rankGift.levels[rgI] > this._aliGiftLevel)
                            {
                                return (true);
                            };
                            return (false);
                        };
                        return (true);
                    };
                    rgI++;
                };
            };
            return (false);
        }

        override public function get text():String
        {
            var criterionInfo:Array;
            if (_operator.text == ">")
            {
                criterionInfo = _criterionValueText.split(",");
                return (I18n.getUiText("ui.pvp.giftRequired", [((AlignmentGift.getAlignmentGiftById(this._aliGiftId).name + " > ") + this._aliGiftLevel)]));
            };
            return (I18n.getUiText("ui.pvp.giftRequired", [AlignmentGift.getAlignmentGiftById(this._aliGiftId).name]));
        }

        override public function clone():IItemCriterion
        {
            var clonedCriterion:GiftItemCriterion = new GiftItemCriterion(this.basicText);
            return (clonedCriterion);
        }


    }
}//package com.ankamagames.dofus.datacenter.items.criterion
