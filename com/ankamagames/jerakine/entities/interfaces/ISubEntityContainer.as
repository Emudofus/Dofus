package com.ankamagames.jerakine.entities.interfaces
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    public interface ISubEntityContainer 
    {

        function addSubEntity(_arg_1:DisplayObject, _arg_2:uint, _arg_3:uint):void;
        function getSubEntitySlot(_arg_1:uint, _arg_2:uint):DisplayObjectContainer;

    }
}//package com.ankamagames.jerakine.entities.interfaces

