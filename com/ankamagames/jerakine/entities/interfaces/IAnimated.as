package com.ankamagames.jerakine.entities.interfaces
{
    public interface IAnimated 
    {

        function getDirection():uint;
        function setDirection(_arg_1:uint):void;
        function getAnimation():String;
        function setAnimation(_arg_1:String, _arg_2:int=-1):void;
        function setAnimationAndDirection(_arg_1:String, _arg_2:uint, _arg_3:Boolean=false):void;

    }
}//package com.ankamagames.jerakine.entities.interfaces

