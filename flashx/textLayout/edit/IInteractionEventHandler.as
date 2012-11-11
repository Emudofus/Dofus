package flashx.textLayout.edit
{
    import flash.events.*;

    public interface IInteractionEventHandler
    {

        public function IInteractionEventHandler();

        function editHandler(event:Event) : void;

        function keyDownHandler(event:KeyboardEvent) : void;

        function keyUpHandler(event:KeyboardEvent) : void;

        function keyFocusChangeHandler(event:FocusEvent) : void;

        function textInputHandler(event:TextEvent) : void;

        function imeStartCompositionHandler(event:IMEEvent) : void;

        function softKeyboardActivatingHandler(event:Event) : void;

        function mouseDownHandler(event:MouseEvent) : void;

        function mouseMoveHandler(event:MouseEvent) : void;

        function mouseUpHandler(event:MouseEvent) : void;

        function mouseDoubleClickHandler(event:MouseEvent) : void;

        function mouseOverHandler(event:MouseEvent) : void;

        function mouseOutHandler(event:MouseEvent) : void;

        function focusInHandler(event:FocusEvent) : void;

        function focusOutHandler(event:FocusEvent) : void;

        function activateHandler(event:Event) : void;

        function deactivateHandler(event:Event) : void;

        function focusChangeHandler(event:FocusEvent) : void;

        function menuSelectHandler(event:ContextMenuEvent) : void;

        function mouseWheelHandler(event:MouseEvent) : void;

    }
}
