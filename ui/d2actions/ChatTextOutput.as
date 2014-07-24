package d2actions
{
   public class ChatTextOutput extends Object implements IAction
   {
      
      public function ChatTextOutput(msg:String, channel:uint = 0, receiverName:String = "", objects:Object = null) {
         super();
         this._params = [msg,channel,receiverName,objects];
      }
      
      public static const NEED_INTERACTION:Boolean = true;
      
      public static const NEED_CONFIRMATION:Boolean = false;
      
      public static const MAX_USE_PER_FRAME:int = 1;
      
      public static const DELAY:int = 100;
      
      private var _params:Array;
      
      public function get parameters() : Array {
         return this._params;
      }
   }
}
