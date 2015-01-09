package com.ankamagames.tubul.interfaces
{
    import flash.geom.Point;

    public interface ILocalizedSound extends ISound 
    {

        function get range():Number;
        function set range(_arg_1:Number):void;
        function get saturationRange():Number;
        function set saturationRange(_arg_1:Number):void;
        function get position():Point;
        function set position(_arg_1:Point):void;
        function get pan():Number;
        function set pan(_arg_1:Number):void;
        function get volumeMax():Number;
        function set volumeMax(_arg_1:Number):void;

    }
}//package com.ankamagames.tubul.interfaces

