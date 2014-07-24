package d2actions
{
   public class ChatReport extends Object implements IAction
   {
      
      public function ChatReport(reportedId:uint, reason:uint, name:String, channel:uint, fingerprint:String, message:String, timestamp:Number) {
         super();
         this._params = [reportedId,reason,name,channel,fingerprint,message,timestamp];
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
