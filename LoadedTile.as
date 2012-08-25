package 
{
    import flash.system.*;

    class LoadedTile extends Object
    {
        public var fileName:String;
        public var appDomain:ApplicationDomain;
        private var _clips:Array;

        function LoadedTile(param1:String) : void
        {
            this.fileName = param1;
            this._clips = new Array();
            return;
        }// end function

        public function addClip(param1:String, param2:Object = null) : void
        {
            var _loc_3:* = this.getClip(param1);
            if (_loc_3 == null)
            {
                _loc_3 = new Object();
                _loc_3.clipName = param1;
                _loc_3.clip = param2;
                this._clips.push(_loc_3);
            }
            else
            {
                _loc_3.clip = param2;
            }
            return;
        }// end function

        public function getClip(param1:String) : Object
        {
            var _loc_2:Object = null;
            for each (_loc_2 in this._clips)
            {
                
                if (_loc_2.clipName == param1)
                {
                    return _loc_2;
                }
            }
            return null;
        }// end function

    }
}
