package com.ankamagames.jerakine.sequencer
{
    import flash.events.IEventDispatcher;

    public interface ISequencer extends ISequencableListener, IEventDispatcher 
    {

        function addStep(_arg_1:ISequencable):void;
        function start():void;
        function toString():String;
        function set defaultStepTimeout(_arg_1:int):void;
        function get defaultStepTimeout():int;
        function get length():uint;
        function get steps():Array;
        function clear():void;
        function get running():Boolean;

    }
}//package com.ankamagames.jerakine.sequencer

