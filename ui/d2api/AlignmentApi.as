package d2api
{
   import d2data.AlignmentBalance;
   import d2data.AlignmentEffect;
   import d2data.AlignmentGift;
   import d2data.AlignmentRankJntGift;
   import d2data.AlignmentOrder;
   import d2data.AlignmentRank;
   import d2data.AlignmentSide;
   
   public class AlignmentApi extends Object
   {
      
      public function AlignmentApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getBalance(balanceId:uint) : AlignmentBalance {
         return null;
      }
      
      public function getBalances() : Object {
         return null;
      }
      
      public function getEffect(effectId:uint) : AlignmentEffect {
         return null;
      }
      
      public function getGift(giftId:uint) : AlignmentGift {
         return null;
      }
      
      public function getGifts() : Object {
         return null;
      }
      
      public function getRankGifts(rankId:uint) : AlignmentRankJntGift {
         return null;
      }
      
      public function getGiftEffect(giftId:uint) : AlignmentEffect {
         return null;
      }
      
      public function getOrder(orderId:uint) : AlignmentOrder {
         return null;
      }
      
      public function getOrders() : Object {
         return null;
      }
      
      public function getRank(rankId:uint) : AlignmentRank {
         return null;
      }
      
      public function getRanks() : Object {
         return null;
      }
      
      public function getRankOrder(rankId:uint) : AlignmentOrder {
         return null;
      }
      
      public function getOrderRanks(orderId:uint) : Object {
         return null;
      }
      
      public function getSide(sideId:uint) : AlignmentSide {
         return null;
      }
      
      public function getOrderSide(orderId:uint) : AlignmentSide {
         return null;
      }
      
      public function getSideOrders(sideId:uint) : Object {
         return null;
      }
      
      public function getTitleName(sideId:uint, grade:int) : String {
         return null;
      }
      
      public function getTitleShortName(sideId:uint, grade:int) : String {
         return null;
      }
      
      public function getPlayerRank() : int {
         return 0;
      }
      
      public function getAlliancesOnTheHill() : Object {
         return null;
      }
   }
}
