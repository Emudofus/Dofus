package com.ankamagames.berilia.types.event
{
    import com.ankamagames.jerakine.logger.*;
    import flash.events.*;
    import flash.utils.*;

    public class HookLogEvent extends LogEvent
    {
        private var _hookName:String;
        private var _params:Array;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function HookLogEvent(param1:String, param2:Array)
        {
            super(null, null, 0);
            this._hookName = param1;
            this._params = param2;
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function get name() : String
        {
            return this._hookName;
        }// end function

        public function get params() : Array
        {
            return this._params;
        }// end function

        override public function clone() : Event
        {
            return new HookLogEvent(this._hookName, this._params);
        }// end function

    }
}
