package flashx.textLayout.events
{
    import flash.events.*;
    import flashx.textLayout.edit.*;

    public class SelectionEvent extends Event
    {
        private var _selectionState:SelectionState;
        public static const SELECTION_CHANGE:String = "selectionChange";

        public function SelectionEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:SelectionState = null)
        {
            this._selectionState = param4;
            super(param1, param2, param3);
            return;
        }// end function

        public function get selectionState() : SelectionState
        {
            return this._selectionState;
        }// end function

        public function set selectionState(param1:SelectionState) : void
        {
            this._selectionState = param1;
            return;
        }// end function

        override public function clone() : Event
        {
            return new SelectionEvent(type, bubbles, cancelable, this._selectionState);
        }// end function

    }
}
