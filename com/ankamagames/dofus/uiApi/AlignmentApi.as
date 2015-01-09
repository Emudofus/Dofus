package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.dofus.datacenter.world.MapPosition;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
    import com.ankamagames.dofus.logic.game.common.frames.AlignmentFrame;
    import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentBalance;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentEffect;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentGift;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentRankJntGift;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentOrder;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentRank;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentSide;
    import com.ankamagames.dofus.datacenter.alignments.AlignmentTitle;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.internalDatacenter.conquest.AllianceOnTheHillWrapper;

    [InstanciedApi]
    public class AlignmentApi implements IApi 
    {

        protected var _log:Logger;
        private var _orderRanks:Array;
        private var _rankGifts:Array;
        private var _rankId:uint;
        private var _sideOrders:Array;
        private var _sideId:uint;
        private var include_mapPosition:MapPosition = null;

        public function AlignmentApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(DataApi));
            super();
        }

        private function get allianceFrame():AllianceFrame
        {
            return ((Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame));
        }

        private function get alignmentFrame():AlignmentFrame
        {
            return ((Kernel.getWorker().getFrame(AlignmentFrame) as AlignmentFrame));
        }

        private function get roleplayEntitiesFrame():RoleplayEntitiesFrame
        {
            return ((Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame));
        }

        [Trusted]
        public function destroy():void
        {
            this._orderRanks = null;
            this._rankGifts = null;
            this._sideOrders = null;
        }

        [Untrusted]
        public function getBalance(balanceId:uint):AlignmentBalance
        {
            return (AlignmentBalance.getAlignmentBalanceById(balanceId));
        }

        [Untrusted]
        public function getBalances():Array
        {
            return (AlignmentBalance.getAlignmentBalances());
        }

        [Untrusted]
        public function getEffect(effectId:uint):AlignmentEffect
        {
            return (AlignmentEffect.getAlignmentEffectById(effectId));
        }

        [Untrusted]
        public function getGift(giftId:uint):AlignmentGift
        {
            return (AlignmentGift.getAlignmentGiftById(giftId));
        }

        [Untrusted]
        public function getGifts():Array
        {
            return (AlignmentGift.getAlignmentGifts());
        }

        [Untrusted]
        public function getRankGifts(rankId:uint):AlignmentRankJntGift
        {
            return (AlignmentRankJntGift.getAlignmentRankJntGiftById(rankId));
        }

        [Untrusted]
        public function getGiftEffect(giftId:uint):AlignmentEffect
        {
            return (this.getEffect(this.getGift(giftId).effectId));
        }

        [Untrusted]
        public function getOrder(orderId:uint):AlignmentOrder
        {
            return (AlignmentOrder.getAlignmentOrderById(orderId));
        }

        [Untrusted]
        public function getOrders():Array
        {
            return (AlignmentOrder.getAlignmentOrders());
        }

        [Untrusted]
        public function getRank(rankId:uint):AlignmentRank
        {
            return (AlignmentRank.getAlignmentRankById(rankId));
        }

        [Untrusted]
        public function getRanks():Array
        {
            return (AlignmentRank.getAlignmentRanks());
        }

        [Untrusted]
        public function getRankOrder(rankId:uint):AlignmentOrder
        {
            return (this.getOrder(this.getRank(rankId).orderId));
        }

        [Untrusted]
        public function getOrderRanks(orderId:uint):Array
        {
            var alignmentRank:AlignmentRank;
            var listOrderRanks:Array = new Array();
            var listRanks:Array = AlignmentRank.getAlignmentRanks();
            var nRanks:int = listRanks.length;
            var i:int;
            while (i < nRanks)
            {
                alignmentRank = listRanks[i];
                if (alignmentRank)
                {
                    if (alignmentRank.orderId == orderId)
                    {
                        listOrderRanks.push(alignmentRank);
                    };
                };
                i++;
            };
            return (listOrderRanks.sortOn("minimumAlignment", Array.NUMERIC));
        }

        [Untrusted]
        public function getSide(sideId:uint):AlignmentSide
        {
            return (AlignmentSide.getAlignmentSideById(sideId));
        }

        [Untrusted]
        public function getOrderSide(orderId:uint):AlignmentSide
        {
            return (this.getSide(this.getOrder(orderId).sideId));
        }

        [Untrusted]
        public function getSideOrders(sideId:uint):Array
        {
            this._sideId = sideId;
            AlignmentRank.getAlignmentRanks().forEach(this.filterOrdersBySide);
            return (this._sideOrders);
        }

        [Untrusted]
        public function getTitleName(sideId:uint, grade:int):String
        {
            return (AlignmentTitle.getAlignmentTitlesById(sideId).getNameFromGrade(grade));
        }

        [Untrusted]
        public function getTitleShortName(sideId:uint, grade:int):String
        {
            return (AlignmentTitle.getAlignmentTitlesById(sideId).getShortNameFromGrade(grade));
        }

        [Untrusted]
        public function getPlayerRank():int
        {
            return (this.alignmentFrame.playerRank);
        }

        [Untrusted]
        public function getAlliancesOnTheHill():Vector.<AllianceOnTheHillWrapper>
        {
            return (this.allianceFrame.alliancesOnTheHill);
        }

        private function filterGiftsByRank(rankJntGift:*, index:int, rankJntGifts:Array):void
        {
            var giftsIds:Array;
            var gifts:Array;
            var giftId:int;
            var gift:*;
            this._rankGifts = new Array();
            if (rankJntGift.id == this._rankId)
            {
                giftsIds = rankJntGift.gifts;
                gifts = AlignmentGift.getAlignmentGifts();
                for each (giftId in giftsIds)
                {
                    for each (gift in gifts)
                    {
                        if (giftId == gift.id)
                        {
                            this._rankGifts.push(gift);
                        };
                    };
                };
            };
        }

        private function filterOrdersBySide(order:*, index:int, orders:Array):void
        {
            this._sideOrders = new Array();
            if (order.sideId == this._sideId)
            {
                this._sideOrders.push(order);
            };
        }


    }
}//package com.ankamagames.dofus.uiApi

