package flashx.textLayout.conversion
{
    import __AS3__.vec.*;
    import flashx.textLayout.elements.*;

    public interface ITextExporter
    {

        public function ITextExporter();

        function export(param1:TextFlow, param2:String) : Object;

        function get errors() : Vector.<String>;

        function get throwOnError() : Boolean;

        function set throwOnError(param1:Boolean) : void;

        function get useClipboardAnnotations() : Boolean;

        function set useClipboardAnnotations(param1:Boolean) : void;

    }
}
