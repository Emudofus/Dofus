package flashx.textLayout.conversion
{
    import flashx.textLayout.conversion.*;

    public interface IHTMLImporter extends ITextImporter
    {

        public function IHTMLImporter();

        function get imageSourceResolveFunction() : Function;

        function set imageSourceResolveFunction(param1:Function) : void;

        function get preserveBodyElement() : Boolean;

        function set preserveBodyElement(param1:Boolean) : void;

        function get preserveHTMLElement() : Boolean;

        function set preserveHTMLElement(param1:Boolean) : void;

    }
}
