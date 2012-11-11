package flashx.textLayout.events
{
    import flash.events.*;
    import flashx.textLayout.elements.*;

    public class FlowElementMouseEvent extends Event
    {
        private var _flowElement:FlowElement;
        private var _originalEvent:MouseEvent;
        public static const MOUSE_DOWN:String = "mouseDown";
        public static const MOUSE_UP:String = "mouseUp";
        public static const MOUSE_MOVE:String = "mouseMove";
        public static const ROLL_OVER:String = "rollOver";
        public static const ROLL_OUT:String = "rollOut";
        public static const CLICK:String = "click";

        public function FlowElementMouseEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:FlowElement = null, param5:MouseEvent = null)
        {
            super(param1, param2, param3);
            this._flowElement = param4;
            this._originalEvent = param5;
            return;
        }// end function

        public function get flowElement() : FlowElement
        {
            return this._flowElement;
        }// end function

        public function set flowElement(param1:FlowElement) : void
        {
            this._flowElement = param1;
            return;
        }// end function

        public function get originalEvent() : MouseEvent
        {
            return this._originalEvent;
        }// end function

        public function set originalEvent(event:MouseEvent) : void
        {
            this._originalEvent = event;
            return;
        }// end function

        override public function clone() : Event
        {
            return new FlowElementMouseEvent(type, bubbles, cancelable, this.flowElement, this.originalEvent);
        }// end function

    }
}
