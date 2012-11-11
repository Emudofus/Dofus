package flashx.textLayout.events
{
    import flash.events.*;
    import flashx.textLayout.elements.*;

    public class StatusChangeEvent extends Event
    {
        private var _element:FlowElement;
        private var _status:String;
        private var _errorEvent:ErrorEvent;
        public static const INLINE_GRAPHIC_STATUS_CHANGE:String = "inlineGraphicStatusChange";

        public function StatusChangeEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:FlowElement = null, param5:String = null, param6:ErrorEvent = null)
        {
            this._element = param4;
            this._status = param5;
            this._errorEvent = param6;
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            return new StatusChangeEvent(type, bubbles, cancelable, this._element, this._status, this._errorEvent);
        }// end function

        public function get element() : FlowElement
        {
            return this._element;
        }// end function

        public function set element(param1:FlowElement) : void
        {
            this._element = param1;
            return;
        }// end function

        public function get status() : String
        {
            return this._status;
        }// end function

        public function set status(param1:String) : void
        {
            this._status = param1;
            return;
        }// end function

        public function get errorEvent() : ErrorEvent
        {
            return this._errorEvent;
        }// end function

        public function set errorEvent(event:ErrorEvent) : void
        {
            this._errorEvent = event;
            return;
        }// end function

    }
}
