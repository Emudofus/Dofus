package d2actions
{
   public class SaveMessage extends Object implements IAction
   {
      
      public function SaveMessage(msg:String, channel:uint, timestamp:Number) {
         super();
         this._params = [msg,channel,timestamp];
      }
      
      public static const NEED_INTERACTION:Boolean = false;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 0;
      
      public static const DELAY:int = 0;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
