package d2actions
{
   public class ResetGame extends Object implements IAction
   {
      
      public function ResetGame(pMsg:String = "") {
         super();
         this._params = [pMsg];
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
