package com.ankamagames.jerakine.newCache
{
    public interface ICacheGarbageCollector 
    {

        function set cache(_arg_1:ICache):void;
        function used(_arg_1:*):void;
        function purge(_arg_1:uint):void;

    }
}//package com.ankamagames.jerakine.newCache

