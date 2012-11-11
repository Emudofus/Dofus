package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class GraphicElement extends Object
    {
        public var sprite:GraphicContainer;
        public var location:GraphicLocation;
        public var name:String;
        public var render:Boolean = false;
        public var size:GraphicSize;
        public var locations:Array;
        private static var _aGEIndex:Array = new Array();
        static const _log:Logger = Log.getLogger(getQualifiedClassName(GraphicElement));

        public function GraphicElement(param1:GraphicContainer, param2:Array, param3:String)
        {
            this.sprite = param1;
            if (param2 != null && param2[0] != null)
            {
                this.locations = param2;
                this.location = param2[0];
            }
            else
            {
                this.location = new GraphicLocation();
                this.locations = new Array(this.location);
            }
            this.name = param3;
            this.size = new GraphicSize();
            return;
        }// end function

        public static function getGraphicElement(param1:GraphicContainer, param2:Array, param3:String = null) : GraphicElement
        {
            var _loc_4:* = null;
            if (param3 == null || _aGEIndex[param3] == null)
            {
                _loc_4 = new GraphicElement(param1, param2, param3);
                if (param3 != null)
                {
                    _aGEIndex[param3] = _loc_4;
                }
            }
            else
            {
                _loc_4 = _aGEIndex[param3];
            }
            if (param2 != null)
            {
                _loc_4.locations = param2;
                if (param2 != null && param2[0] != null)
                {
                    _loc_4.location = param2[0];
                }
            }
            return _loc_4;
        }// end function

        public static function init() : void
        {
            _aGEIndex = new Array();
            return;
        }// end function

    }
}
