package flashx.textLayout.conversion
{
    import flashx.textLayout.conversion.*;

    public interface IPlainTextExporter extends ITextExporter
    {

        public function IPlainTextExporter();

        function get paragraphSeparator() : String;

        function set paragraphSeparator(param1:String) : void;

        function get stripDiscretionaryHyphens() : Boolean;

        function set stripDiscretionaryHyphens(param1:Boolean) : void;

    }
}
