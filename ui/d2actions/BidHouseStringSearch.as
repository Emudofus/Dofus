package d2actions
{
    public class BidHouseStringSearch implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 50;

        private var _params:Array;

        public function BidHouseStringSearch(pSearchString:String)
        {
            this._params = [pSearchString];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}//package d2actions

