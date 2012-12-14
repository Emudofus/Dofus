package flashx.textLayout.operations
{
    import flashx.textLayout.edit.*;

    public class FlowTextOperation extends FlowOperation
    {
        private var _originalSelectionState:SelectionState;
        private var _absoluteStart:int;
        private var _absoluteEnd:int;

        public function FlowTextOperation(param1:SelectionState)
        {
            super(param1.textFlow);
            this._absoluteStart = param1.absoluteStart;
            this._absoluteEnd = param1.absoluteEnd;
            this._originalSelectionState = param1;
            return;
        }// end function

        public function get absoluteStart() : int
        {
            return this._absoluteStart;
        }// end function

        public function set absoluteStart(param1:int) : void
        {
            this._absoluteStart = param1;
            return;
        }// end function

        public function get absoluteEnd() : int
        {
            return this._absoluteEnd;
        }// end function

        public function set absoluteEnd(param1:int) : void
        {
            this._absoluteEnd = param1;
            return;
        }// end function

        public function get originalSelectionState() : SelectionState
        {
            return this._originalSelectionState;
        }// end function

        public function set originalSelectionState(param1:SelectionState) : void
        {
            this._originalSelectionState = param1;
            return;
        }// end function

        override public function redo() : SelectionState
        {
            doOperation();
            return this._originalSelectionState;
        }// end function

    }
}
