package com.ankamagames.jerakine.console
{
    public interface ConsoleInstructionHandler 
    {

        function handle(_arg_1:ConsoleHandler, _arg_2:String, _arg_3:Array):void;
        function getHelp(_arg_1:String):String;
        function getParamPossibilities(_arg_1:String, _arg_2:uint=0, _arg_3:Array=null):Array;

    }
}//package com.ankamagames.jerakine.console

