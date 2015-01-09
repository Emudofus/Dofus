package com.ankamagames.jerakine.utils.prng
{
    public interface PRNG 
    {

        function seed(_arg_1:uint):void;
        function nextInt():uint;
        function nextDouble():Number;
        function nextIntR(_arg_1:Number, _arg_2:Number):uint;
        function nextDoubleR(_arg_1:Number, _arg_2:Number):Number;

    }
}//package com.ankamagames.jerakine.utils.prng

