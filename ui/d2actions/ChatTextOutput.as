package d2actions
{
    public class ChatTextOutput implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = true;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 100;

        private var _params:Array;

        public function ChatTextOutput(msg:String, channel:uint=0, receiverName:String="", objects:Object=null)
        {
            this._params = [msg, channel, receiverName, objects];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}//package d2actions

