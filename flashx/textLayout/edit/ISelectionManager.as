package flashx.textLayout.edit
{
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    public interface ISelectionManager extends IInteractionEventHandler
    {

        public function ISelectionManager();

        function get textFlow() : TextFlow;

        function set textFlow(param1:TextFlow) : void;

        function get absoluteStart() : int;

        function get absoluteEnd() : int;

        function selectRange(param1:int, param2:int) : void;

        function selectAll() : void;

        function get anchorPosition() : int;

        function get activePosition() : int;

        function hasSelection() : Boolean;

        function isRangeSelection() : Boolean;

        function getSelectionState() : SelectionState;

        function setSelectionState(param1:SelectionState) : void;

        function refreshSelection() : void;

        function setFocus() : void;

        function get focused() : Boolean;

        function get windowActive() : Boolean;

        function get currentSelectionFormat() : SelectionFormat;

        function getCommonCharacterFormat(param1:TextRange = null) : TextLayoutFormat;

        function getCommonParagraphFormat(param1:TextRange = null) : TextLayoutFormat;

        function getCommonContainerFormat(param1:TextRange = null) : TextLayoutFormat;

        function get editingMode() : String;

        function get focusedSelectionFormat() : SelectionFormat;

        function set focusedSelectionFormat(param1:SelectionFormat) : void;

        function get unfocusedSelectionFormat() : SelectionFormat;

        function set unfocusedSelectionFormat(param1:SelectionFormat) : void;

        function get inactiveSelectionFormat() : SelectionFormat;

        function set inactiveSelectionFormat(param1:SelectionFormat) : void;

        function flushPendingOperations() : void;

        function notifyInsertOrDelete(param1:int, param2:int) : void;

    }
}
