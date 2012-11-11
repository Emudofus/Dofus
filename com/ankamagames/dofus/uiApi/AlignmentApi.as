package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.dofus.datacenter.alignments.*;
    import com.ankamagames.dofus.datacenter.world.*;
    import com.ankamagames.dofus.internalDatacenter.conquest.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.logic.game.roleplay.frames.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class AlignmentApi extends Object implements IApi
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
            return;
        }// end function

        private function get prismFrame() : PrismFrame
        {
            return Kernel.getWorker().getFrame(PrismFrame) as PrismFrame;
        }// end function

        private function get alignmentFrame() : AlignmentFrame
        {
            return Kernel.getWorker().getFrame(AlignmentFrame) as AlignmentFrame;
        }// end function

        private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame
        {
            return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
        }// end function

        public function destroy() : void
        {
            this._orderRanks = null;
            this._rankGifts = null;
            this._sideOrders = null;
            return;
        }// end function

        public function getBalance(param1:uint) : AlignmentBalance
        {
            return AlignmentBalance.getAlignmentBalanceById(param1);
        }// end function

        public function getBalances() : Array
        {
            return AlignmentBalance.getAlignmentBalances();
        }// end function

        public function getEffect(param1:uint) : AlignmentEffect
        {
            return AlignmentEffect.getAlignmentEffectById(param1);
        }// end function

        public function getGift(param1:uint) : AlignmentGift
        {
            return AlignmentGift.getAlignmentGiftById(param1);
        }// end function

        public function getGifts() : Array
        {
            return AlignmentGift.getAlignmentGifts();
        }// end function

        public function getRankGifts(param1:uint) : AlignmentRankJntGift
        {
            return AlignmentRankJntGift.getAlignmentRankJntGiftById(param1);
        }// end function

        public function getGiftEffect(param1:uint) : AlignmentEffect
        {
            return this.getEffect(this.getGift(param1).effectId);
        }// end function

        public function getOrder(param1:uint) : AlignmentOrder
        {
            return AlignmentOrder.getAlignmentOrderById(param1);
        }// end function

        public function getOrders() : Array
        {
            return AlignmentOrder.getAlignmentOrders();
        }// end function

        public function getRank(param1:uint) : AlignmentRank
        {
            return AlignmentRank.getAlignmentRankById(param1);
        }// end function

        public function getRanks() : Array
        {
            return AlignmentRank.getAlignmentRanks();
        }// end function

        public function getRankOrder(param1:uint) : AlignmentOrder
        {
            return this.getOrder(this.getRank(param1).orderId);
        }// end function

        public function getOrderRanks(param1:uint) : Array
        {
            var _loc_6:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = AlignmentRank.getAlignmentRanks();
            var _loc_4:* = _loc_3.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_6 = _loc_3[_loc_5];
                if (_loc_6)
                {
                    if (_loc_6.orderId == param1)
                    {
                        _loc_2.push(_loc_6);
                    }
                }
                _loc_5++;
            }
            return _loc_2.sortOn("minimumAlignment", Array.NUMERIC);
        }// end function

        public function getSide(param1:uint) : AlignmentSide
        {
            return AlignmentSide.getAlignmentSideById(param1);
        }// end function

        public function getOrderSide(param1:uint) : AlignmentSide
        {
            return this.getSide(this.getOrder(param1).sideId);
        }// end function

        public function getSideOrders(param1:uint) : Array
        {
            this._sideId = param1;
            AlignmentRank.getAlignmentRanks().forEach(this.filterOrdersBySide);
            return this._sideOrders;
        }// end function

        public function getTitleName(param1:uint, param2:int) : String
        {
            return AlignmentTitle.getAlignmentTitlesById(param1).getNameFromGrade(param2);
        }// end function

        public function getTitleShortName(param1:uint, param2:int) : String
        {
            return AlignmentTitle.getAlignmentTitlesById(param1).getShortNameFromGrade(param2);
        }// end function

        public function getAngelsSubAreas() : Vector.<int>
        {
            return this.alignmentFrame.angelsSubAreas;
        }// end function

        public function getEvilsSubAreas() : Vector.<int>
        {
            return this.alignmentFrame.evilsSubAreas;
        }// end function

        public function getPlayerRank() : int
        {
            return this.alignmentFrame.playerRank;
        }// end function

        public function getPrismAttackers() : Array
        {
            return this.prismFrame.attackers;
        }// end function

        public function getPrismReserves() : Array
        {
            return this.prismFrame.reserves;
        }// end function

        public function getPrismDefenders() : Array
        {
            return this.prismFrame.defenders;
        }// end function

        public function isPlayerDefender() : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = PlayedCharacterManager.getInstance().id;
            for each (_loc_2 in this.getPrismDefenders())
            {
                
                if (_loc_2.playerCharactersInformations.id == _loc_1)
                {
                    return true;
                }
            }
            for each (_loc_3 in this.getPrismReserves())
            {
                
                if (_loc_2.playerCharactersInformations.id == _loc_1)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getPrismLocalisation() : Object
        {
            var _loc_1:* = new Object();
            _loc_1.worldX = this.prismFrame.worldX;
            _loc_1.worldY = this.prismFrame.worldY;
            _loc_1.subareaId = this.prismFrame.subareaId;
            return _loc_1;
        }// end function

        public function getCurrentSubAreaAlignment() : int
        {
            return this.roleplayEntitiesFrame.currentSubAreaSide;
        }// end function

        private function filterGiftsByRank(param1, param2:int, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = undefined;
            this._rankGifts = new Array();
            if (param1.id == this._rankId)
            {
                _loc_4 = param1.gifts;
                _loc_5 = AlignmentGift.getAlignmentGifts();
                for each (_loc_6 in _loc_4)
                {
                    
                    for each (_loc_7 in _loc_5)
                    {
                        
                        if (_loc_6 == _loc_7.id)
                        {
                            this._rankGifts.push(_loc_7);
                        }
                    }
                }
            }
            return;
        }// end function

        private function filterOrdersBySide(param1, param2:int, param3:Array) : void
        {
            this._sideOrders = new Array();
            if (param1.sideId == this._sideId)
            {
                this._sideOrders.push(param1);
            }
            return;
        }// end function

    }
}
