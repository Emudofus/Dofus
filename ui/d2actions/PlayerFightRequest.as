package d2actions
{
    public class PlayerFightRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function PlayerFightRequest(targetedPlayerId:uint, ava:Boolean, friendly:Boolean=true, launch:Boolean=false, cellId:int=-1)
        {
            this._params = [targetedPlayerId, ava, friendly, launch, cellId];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}//package d2actions

