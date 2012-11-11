package flashx.textLayout.events
{
    import flash.events.*;
    import flashx.textLayout.operations.*;

    public class FlowOperationEvent extends Event
    {
        private var _op:FlowOperation;
        private var _e:Error;
        private var _level:int;
        public static const FLOW_OPERATION_BEGIN:String = "flowOperationBegin";
        public static const FLOW_OPERATION_END:String = "flowOperationEnd";
        public static const FLOW_OPERATION_COMPLETE:String = "flowOperationComplete";

        public function FlowOperationEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:FlowOperation = null, param5:int = 0, param6:Error = null)
        {
            this._op = param4;
            this._e = param6;
            this._level = param5;
            super(param1, param2, param3);
            return;
        }// end function

        public function get operation() : FlowOperation
        {
            return this._op;
        }// end function

        public function set operation(param1:FlowOperation) : void
        {
            this._op = param1;
            return;
        }// end function

        public function get error() : Error
        {
            return this._e;
        }// end function

        public function set error(param1:Error) : void
        {
            this._e = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        override public function clone() : Event
        {
            return new FlowOperationEvent(type, bubbles, cancelable, this._op, this._level, this._e);
        }// end function

    }
}
