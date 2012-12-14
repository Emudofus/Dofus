package flashx.textLayout.conversion
{
    import __AS3__.vec.*;
    import flashx.textLayout.elements.*;

    public interface ITextImporter
    {

        public function ITextImporter();

        function importToFlow(param1:Object) : TextFlow;

        function get errors() : Vector.<String>;

        function get throwOnError() : Boolean;

        function set throwOnError(param1:Boolean) : void;

        function get useClipboardAnnotations() : Boolean;

        function set useClipboardAnnotations(param1:Boolean) : void;

        function get configuration() : IConfiguration;

        function set configuration(param1:IConfiguration) : void;

    }
}
