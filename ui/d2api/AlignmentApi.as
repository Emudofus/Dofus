package d2api
{
    import d2data.AlignmentBalance;
    import d2data.AlignmentEffect;
    import d2data.AlignmentGift;
    import d2data.AlignmentRankJntGift;
    import d2data.AlignmentOrder;
    import d2data.AlignmentRank;
    import d2data.AlignmentSide;

    public class AlignmentApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getBalance(balanceId:uint):AlignmentBalance
        {
            return (null);
        }

        [Untrusted]
        public function getBalances():Object
        {
            return (null);
        }

        [Untrusted]
        public function getEffect(effectId:uint):AlignmentEffect
        {
            return (null);
        }

        [Untrusted]
        public function getGift(giftId:uint):AlignmentGift
        {
            return (null);
        }

        [Untrusted]
        public function getGifts():Object
        {
            return (null);
        }

        [Untrusted]
        public function getRankGifts(rankId:uint):AlignmentRankJntGift
        {
            return (null);
        }

        [Untrusted]
        public function getGiftEffect(giftId:uint):AlignmentEffect
        {
            return (null);
        }

        [Untrusted]
        public function getOrder(orderId:uint):AlignmentOrder
        {
            return (null);
        }

        [Untrusted]
        public function getOrders():Object
        {
            return (null);
        }

        [Untrusted]
        public function getRank(rankId:uint):AlignmentRank
        {
            return (null);
        }

        [Untrusted]
        public function getRanks():Object
        {
            return (null);
        }

        [Untrusted]
        public function getRankOrder(rankId:uint):AlignmentOrder
        {
            return (null);
        }

        [Untrusted]
        public function getOrderRanks(orderId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getSide(sideId:uint):AlignmentSide
        {
            return (null);
        }

        [Untrusted]
        public function getOrderSide(orderId:uint):AlignmentSide
        {
            return (null);
        }

        [Untrusted]
        public function getSideOrders(sideId:uint):Object
        {
            return (null);
        }

        [Untrusted]
        public function getTitleName(sideId:uint, grade:int):String
        {
            return (null);
        }

        [Untrusted]
        public function getTitleShortName(sideId:uint, grade:int):String
        {
            return (null);
        }

        [Untrusted]
        public function getPlayerRank():int
        {
            return (0);
        }

        [Untrusted]
        public function getAlliancesOnTheHill():Object
        {
            return (null);
        }


    }
}//package d2api

