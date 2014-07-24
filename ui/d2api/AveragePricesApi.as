package d2api
{
   public class AveragePricesApi extends Object
   {
      
      public function AveragePricesApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getItemAveragePrice(pItemId:uint) : int {
         return 0;
      }
      
      public function getItemAveragePriceString(pItem:*, pAddLineBreakBefore:Boolean = false) : String {
         return null;
      }
      
      public function dataAvailable() : Boolean {
         return false;
      }
   }
}
