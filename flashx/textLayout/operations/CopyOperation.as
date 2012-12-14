package flashx.textLayout.operations
{
    import flashx.textLayout.edit.*;

    public class CopyOperation extends FlowTextOperation
    {

        public function CopyOperation(param1:SelectionState)
        {
            super(param1);
            return;
        }// end function

        override public function doOperation() : Boolean
        {
            if (originalSelectionState.activePosition != originalSelectionState.anchorPosition)
            {
                TextClipboard.setContents(TextScrap.createTextScrap(originalSelectionState));
            }
            return true;
        }// end function

        override public function undo() : SelectionState
        {
            return originalSelectionState;
        }// end function

        override public function redo() : SelectionState
        {
            return originalSelectionState;
        }// end function

        override public function canUndo() : Boolean
        {
            return false;
        }// end function

    }
}
