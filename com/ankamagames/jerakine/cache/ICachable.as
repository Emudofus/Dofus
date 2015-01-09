package com.ankamagames.jerakine.cache
{
    import com.ankamagames.jerakine.interfaces.IDestroyable;

    public interface ICachable extends IDestroyable 
    {

        function set name(_arg_1:String):void;
        function get name():String;
        function set inUse(_arg_1:Boolean):void;
        function get inUse():Boolean;

    }
}//package com.ankamagames.jerakine.cache

