package com.ankamagames.jerakine.types
{

    public class Callback extends Object
    {
        public var method:Function;
        public var args:Array;

        public function Callback(param1:Function, ... args)
        {
            this.method = param1;
            this.args = args;
            return;
        }// end function

        public function exec() : void
        {
            this.method.apply(null, this.args);
            return;
        }// end function

    }
}
