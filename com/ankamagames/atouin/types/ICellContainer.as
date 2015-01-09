package com.ankamagames.atouin.types
{
    public interface ICellContainer 
    {

        function get cellId():uint;
        function set cellId(_arg_1:uint):void;
        function get layerId():int;
        function set layerId(_arg_1:int):void;
        function get cacheAsBitmap():Boolean;
        function set cacheAsBitmap(_arg_1:Boolean):void;
        function get mouseChildren():Boolean;
        function set mouseChildren(_arg_1:Boolean):void;
        function get mouseEnabled():Boolean;
        function set mouseEnabled(_arg_1:Boolean):void;
        function get startX():int;
        function set startX(_arg_1:int):void;
        function get startY():int;
        function set startY(_arg_1:int):void;
        function get depth():int;
        function set depth(_arg_1:int):void;
        function get x():Number;
        function set x(_arg_1:Number):void;
        function get y():Number;
        function set y(_arg_1:Number):void;
        function addFakeChild(_arg_1:Object, _arg_2:Object, _arg_3:Object):void;

    }
}//package com.ankamagames.atouin.types

