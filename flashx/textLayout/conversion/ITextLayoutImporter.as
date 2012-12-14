package flashx.textLayout.conversion
{
    import flashx.textLayout.conversion.*;

    public interface ITextLayoutImporter extends ITextImporter
    {

        public function ITextLayoutImporter();

        function get imageSourceResolveFunction() : Function;

        function set imageSourceResolveFunction(param1:Function) : void;

    }
}
