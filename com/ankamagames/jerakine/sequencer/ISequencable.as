package com.ankamagames.jerakine.sequencer
{
    import com.ankamagames.jerakine.lua.LuaPackage;

    public interface ISequencable extends LuaPackage 
    {

        function start():void;
        [HideInFakeClass]
        function addListener(_arg_1:ISequencableListener):void;
        [HideInFakeClass]
        function removeListener(_arg_1:ISequencableListener):void;
        function toString():String;
        function clear():void;
        function get isTimeout():Boolean;
        function set timeout(_arg_1:int):void;
        function get timeout():int;
        function get hasDefaultTimeout():Boolean;

    }
}//package com.ankamagames.jerakine.sequencer

