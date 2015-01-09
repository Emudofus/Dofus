package d2actions
{
    public class TeleportRequest implements IAction 
    {

        public static const NEED_INTERACTION:Boolean = false;
        public static const NEED_CONFIRMATION:Boolean = false;
        public static const MAX_USE_PER_FRAME:int = 1;
        public static const DELAY:int = 0;

        private var _params:Array;

        public function TeleportRequest(teleportType:uint, mapId:uint, cost:uint)
        {
            this._params = [teleportType, mapId, cost];
        }

        public function get parameters():Array
        {
            return (this._params);
        }


    }
}//package d2actions

