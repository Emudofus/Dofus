package d2actions
{
   public class ShopBuyRequest extends Object implements IAction
   {
      
      public function ShopBuyRequest(articleId:int, quantity:int) {
         super();
         this._params = [articleId,quantity];
      }
      
      public static const NEED_INTERACTION:Boolean = true;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 1;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
