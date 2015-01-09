package com.ankamagames.performance
{
    public interface IBenchmarkTest 
    {

        function run():void;
        function cancel():void;
        function getResults():String;

    }
}//package com.ankamagames.performance

