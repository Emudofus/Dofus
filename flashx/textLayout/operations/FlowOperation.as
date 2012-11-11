package flashx.textLayout.operations
{
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.undo.*;

    public class FlowOperation extends Object implements IOperation
    {
        public var userData:Object;
        private var _beginGeneration:uint;
        private var _endGeneration:uint;
        private var _textFlow:TextFlow;

        public function FlowOperation(param1:TextFlow)
        {
            this._textFlow = param1;
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

        public function doOperation() : Boolean
        {
            return false;
        }// end function

        public function undo() : SelectionState
        {
            return null;
        }// end function

        public function canUndo() : Boolean
        {
            return true;
        }// end function

        public function redo() : SelectionState
        {
            return null;
        }// end function

        public function get beginGeneration() : uint
        {
            return this._beginGeneration;
        }// end function

        public function get endGeneration() : uint
        {
            return this._endGeneration;
        }// end function

        public function performUndo() : void
        {
            var _loc_1:* = this.textFlow ? (this.textFlow.interactionManager as IEditManager) : (null);
            if (_loc_1 != null)
            {
                _loc_1.performUndo(this);
            }
            return;
        }// end function

        public function performRedo() : void
        {
            var _loc_1:* = this.textFlow ? (this.textFlow.interactionManager as IEditManager) : (null);
            if (_loc_1 != null)
            {
                _loc_1.performRedo(this);
            }
            return;
        }// end function

        function setGenerations(param1:uint, param2:uint) : void
        {
            this._beginGeneration = param1;
            this._endGeneration = param2;
            return;
        }// end function

        function merge(param1:FlowOperation) : FlowOperation
        {
            return null;
        }// end function

    }
}
