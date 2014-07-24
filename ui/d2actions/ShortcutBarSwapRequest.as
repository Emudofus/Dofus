package d2actions
{
   public class ShortcutBarSwapRequest extends Object implements IAction
   {
      
      public function ShortcutBarSwapRequest(barType:uint, firstSlot:uint, secondSlot:uint) {
         super();
         this._params = [barType,firstSlot,secondSlot];
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
