package flashx.textLayout.formats
{
    import flashx.textLayout.formats.*;

    public interface IListMarkerFormat extends ITextLayoutFormat
    {

        public function IListMarkerFormat();

        function get counterReset();

        function get counterIncrement();

        function get beforeContent();

        function get content();

        function get afterContent();

        function get suffix();

    }
}
