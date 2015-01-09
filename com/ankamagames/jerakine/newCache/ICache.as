package com.ankamagames.jerakine.newCache
{
    public interface ICache 
    {

        function get size():uint;
        function destroy():void;
        function contains(_arg_1:*):Boolean;
        function extract(_arg_1:*);
        function peek(_arg_1:*);
        function store(_arg_1:*, _arg_2:*):Boolean;

    }
}//package com.ankamagames.jerakine.newCache

