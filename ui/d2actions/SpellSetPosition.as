package d2actions
{
    public class SpellSetPosition implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 0;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function SpellSetPosition(spellID:uint, position:uint)
        {
            this._params = [spellID, position];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}//package d2actions

