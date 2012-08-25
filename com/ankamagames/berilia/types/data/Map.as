package com.ankamagames.berilia.types.data
{
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;

    public class Map extends Object
    {
        public var initialWidth:uint;
        public var initialHeight:uint;
        public var chunckWidth:uint;
        public var chunckHeight:uint;
        public var zoom:Number;
        public var areas:Array;
        public var container:DisplayObjectContainer;
        public var numXChunck:uint;
        public var numYChunck:uint;

        public function Map(param1:Number, param2:String, param3:DisplayObjectContainer, param4:uint, param5:uint, param6:uint, param7:uint)
        {
            var _loc_8:MapArea = null;
            var _loc_11:uint = 0;
            this.areas = [];
            this.zoom = param1;
            this.container = param3;
            this.initialHeight = param5;
            this.initialWidth = param4;
            this.chunckHeight = param7;
            this.chunckWidth = param6;
            param3.doubleClickEnabled = true;
            this.numXChunck = Math.ceil(param4 * param1 / param6);
            this.numYChunck = Math.ceil(param5 * param1 / param7);
            var _loc_9:uint = 1;
            var _loc_10:uint = 0;
            while (_loc_10 < this.numYChunck)
            {
                
                _loc_11 = 0;
                while (_loc_11 < this.numXChunck)
                {
                    
                    _loc_8 = new MapArea(new Uri(param2 + _loc_9 + ".jpg"), _loc_11 * param6 / param1, _loc_10 * param7 / param1, param6 / param1, param7 / param1, this);
                    this.areas.push(_loc_8);
                    _loc_9 = _loc_9 + 1;
                    _loc_11 = _loc_11 + 1;
                }
                _loc_10 = _loc_10 + 1;
            }
            return;
        }// end function

    }
}
