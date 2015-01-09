package com.ankamagames.jerakine.types.zones
{
    import __AS3__.vec.Vector;

    public interface IZone 
    {

        function get surface():uint;
        function set minRadius(_arg_1:uint):void;
        function get minRadius():uint;
        function set direction(_arg_1:uint):void;
        function get direction():uint;
        function get radius():uint;
        function set radius(_arg_1:uint):void;
        function getCells(_arg_1:uint=0):Vector.<uint>;

    }
}//package com.ankamagames.jerakine.types.zones

