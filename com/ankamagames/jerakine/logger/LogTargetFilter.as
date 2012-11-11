package com.ankamagames.jerakine.logger
{

    public class LogTargetFilter extends Object
    {
        public var allow:Boolean = true;
        public var target:String;

        public function LogTargetFilter(param1:String, param2:Boolean = true)
        {
            this.target = param1;
            this.allow = param2;
            return;
        }// end function

    }
}
