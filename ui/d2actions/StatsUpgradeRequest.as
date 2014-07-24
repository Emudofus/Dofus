package d2actions
{
   public class StatsUpgradeRequest extends Object implements IAction
   {
      
      public function StatsUpgradeRequest(statId:uint, boostPoint:uint) {
         super();
         this._params = [statId,boostPoint];
      }
      
      public static const NEED_INTERACTION:Boolean = true;
      
      public static const NEED_CONFIRMATION:Boolean = true;
      
      public static const MAX_USE_PER_FRAME:int = 1;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
