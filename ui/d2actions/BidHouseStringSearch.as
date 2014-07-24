package d2actions
{
   public class BidHouseStringSearch extends Object implements IAction
   {
      
      public function BidHouseStringSearch(pSearchString:String) {
         super();
         this._params = [pSearchString];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 1;
      
      public static const DELAY:int = 50;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
