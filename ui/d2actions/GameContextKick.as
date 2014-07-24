package d2actions
{
   public class GameContextKick extends Object implements IAction
   {
      
      public function GameContextKick(targetId:uint) {
         super();
         this._params = [targetId];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = true;
      
      public static const MAX_USE_PER_FRAME:int = 0;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
