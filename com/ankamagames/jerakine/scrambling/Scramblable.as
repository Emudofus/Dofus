package com.ankamagames.jerakine.scrambling
{
    import flash.utils.*;

    public interface Scramblable
    {

        public function Scramblable();

        function scramble(param1:ByteArray) : void;

        function unscramble(param1:ByteArray) : void;

    }
}
