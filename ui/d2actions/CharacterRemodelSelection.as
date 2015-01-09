package d2actions
{
    public class CharacterRemodelSelection implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function CharacterRemodelSelection(id:int, sex:Boolean, breed:uint, cosmeticId:uint, name:String, colors:Object)
        {
            this._params = [id, sex, breed, cosmeticId, name, colors];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}//package d2actions

