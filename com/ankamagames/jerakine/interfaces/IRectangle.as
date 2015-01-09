package com.ankamagames.jerakine.interfaces
{
    import flash.geom.Point;

    public interface IRectangle 
    {

        function get x():Number;
        function set x(_arg_1:Number):void;
        function get y():Number;
        function set y(_arg_1:Number):void;
        function get width():Number;
        function set width(_arg_1:Number):void;
        function get height():Number;
        function set height(_arg_1:Number):void;
        function localToGlobal(_arg_1:Point):Point;
        function globalToLocal(_arg_1:Point):Point;

    }
}//package com.ankamagames.jerakine.interfaces

