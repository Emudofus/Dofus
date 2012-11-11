package flashx.textLayout.elements
{
    import flashx.textLayout.edit.*;
    import flashx.textLayout.formats.*;

    public interface IConfiguration
    {

        public function IConfiguration();

        function clone() : Configuration;

        function get manageTabKey() : Boolean;

        function get manageEnterKey() : Boolean;

        function get overflowPolicy() : String;

        function get enableAccessibility() : Boolean;

        function get defaultLinkNormalFormat() : ITextLayoutFormat;

        function get defaultLinkHoverFormat() : ITextLayoutFormat;

        function get defaultLinkActiveFormat() : ITextLayoutFormat;

        function get defaultListMarkerFormat() : IListMarkerFormat;

        function get textFlowInitialFormat() : ITextLayoutFormat;

        function get focusedSelectionFormat() : SelectionFormat;

        function get unfocusedSelectionFormat() : SelectionFormat;

        function get inactiveSelectionFormat() : SelectionFormat;

        function get scrollDragDelay() : Number;

        function get scrollDragPixels() : Number;

        function get scrollPagePercentage() : Number;

        function get scrollMouseWheelMultiplier() : Number;

        function get flowComposerClass() : Class;

        function get releaseLineCreationData() : Boolean;

        function get inlineGraphicResolverFunction() : Function;

        function get cursorFunction() : Function;

    }
}
