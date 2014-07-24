package d2actions
{
   public class PrismFightSwapRequest extends Object implements IAction
   {
      
      public function PrismFightSwapRequest(subAreaId:uint, targetId:uint) {
         super();
         this._params = [subAreaId,targetId];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 1;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
