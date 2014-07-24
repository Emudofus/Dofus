package d2actions
{
   public class OpenMap extends Object implements IAction
   {
      
      public function OpenMap(ignoreSetting:Boolean = false, pocket:Boolean = true, conquest:Boolean = false) {
         super();
         this._params = [ignoreSetting,pocket,conquest];
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
