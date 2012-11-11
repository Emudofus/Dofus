package flashx.textLayout.events
{
    import flash.events.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.elements.*;

    public class UpdateCompleteEvent extends Event
    {
        private var _controller:ContainerController;
        private var _textFlow:TextFlow;
        public static const UPDATE_COMPLETE:String = "updateComplete";

        public function UpdateCompleteEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:TextFlow = null, param5:ContainerController = null)
        {
            super(param1, param2, param3);
            this.controller = param5;
            this._textFlow = param4;
            return;
        }// end function

        override public function clone() : Event
        {
            return new UpdateCompleteEvent(type, bubbles, cancelable, this._textFlow, this._controller);
        }// end function

        public function get controller() : ContainerController
        {
            return this._controller;
        }// end function

        public function set controller(param1:ContainerController) : void
        {
            this._controller = param1;
            return;
        }// end function

        public function get textFlow() : TextFlow
        {
            return this._textFlow;
        }// end function

        public function set textFlow(param1:TextFlow) : void
        {
            this._textFlow = param1;
            return;
        }// end function

    }
}
