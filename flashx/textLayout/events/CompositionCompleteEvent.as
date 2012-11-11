package flashx.textLayout.events
{
    import flash.events.*;
    import flashx.textLayout.elements.*;

    public class CompositionCompleteEvent extends Event
    {
        private var _compositionStart:int;
        private var _compositionLength:int;
        private var _textFlow:TextFlow;
        public static const COMPOSITION_COMPLETE:String = "compositionComplete";

        public function CompositionCompleteEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:TextFlow = null, param5:int = 0, param6:int = 0)
        {
            this._compositionStart = param5;
            this._compositionLength = param6;
            this._textFlow = param4;
            super(param1, param2, param3);
            return;
        }// end function

        override public function clone() : Event
        {
            return new CompositionCompleteEvent(type, bubbles, cancelable, this.textFlow, this.compositionStart, this.compositionLength);
        }// end function

        public function get compositionStart() : int
        {
            return this._compositionStart;
        }// end function

        public function set compositionStart(param1:int) : void
        {
            this._compositionStart = param1;
            return;
        }// end function

        public function get compositionLength() : int
        {
            return this._compositionLength;
        }// end function

        public function set compositionLength(param1:int) : void
        {
            this._compositionLength = param1;
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
