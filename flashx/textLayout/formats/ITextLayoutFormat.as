package flashx.textLayout.formats
{

    public interface ITextLayoutFormat
    {

        public function ITextLayoutFormat();

        function getStyle(param1:String);

        function get columnBreakBefore();

        function get columnBreakAfter();

        function get containerBreakBefore();

        function get containerBreakAfter();

        function get color();

        function get backgroundColor();

        function get lineThrough();

        function get textAlpha();

        function get backgroundAlpha();

        function get fontSize();

        function get baselineShift();

        function get trackingLeft();

        function get trackingRight();

        function get lineHeight();

        function get breakOpportunity();

        function get digitCase();

        function get digitWidth();

        function get dominantBaseline();

        function get kerning();

        function get ligatureLevel();

        function get alignmentBaseline();

        function get locale();

        function get typographicCase();

        function get fontFamily();

        function get textDecoration();

        function get fontWeight();

        function get fontStyle();

        function get whiteSpaceCollapse();

        function get renderingMode();

        function get cffHinting();

        function get fontLookup();

        function get textRotation();

        function get textIndent();

        function get paragraphStartIndent();

        function get paragraphEndIndent();

        function get paragraphSpaceBefore();

        function get paragraphSpaceAfter();

        function get textAlign();

        function get textAlignLast();

        function get textJustify();

        function get justificationRule();

        function get justificationStyle();

        function get direction();

        function get wordSpacing();

        function get tabStops();

        function get leadingModel();

        function get columnGap();

        function get paddingLeft();

        function get paddingTop();

        function get paddingRight();

        function get paddingBottom();

        function get columnCount();

        function get columnWidth();

        function get firstBaselineOffset();

        function get verticalAlign();

        function get blockProgression();

        function get lineBreak();

        function get listStyleType();

        function get listStylePosition();

        function get listAutoPadding();

        function get clearFloats();

        function get styleName();

        function get linkNormalFormat();

        function get linkActiveFormat();

        function get linkHoverFormat();

        function get listMarkerFormat();

    }
}
