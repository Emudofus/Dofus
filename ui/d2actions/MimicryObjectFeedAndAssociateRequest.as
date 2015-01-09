package d2actions
{
    public class MimicryObjectFeedAndAssociateRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function MimicryObjectFeedAndAssociateRequest(mimicryUID:uint, symbiotePos:uint, foodUID:uint, foodPos:uint, hostUID:uint, hostPos:uint, preview:Boolean)
        {
            this._params = [mimicryUID, symbiotePos, foodUID, foodPos, hostUID, hostPos, preview];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}//package d2actions

