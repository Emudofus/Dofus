package flashx.textLayout.container
{
    import flash.events.*;

    public interface ISandboxSupport
    {

        public function ISandboxSupport();

        function beginMouseCapture() : void;

        function endMouseCapture() : void;

        function mouseUpSomewhere(event:Event) : void;

        function mouseMoveSomewhere(event:Event) : void;

    }
}
