package com.ankamagames.jerakine.sequencer
{

    public interface ISequencable
    {

        public function ISequencable();

        function start() : void;

        function addListener(param1:ISequencableListener) : void;

        function removeListener(param1:ISequencableListener) : void;

        function toString() : String;

        function clear() : void;

    }
}
