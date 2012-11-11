package flashx.textLayout.edit
{
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    public class SelectionState extends TextRange
    {
        private var _pointFormat:ITextLayoutFormat;
        private var _selectionManagerOperationState:Boolean;

        public function SelectionState(param1:TextFlow, param2:int, param3:int, param4:ITextLayoutFormat = null)
        {
            super(param1, param2, param3);
            if (param4)
            {
                this._pointFormat = param4;
            }
            return;
        }// end function

        override public function updateRange(param1:int, param2:int) : Boolean
        {
            if (super.updateRange(param1, param2))
            {
                this._pointFormat = null;
                return true;
            }
            return false;
        }// end function

        public function get pointFormat() : ITextLayoutFormat
        {
            return this._pointFormat;
        }// end function

        public function set pointFormat(param1:ITextLayoutFormat) : void
        {
            this._pointFormat = param1;
            return;
        }// end function

        function get selectionManagerOperationState() : Boolean
        {
            return this._selectionManagerOperationState;
        }// end function

        function set selectionManagerOperationState(param1:Boolean) : void
        {
            this._selectionManagerOperationState = param1;
            return;
        }// end function

        function clone() : SelectionState
        {
            return new SelectionState(textFlow, anchorPosition, activePosition, this.pointFormat);
        }// end function

    }
}
