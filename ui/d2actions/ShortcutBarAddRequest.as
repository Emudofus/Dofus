package d2actions
{
    public class ShortcutBarAddRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function ShortcutBarAddRequest(barType:uint, id:uint, slot:uint)
        {
            this._params = [barType, id, slot];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}//package d2actions

