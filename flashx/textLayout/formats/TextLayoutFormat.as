package flashx.textLayout.formats
{
    import flash.text.engine.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    public class TextLayoutFormat extends Object implements ITextLayoutFormat
    {
        private var _styles:Object;
        private var _sharedStyles:Boolean;
        public static const colorProperty:Property = Property.NewUintProperty("color", 0, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]));
        public static const backgroundColorProperty:Property = Property.NewUintOrEnumProperty("backgroundColor", BackgroundColor.TRANSPARENT, false, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), BackgroundColor.TRANSPARENT);
        public static const lineThroughProperty:Property = Property.NewBooleanProperty("lineThrough", false, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]));
        public static const textAlphaProperty:Property = Property.NewNumberProperty("textAlpha", 1, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), 0, 1);
        public static const backgroundAlphaProperty:Property = Property.NewNumberProperty("backgroundAlpha", 1, false, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), 0, 1);
        public static const fontSizeProperty:Property = Property.NewNumberProperty("fontSize", 12, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), 1, 720);
        public static const baselineShiftProperty:Property = Property.NewNumberOrPercentOrEnumProperty("baselineShift", 0, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), -1000, 1000, "-1000%", "1000%", BaselineShift.SUPERSCRIPT, BaselineShift.SUBSCRIPT);
        public static const trackingLeftProperty:Property = Property.NewNumberOrPercentProperty("trackingLeft", 0, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), -1000, 1000, "-1000%", "1000%");
        public static const trackingRightProperty:Property = Property.NewNumberOrPercentProperty("trackingRight", 0, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), -1000, 1000, "-1000%", "1000%");
        public static const lineHeightProperty:Property = Property.NewNumberOrPercentProperty("lineHeight", "120%", true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), -720, 720, "-1000%", "1000%");
        public static const breakOpportunityProperty:Property = Property.NewEnumStringProperty("breakOpportunity", BreakOpportunity.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), BreakOpportunity.ALL, BreakOpportunity.ANY, BreakOpportunity.AUTO, BreakOpportunity.NONE);
        public static const digitCaseProperty:Property = Property.NewEnumStringProperty("digitCase", DigitCase.DEFAULT, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), DigitCase.DEFAULT, DigitCase.LINING, DigitCase.OLD_STYLE);
        public static const digitWidthProperty:Property = Property.NewEnumStringProperty("digitWidth", DigitWidth.DEFAULT, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), DigitWidth.DEFAULT, DigitWidth.PROPORTIONAL, DigitWidth.TABULAR);
        public static const dominantBaselineProperty:Property = Property.NewEnumStringProperty("dominantBaseline", FormatValue.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), FormatValue.AUTO, TextBaseline.ROMAN, TextBaseline.ASCENT, TextBaseline.DESCENT, TextBaseline.IDEOGRAPHIC_TOP, TextBaseline.IDEOGRAPHIC_CENTER, TextBaseline.IDEOGRAPHIC_BOTTOM);
        public static const kerningProperty:Property = Property.NewEnumStringProperty("kerning", Kerning.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), Kerning.ON, Kerning.OFF, Kerning.AUTO);
        public static const ligatureLevelProperty:Property = Property.NewEnumStringProperty("ligatureLevel", LigatureLevel.COMMON, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), LigatureLevel.MINIMUM, LigatureLevel.COMMON, LigatureLevel.UNCOMMON, LigatureLevel.EXOTIC);
        public static const alignmentBaselineProperty:Property = Property.NewEnumStringProperty("alignmentBaseline", TextBaseline.USE_DOMINANT_BASELINE, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), TextBaseline.ROMAN, TextBaseline.ASCENT, TextBaseline.DESCENT, TextBaseline.IDEOGRAPHIC_TOP, TextBaseline.IDEOGRAPHIC_CENTER, TextBaseline.IDEOGRAPHIC_BOTTOM, TextBaseline.USE_DOMINANT_BASELINE);
        public static const localeProperty:Property = Property.NewStringProperty("locale", "en", true, TextLayoutFormat.Vector.<String>([Category.CHARACTER, Category.PARAGRAPH]));
        public static const typographicCaseProperty:Property = Property.NewEnumStringProperty("typographicCase", TLFTypographicCase.DEFAULT, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), TLFTypographicCase.DEFAULT, TLFTypographicCase.CAPS_TO_SMALL_CAPS, TLFTypographicCase.UPPERCASE, TLFTypographicCase.LOWERCASE, TLFTypographicCase.LOWERCASE_TO_SMALL_CAPS);
        public static const fontFamilyProperty:Property = Property.NewStringProperty("fontFamily", "Arial", true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]));
        public static const textDecorationProperty:Property = Property.NewEnumStringProperty("textDecoration", TextDecoration.NONE, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), TextDecoration.NONE, TextDecoration.UNDERLINE);
        public static const fontWeightProperty:Property = Property.NewEnumStringProperty("fontWeight", FontWeight.NORMAL, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), FontWeight.NORMAL, FontWeight.BOLD);
        public static const fontStyleProperty:Property = Property.NewEnumStringProperty("fontStyle", FontPosture.NORMAL, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), FontPosture.NORMAL, FontPosture.ITALIC);
        public static const whiteSpaceCollapseProperty:Property = Property.NewEnumStringProperty("whiteSpaceCollapse", WhiteSpaceCollapse.COLLAPSE, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), WhiteSpaceCollapse.PRESERVE, WhiteSpaceCollapse.COLLAPSE);
        public static const renderingModeProperty:Property = Property.NewEnumStringProperty("renderingMode", RenderingMode.CFF, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), RenderingMode.NORMAL, RenderingMode.CFF);
        public static const cffHintingProperty:Property = Property.NewEnumStringProperty("cffHinting", CFFHinting.HORIZONTAL_STEM, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), CFFHinting.NONE, CFFHinting.HORIZONTAL_STEM);
        public static const fontLookupProperty:Property = Property.NewEnumStringProperty("fontLookup", FontLookup.DEVICE, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), FontLookup.DEVICE, FontLookup.EMBEDDED_CFF);
        public static const textRotationProperty:Property = Property.NewEnumStringProperty("textRotation", TextRotation.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), TextRotation.ROTATE_0, TextRotation.ROTATE_180, TextRotation.ROTATE_270, TextRotation.ROTATE_90, TextRotation.AUTO);
        public static const textIndentProperty:Property = Property.NewNumberProperty("textIndent", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), -8000, 8000);
        public static const paragraphStartIndentProperty:Property = Property.NewNumberProperty("paragraphStartIndent", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), 0, 8000);
        public static const paragraphEndIndentProperty:Property = Property.NewNumberProperty("paragraphEndIndent", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), 0, 8000);
        public static const paragraphSpaceBeforeProperty:Property = Property.NewNumberProperty("paragraphSpaceBefore", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), 0, 8000);
        public static const paragraphSpaceAfterProperty:Property = Property.NewNumberProperty("paragraphSpaceAfter", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), 0, 8000);
        public static const textAlignProperty:Property = Property.NewEnumStringProperty("textAlign", TextAlign.START, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), TextAlign.LEFT, TextAlign.RIGHT, TextAlign.CENTER, TextAlign.JUSTIFY, TextAlign.START, TextAlign.END);
        public static const textAlignLastProperty:Property = Property.NewEnumStringProperty("textAlignLast", TextAlign.START, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), TextAlign.LEFT, TextAlign.RIGHT, TextAlign.CENTER, TextAlign.JUSTIFY, TextAlign.START, TextAlign.END);
        public static const textJustifyProperty:Property = Property.NewEnumStringProperty("textJustify", TextJustify.INTER_WORD, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), TextJustify.INTER_WORD, TextJustify.DISTRIBUTE);
        public static const justificationRuleProperty:Property = Property.NewEnumStringProperty("justificationRule", FormatValue.AUTO, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), JustificationRule.EAST_ASIAN, JustificationRule.SPACE, FormatValue.AUTO);
        public static const justificationStyleProperty:Property = Property.NewEnumStringProperty("justificationStyle", FormatValue.AUTO, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), JustificationStyle.PRIORITIZE_LEAST_ADJUSTMENT, JustificationStyle.PUSH_IN_KINSOKU, JustificationStyle.PUSH_OUT_ONLY, FormatValue.AUTO);
        public static const directionProperty:Property = Property.NewEnumStringProperty("direction", Direction.LTR, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), Direction.LTR, Direction.RTL);
        public static const wordSpacingProperty:Property = Property.NewSpacingLimitProperty("wordSpacing", "100%, 50%, 150%", true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), "-1000%", "1000%");
        public static const tabStopsProperty:Property = Property.NewTabStopsProperty("tabStops", null, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]));
        public static const leadingModelProperty:Property = Property.NewEnumStringProperty("leadingModel", LeadingModel.AUTO, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), LeadingModel.ROMAN_UP, LeadingModel.IDEOGRAPHIC_TOP_UP, LeadingModel.IDEOGRAPHIC_CENTER_UP, LeadingModel.IDEOGRAPHIC_TOP_DOWN, LeadingModel.IDEOGRAPHIC_CENTER_DOWN, LeadingModel.APPROXIMATE_TEXT_FIELD, LeadingModel.ASCENT_DESCENT_UP, LeadingModel.BOX, LeadingModel.AUTO);
        public static const columnGapProperty:Property = Property.NewNumberProperty("columnGap", 20, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), 0, 1000);
        public static const paddingLeftProperty:Property = Property.NewNumberOrEnumProperty("paddingLeft", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER, Category.PARAGRAPH]), -8000, 8000, FormatValue.AUTO);
        public static const paddingTopProperty:Property = Property.NewNumberOrEnumProperty("paddingTop", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER, Category.PARAGRAPH]), -8000, 8000, FormatValue.AUTO);
        public static const paddingRightProperty:Property = Property.NewNumberOrEnumProperty("paddingRight", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER, Category.PARAGRAPH]), -8000, 8000, FormatValue.AUTO);
        public static const paddingBottomProperty:Property = Property.NewNumberOrEnumProperty("paddingBottom", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER, Category.PARAGRAPH]), -8000, 8000, FormatValue.AUTO);
        public static const columnCountProperty:Property = Property.NewIntOrEnumProperty("columnCount", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), 1, 50, FormatValue.AUTO);
        public static const columnWidthProperty:Property = Property.NewNumberOrEnumProperty("columnWidth", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), 0, 8000, FormatValue.AUTO);
        public static const firstBaselineOffsetProperty:Property = Property.NewNumberOrEnumProperty("firstBaselineOffset", BaselineOffset.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), 0, 1000, BaselineOffset.AUTO, BaselineOffset.ASCENT, BaselineOffset.LINE_HEIGHT);
        public static const verticalAlignProperty:Property = Property.NewEnumStringProperty("verticalAlign", VerticalAlign.TOP, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), VerticalAlign.TOP, VerticalAlign.MIDDLE, VerticalAlign.BOTTOM, VerticalAlign.JUSTIFY);
        public static const blockProgressionProperty:Property = Property.NewEnumStringProperty("blockProgression", BlockProgression.TB, true, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), BlockProgression.RL, BlockProgression.TB);
        public static const lineBreakProperty:Property = Property.NewEnumStringProperty("lineBreak", LineBreak.TO_FIT, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), LineBreak.EXPLICIT, LineBreak.TO_FIT);
        public static const listStyleTypeProperty:Property = Property.NewEnumStringProperty("listStyleType", ListStyleType.DISC, true, TextLayoutFormat.Vector.<String>([Category.LIST]), ListStyleType.UPPER_ALPHA, ListStyleType.LOWER_ALPHA, ListStyleType.UPPER_ROMAN, ListStyleType.LOWER_ROMAN, ListStyleType.NONE, ListStyleType.DISC, ListStyleType.CIRCLE, ListStyleType.SQUARE, ListStyleType.BOX, ListStyleType.CHECK, ListStyleType.DIAMOND, ListStyleType.HYPHEN, ListStyleType.ARABIC_INDIC, ListStyleType.BENGALI, ListStyleType.DECIMAL, ListStyleType.DECIMAL_LEADING_ZERO, ListStyleType.DEVANAGARI, ListStyleType.GUJARATI, ListStyleType.GURMUKHI, ListStyleType.KANNADA, ListStyleType.PERSIAN, ListStyleType.THAI, ListStyleType.URDU, ListStyleType.CJK_EARTHLY_BRANCH, ListStyleType.CJK_HEAVENLY_STEM, ListStyleType.HANGUL, ListStyleType.HANGUL_CONSTANT, ListStyleType.HIRAGANA, ListStyleType.HIRAGANA_IROHA, ListStyleType.KATAKANA, ListStyleType.KATAKANA_IROHA, ListStyleType.LOWER_ALPHA, ListStyleType.LOWER_GREEK, ListStyleType.LOWER_LATIN, ListStyleType.UPPER_ALPHA, ListStyleType.UPPER_GREEK, ListStyleType.UPPER_LATIN);
        public static const listStylePositionProperty:Property = Property.NewEnumStringProperty("listStylePosition", ListStylePosition.OUTSIDE, true, TextLayoutFormat.Vector.<String>([Category.LIST]), ListStylePosition.INSIDE, ListStylePosition.OUTSIDE);
        public static const listAutoPaddingProperty:Property = Property.NewNumberProperty("listAutoPadding", 40, true, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), -1000, 1000);
        public static const clearFloatsProperty:Property = Property.NewEnumStringProperty("clearFloats", ClearFloats.NONE, false, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), ClearFloats.START, ClearFloats.END, ClearFloats.LEFT, ClearFloats.RIGHT, ClearFloats.BOTH, ClearFloats.NONE);
        public static const styleNameProperty:Property = Property.NewStringProperty("styleName", null, false, TextLayoutFormat.Vector.<String>([Category.STYLE]));
        public static const linkNormalFormatProperty:Property = Property.NewTextLayoutFormatProperty("linkNormalFormat", null, true, TextLayoutFormat.Vector.<String>([Category.STYLE]));
        public static const linkActiveFormatProperty:Property = Property.NewTextLayoutFormatProperty("linkActiveFormat", null, true, TextLayoutFormat.Vector.<String>([Category.STYLE]));
        public static const linkHoverFormatProperty:Property = Property.NewTextLayoutFormatProperty("linkHoverFormat", null, true, TextLayoutFormat.Vector.<String>([Category.STYLE]));
        public static const listMarkerFormatProperty:Property = Property.NewListMarkerFormatProperty("listMarkerFormat", null, true, TextLayoutFormat.Vector.<String>([Category.STYLE]));
        private static var _description:Object = {color:colorProperty, backgroundColor:backgroundColorProperty, lineThrough:lineThroughProperty, textAlpha:textAlphaProperty, backgroundAlpha:backgroundAlphaProperty, fontSize:fontSizeProperty, baselineShift:baselineShiftProperty, trackingLeft:trackingLeftProperty, trackingRight:trackingRightProperty, lineHeight:lineHeightProperty, breakOpportunity:breakOpportunityProperty, digitCase:digitCaseProperty, digitWidth:digitWidthProperty, dominantBaseline:dominantBaselineProperty, kerning:kerningProperty, ligatureLevel:ligatureLevelProperty, alignmentBaseline:alignmentBaselineProperty, locale:localeProperty, typographicCase:typographicCaseProperty, fontFamily:fontFamilyProperty, textDecoration:textDecorationProperty, fontWeight:fontWeightProperty, fontStyle:fontStyleProperty, whiteSpaceCollapse:whiteSpaceCollapseProperty, renderingMode:renderingModeProperty, cffHinting:cffHintingProperty, fontLookup:fontLookupProperty, textRotation:textRotationProperty, textIndent:textIndentProperty, paragraphStartIndent:paragraphStartIndentProperty, paragraphEndIndent:paragraphEndIndentProperty, paragraphSpaceBefore:paragraphSpaceBeforeProperty, paragraphSpaceAfter:paragraphSpaceAfterProperty, textAlign:textAlignProperty, textAlignLast:textAlignLastProperty, textJustify:textJustifyProperty, justificationRule:justificationRuleProperty, justificationStyle:justificationStyleProperty, direction:directionProperty, wordSpacing:wordSpacingProperty, tabStops:tabStopsProperty, leadingModel:leadingModelProperty, columnGap:columnGapProperty, paddingLeft:paddingLeftProperty, paddingTop:paddingTopProperty, paddingRight:paddingRightProperty, paddingBottom:paddingBottomProperty, columnCount:columnCountProperty, columnWidth:columnWidthProperty, firstBaselineOffset:firstBaselineOffsetProperty, verticalAlign:verticalAlignProperty, blockProgression:blockProgressionProperty, lineBreak:lineBreakProperty, listStyleType:listStyleTypeProperty, listStylePosition:listStylePositionProperty, listAutoPadding:listAutoPaddingProperty, clearFloats:clearFloatsProperty, styleName:styleNameProperty, linkNormalFormat:linkNormalFormatProperty, linkActiveFormat:linkActiveFormatProperty, linkHoverFormat:linkHoverFormatProperty, listMarkerFormat:listMarkerFormatProperty};
        private static var _emptyTextLayoutFormat:ITextLayoutFormat;
        private static const _emptyStyles:Object = new Object();
        private static var _defaults:TextLayoutFormat;

        public function TextLayoutFormat(param1:ITextLayoutFormat = null)
        {
            this.copy(param1);
            return;
        }// end function

        private function writableStyles() : void
        {
            if (this._sharedStyles)
            {
                this._styles = this._styles == _emptyStyles ? (new Object()) : (Property.createObjectWithPrototype(this._styles));
                this._sharedStyles = false;
            }
            return;
        }// end function

        function getStyles() : Object
        {
            return this._styles == _emptyStyles ? (null) : (this._styles);
        }// end function

        function setStyles(param1:Object, param2:Boolean) : void
        {
            if (this._styles != param1)
            {
                this._styles = param1;
                this._sharedStyles = param2;
            }
            return;
        }// end function

        function clearStyles() : void
        {
            this._styles = _emptyStyles;
            this._sharedStyles = true;
            return;
        }// end function

        public function get coreStyles() : Object
        {
            return this._styles == _emptyStyles ? (null) : (Property.shallowCopyInFilter(this._styles, description));
        }// end function

        public function get userStyles() : Object
        {
            return this._styles == _emptyStyles ? (null) : (Property.shallowCopyNotInFilter(this._styles, description));
        }// end function

        public function get styles() : Object
        {
            return this._styles == _emptyStyles ? (null) : (Property.shallowCopy(this._styles));
        }// end function

        function setStyleByName(param1:String, param2) : void
        {
            this.writableStyles();
            if (param2 !== undefined)
            {
                this._styles[param1] = param2;
            }
            else
            {
                delete this._styles[param1];
                if (this._styles[param1] !== undefined)
                {
                    this._styles = Property.shallowCopy(this._styles);
                    delete this._styles[param1];
                }
            }
            return;
        }// end function

        private function setStyleByProperty(param1:Property, param2) : void
        {
            var _loc_3:* = param1.name;
            param2 = param1.setHelper(this._styles[_loc_3], param2);
            this.setStyleByName(_loc_3, param2);
            return;
        }// end function

        public function setStyle(param1:String, param2) : void
        {
            if (description.hasOwnProperty(param1))
            {
                this[param1] = param2;
            }
            else
            {
                this.setStyleByName(param1, param2);
            }
            return;
        }// end function

        public function getStyle(param1:String)
        {
            return this._styles[param1];
        }// end function

        public function copy(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = undefined;
            if (param1 == this)
            {
                return;
            }
            var _loc_2:* = param1 as TextLayoutFormat;
            if (_loc_2)
            {
                this._styles = _loc_2._styles;
                this._sharedStyles = true;
                _loc_2._sharedStyles = true;
                return;
            }
            this._styles = _emptyStyles;
            this._sharedStyles = true;
            if (param1)
            {
                for each (_loc_3 in TextLayoutFormat.description)
                {
                    
                    _loc_4 = param1[_loc_3.name];
                    if (_loc_4 !== undefined)
                    {
                        this[_loc_3.name] = _loc_4;
                    }
                }
            }
            return;
        }// end function

        public function concat(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = param1 as TextLayoutFormat;
            if (_loc_2)
            {
                _loc_4 = _loc_2._styles;
                for (_loc_5 in _loc_4)
                {
                    
                    _loc_3 = description[_loc_5];
                    if (_loc_3)
                    {
                        this.setStyleByProperty(_loc_3, _loc_3.concatHelper(this._styles[_loc_5], _loc_4[_loc_5]));
                        continue;
                    }
                    this.setStyleByName(_loc_5, Property.defaultConcatHelper(this._styles[_loc_5], _loc_4[_loc_5]));
                }
                return;
            }
            for each (_loc_3 in TextLayoutFormat.description)
            {
                
                this.setStyleByProperty(_loc_3, _loc_3.concatHelper(this._styles[_loc_3.name], param1[_loc_3.name]));
            }
            return;
        }// end function

        public function concatInheritOnly(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = param1 as TextLayoutFormat;
            if (_loc_2)
            {
                _loc_4 = _loc_2._styles;
                for (_loc_5 in _loc_4)
                {
                    
                    _loc_3 = description[_loc_5];
                    if (_loc_3)
                    {
                        this.setStyleByProperty(_loc_3, _loc_3.concatInheritOnlyHelper(this._styles[_loc_5], _loc_4[_loc_5]));
                        continue;
                    }
                    this.setStyleByName(_loc_5, Property.defaultConcatHelper(this._styles[_loc_5], _loc_4[_loc_5]));
                }
                return;
            }
            for each (_loc_3 in TextLayoutFormat.description)
            {
                
                this.setStyleByProperty(_loc_3, _loc_3.concatInheritOnlyHelper(this._styles[_loc_3.name], param1[_loc_3.name]));
            }
            return;
        }// end function

        public function apply(param1:ITextLayoutFormat) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = param1 as TextLayoutFormat;
            if (_loc_2)
            {
                _loc_5 = _loc_2._styles;
                for (_loc_6 in _loc_5)
                {
                    
                    _loc_3 = _loc_5[_loc_6];
                    if (_loc_3 !== undefined)
                    {
                        this.setStyle(_loc_6, _loc_3);
                    }
                }
                return;
            }
            for each (_loc_4 in TextLayoutFormat.description)
            {
                
                _loc_7 = _loc_4.name;
                _loc_3 = param1[_loc_7];
                if (_loc_3 !== undefined)
                {
                    this.setStyle(_loc_7, _loc_3);
                }
            }
            return;
        }// end function

        public function removeMatching(param1:ITextLayoutFormat) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1 == null)
            {
                return;
            }
            var _loc_3:* = param1 as TextLayoutFormat;
            if (_loc_3)
            {
                _loc_4 = _loc_3._styles;
                for (_loc_5 in _loc_4)
                {
                    
                    _loc_2 = description[_loc_5];
                    if (_loc_2)
                    {
                        if (_loc_2.equalHelper(this._styles[_loc_5], _loc_4[_loc_5]))
                        {
                            this[_loc_5] = undefined;
                        }
                        continue;
                    }
                    if (this._styles[_loc_5] == _loc_4[_loc_5])
                    {
                        this.setStyle(_loc_5, undefined);
                    }
                }
                return;
            }
            for each (_loc_2 in TextLayoutFormat.description)
            {
                
                if (_loc_2.equalHelper(this._styles[_loc_2.name], param1[_loc_2.name]))
                {
                    this[_loc_2.name] = undefined;
                }
            }
            return;
        }// end function

        public function removeClashing(param1:ITextLayoutFormat) : void
        {
            var _loc_2:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (param1 == null)
            {
                return;
            }
            var _loc_3:* = param1 as TextLayoutFormat;
            if (_loc_3)
            {
                _loc_4 = _loc_3._styles;
                for (_loc_5 in _loc_4)
                {
                    
                    _loc_2 = description[_loc_5];
                    if (_loc_2)
                    {
                        if (!_loc_2.equalHelper(this._styles[_loc_5], _loc_4[_loc_5]))
                        {
                            this[_loc_5] = undefined;
                        }
                        continue;
                    }
                    if (this._styles[_loc_5] != _loc_4[_loc_5])
                    {
                        this.setStyle(_loc_5, undefined);
                    }
                }
                return;
            }
            for each (_loc_2 in TextLayoutFormat.description)
            {
                
                if (!_loc_2.equalHelper(this._styles[_loc_2.name], param1[_loc_2.name]))
                {
                    this[_loc_2.name] = undefined;
                }
            }
            return;
        }// end function

        public function get color()
        {
            return this._styles.color;
        }// end function

        public function set color(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.colorProperty, param1);
            return;
        }// end function

        public function get backgroundColor()
        {
            return this._styles.backgroundColor;
        }// end function

        public function set backgroundColor(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.backgroundColorProperty, param1);
            return;
        }// end function

        public function get lineThrough()
        {
            return this._styles.lineThrough;
        }// end function

        public function set lineThrough(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.lineThroughProperty, param1);
            return;
        }// end function

        public function get textAlpha()
        {
            return this._styles.textAlpha;
        }// end function

        public function set textAlpha(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.textAlphaProperty, param1);
            return;
        }// end function

        public function get backgroundAlpha()
        {
            return this._styles.backgroundAlpha;
        }// end function

        public function set backgroundAlpha(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.backgroundAlphaProperty, param1);
            return;
        }// end function

        public function get fontSize()
        {
            return this._styles.fontSize;
        }// end function

        public function set fontSize(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.fontSizeProperty, param1);
            return;
        }// end function

        public function get baselineShift()
        {
            return this._styles.baselineShift;
        }// end function

        public function set baselineShift(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.baselineShiftProperty, param1);
            return;
        }// end function

        public function get trackingLeft()
        {
            return this._styles.trackingLeft;
        }// end function

        public function set trackingLeft(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.trackingLeftProperty, param1);
            return;
        }// end function

        public function get trackingRight()
        {
            return this._styles.trackingRight;
        }// end function

        public function set trackingRight(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.trackingRightProperty, param1);
            return;
        }// end function

        public function get lineHeight()
        {
            return this._styles.lineHeight;
        }// end function

        public function set lineHeight(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.lineHeightProperty, param1);
            return;
        }// end function

        public function get breakOpportunity()
        {
            return this._styles.breakOpportunity;
        }// end function

        public function set breakOpportunity(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.breakOpportunityProperty, param1);
            return;
        }// end function

        public function get digitCase()
        {
            return this._styles.digitCase;
        }// end function

        public function set digitCase(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.digitCaseProperty, param1);
            return;
        }// end function

        public function get digitWidth()
        {
            return this._styles.digitWidth;
        }// end function

        public function set digitWidth(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.digitWidthProperty, param1);
            return;
        }// end function

        public function get dominantBaseline()
        {
            return this._styles.dominantBaseline;
        }// end function

        public function set dominantBaseline(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.dominantBaselineProperty, param1);
            return;
        }// end function

        public function get kerning()
        {
            return this._styles.kerning;
        }// end function

        public function set kerning(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.kerningProperty, param1);
            return;
        }// end function

        public function get ligatureLevel()
        {
            return this._styles.ligatureLevel;
        }// end function

        public function set ligatureLevel(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.ligatureLevelProperty, param1);
            return;
        }// end function

        public function get alignmentBaseline()
        {
            return this._styles.alignmentBaseline;
        }// end function

        public function set alignmentBaseline(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.alignmentBaselineProperty, param1);
            return;
        }// end function

        public function get locale()
        {
            return this._styles.locale;
        }// end function

        public function set locale(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.localeProperty, param1);
            return;
        }// end function

        public function get typographicCase()
        {
            return this._styles.typographicCase;
        }// end function

        public function set typographicCase(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.typographicCaseProperty, param1);
            return;
        }// end function

        public function get fontFamily()
        {
            return this._styles.fontFamily;
        }// end function

        public function set fontFamily(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.fontFamilyProperty, param1);
            return;
        }// end function

        public function get textDecoration()
        {
            return this._styles.textDecoration;
        }// end function

        public function set textDecoration(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.textDecorationProperty, param1);
            return;
        }// end function

        public function get fontWeight()
        {
            return this._styles.fontWeight;
        }// end function

        public function set fontWeight(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.fontWeightProperty, param1);
            return;
        }// end function

        public function get fontStyle()
        {
            return this._styles.fontStyle;
        }// end function

        public function set fontStyle(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.fontStyleProperty, param1);
            return;
        }// end function

        public function get whiteSpaceCollapse()
        {
            return this._styles.whiteSpaceCollapse;
        }// end function

        public function set whiteSpaceCollapse(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.whiteSpaceCollapseProperty, param1);
            return;
        }// end function

        public function get renderingMode()
        {
            return this._styles.renderingMode;
        }// end function

        public function set renderingMode(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.renderingModeProperty, param1);
            return;
        }// end function

        public function get cffHinting()
        {
            return this._styles.cffHinting;
        }// end function

        public function set cffHinting(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.cffHintingProperty, param1);
            return;
        }// end function

        public function get fontLookup()
        {
            return this._styles.fontLookup;
        }// end function

        public function set fontLookup(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.fontLookupProperty, param1);
            return;
        }// end function

        public function get textRotation()
        {
            return this._styles.textRotation;
        }// end function

        public function set textRotation(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.textRotationProperty, param1);
            return;
        }// end function

        public function get textIndent()
        {
            return this._styles.textIndent;
        }// end function

        public function set textIndent(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.textIndentProperty, param1);
            return;
        }// end function

        public function get paragraphStartIndent()
        {
            return this._styles.paragraphStartIndent;
        }// end function

        public function set paragraphStartIndent(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.paragraphStartIndentProperty, param1);
            return;
        }// end function

        public function get paragraphEndIndent()
        {
            return this._styles.paragraphEndIndent;
        }// end function

        public function set paragraphEndIndent(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.paragraphEndIndentProperty, param1);
            return;
        }// end function

        public function get paragraphSpaceBefore()
        {
            return this._styles.paragraphSpaceBefore;
        }// end function

        public function set paragraphSpaceBefore(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.paragraphSpaceBeforeProperty, param1);
            return;
        }// end function

        public function get paragraphSpaceAfter()
        {
            return this._styles.paragraphSpaceAfter;
        }// end function

        public function set paragraphSpaceAfter(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.paragraphSpaceAfterProperty, param1);
            return;
        }// end function

        public function get textAlign()
        {
            return this._styles.textAlign;
        }// end function

        public function set textAlign(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.textAlignProperty, param1);
            return;
        }// end function

        public function get textAlignLast()
        {
            return this._styles.textAlignLast;
        }// end function

        public function set textAlignLast(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.textAlignLastProperty, param1);
            return;
        }// end function

        public function get textJustify()
        {
            return this._styles.textJustify;
        }// end function

        public function set textJustify(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.textJustifyProperty, param1);
            return;
        }// end function

        public function get justificationRule()
        {
            return this._styles.justificationRule;
        }// end function

        public function set justificationRule(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.justificationRuleProperty, param1);
            return;
        }// end function

        public function get justificationStyle()
        {
            return this._styles.justificationStyle;
        }// end function

        public function set justificationStyle(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.justificationStyleProperty, param1);
            return;
        }// end function

        public function get direction()
        {
            return this._styles.direction;
        }// end function

        public function set direction(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.directionProperty, param1);
            return;
        }// end function

        public function get wordSpacing()
        {
            return this._styles.wordSpacing;
        }// end function

        public function set wordSpacing(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.wordSpacingProperty, param1);
            return;
        }// end function

        public function get tabStops()
        {
            return this._styles.tabStops;
        }// end function

        public function set tabStops(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.tabStopsProperty, param1);
            return;
        }// end function

        public function get leadingModel()
        {
            return this._styles.leadingModel;
        }// end function

        public function set leadingModel(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.leadingModelProperty, param1);
            return;
        }// end function

        public function get columnGap()
        {
            return this._styles.columnGap;
        }// end function

        public function set columnGap(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.columnGapProperty, param1);
            return;
        }// end function

        public function get paddingLeft()
        {
            return this._styles.paddingLeft;
        }// end function

        public function set paddingLeft(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.paddingLeftProperty, param1);
            return;
        }// end function

        public function get paddingTop()
        {
            return this._styles.paddingTop;
        }// end function

        public function set paddingTop(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.paddingTopProperty, param1);
            return;
        }// end function

        public function get paddingRight()
        {
            return this._styles.paddingRight;
        }// end function

        public function set paddingRight(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.paddingRightProperty, param1);
            return;
        }// end function

        public function get paddingBottom()
        {
            return this._styles.paddingBottom;
        }// end function

        public function set paddingBottom(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.paddingBottomProperty, param1);
            return;
        }// end function

        public function get columnCount()
        {
            return this._styles.columnCount;
        }// end function

        public function set columnCount(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.columnCountProperty, param1);
            return;
        }// end function

        public function get columnWidth()
        {
            return this._styles.columnWidth;
        }// end function

        public function set columnWidth(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.columnWidthProperty, param1);
            return;
        }// end function

        public function get firstBaselineOffset()
        {
            return this._styles.firstBaselineOffset;
        }// end function

        public function set firstBaselineOffset(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.firstBaselineOffsetProperty, param1);
            return;
        }// end function

        public function get verticalAlign()
        {
            return this._styles.verticalAlign;
        }// end function

        public function set verticalAlign(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.verticalAlignProperty, param1);
            return;
        }// end function

        public function get blockProgression()
        {
            return this._styles.blockProgression;
        }// end function

        public function set blockProgression(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.blockProgressionProperty, param1);
            return;
        }// end function

        public function get lineBreak()
        {
            return this._styles.lineBreak;
        }// end function

        public function set lineBreak(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.lineBreakProperty, param1);
            return;
        }// end function

        public function get listStyleType()
        {
            return this._styles.listStyleType;
        }// end function

        public function set listStyleType(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.listStyleTypeProperty, param1);
            return;
        }// end function

        public function get listStylePosition()
        {
            return this._styles.listStylePosition;
        }// end function

        public function set listStylePosition(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.listStylePositionProperty, param1);
            return;
        }// end function

        public function get listAutoPadding()
        {
            return this._styles.listAutoPadding;
        }// end function

        public function set listAutoPadding(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.listAutoPaddingProperty, param1);
            return;
        }// end function

        public function get clearFloats()
        {
            return this._styles.clearFloats;
        }// end function

        public function set clearFloats(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.clearFloatsProperty, param1);
            return;
        }// end function

        public function get styleName()
        {
            return this._styles.styleName;
        }// end function

        public function set styleName(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.styleNameProperty, param1);
            return;
        }// end function

        public function get linkNormalFormat()
        {
            return this._styles.linkNormalFormat;
        }// end function

        public function set linkNormalFormat(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.linkNormalFormatProperty, param1);
            return;
        }// end function

        public function get linkActiveFormat()
        {
            return this._styles.linkActiveFormat;
        }// end function

        public function set linkActiveFormat(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.linkActiveFormatProperty, param1);
            return;
        }// end function

        public function get linkHoverFormat()
        {
            return this._styles.linkHoverFormat;
        }// end function

        public function set linkHoverFormat(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.linkHoverFormatProperty, param1);
            return;
        }// end function

        public function get listMarkerFormat()
        {
            return this._styles.listMarkerFormat;
        }// end function

        public function set listMarkerFormat(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.listMarkerFormatProperty, param1);
            return;
        }// end function

        static function get description() : Object
        {
            return _description;
        }// end function

        static function get emptyTextLayoutFormat() : ITextLayoutFormat
        {
            if (_emptyTextLayoutFormat == null)
            {
                _emptyTextLayoutFormat = new TextLayoutFormat;
            }
            return _emptyTextLayoutFormat;
        }// end function

        public static function isEqual(param1:ITextLayoutFormat, param2:ITextLayoutFormat) : Boolean
        {
            var _loc_5:* = null;
            if (param1 == null)
            {
                param1 = emptyTextLayoutFormat;
            }
            if (param2 == null)
            {
                param2 = emptyTextLayoutFormat;
            }
            if (param1 == param2)
            {
                return true;
            }
            var _loc_3:* = param1 as TextLayoutFormat;
            var _loc_4:* = param2 as TextLayoutFormat;
            if (_loc_3 && _loc_4)
            {
                return Property.equalStyles(_loc_3.getStyles(), _loc_4.getStyles(), TextLayoutFormat.description);
            }
            for each (_loc_5 in TextLayoutFormat.description)
            {
                
                if (!_loc_5.equalHelper(param1[_loc_5.name], param2[_loc_5.name]))
                {
                    return false;
                }
            }
            return true;
        }// end function

        public static function get defaultFormat() : ITextLayoutFormat
        {
            if (_defaults == null)
            {
                _defaults = new TextLayoutFormat;
                Property.defaultsAllHelper(_description, _defaults);
            }
            return _defaults;
        }// end function

        static function resetModifiedNoninheritedStyles(param1:Object) : void
        {
            if (param1.backgroundColor != TextLayoutFormat.backgroundColorProperty.defaultValue)
            {
                param1.backgroundColor = TextLayoutFormat.backgroundColorProperty.defaultValue;
            }
            if (param1.backgroundAlpha != TextLayoutFormat.backgroundAlphaProperty.defaultValue)
            {
                param1.backgroundAlpha = TextLayoutFormat.backgroundAlphaProperty.defaultValue;
            }
            if (param1.columnGap != TextLayoutFormat.columnGapProperty.defaultValue)
            {
                param1.columnGap = TextLayoutFormat.columnGapProperty.defaultValue;
            }
            if (param1.paddingLeft != TextLayoutFormat.paddingLeftProperty.defaultValue)
            {
                param1.paddingLeft = TextLayoutFormat.paddingLeftProperty.defaultValue;
            }
            if (param1.paddingTop != TextLayoutFormat.paddingTopProperty.defaultValue)
            {
                param1.paddingTop = TextLayoutFormat.paddingTopProperty.defaultValue;
            }
            if (param1.paddingRight != TextLayoutFormat.paddingRightProperty.defaultValue)
            {
                param1.paddingRight = TextLayoutFormat.paddingRightProperty.defaultValue;
            }
            if (param1.paddingBottom != TextLayoutFormat.paddingBottomProperty.defaultValue)
            {
                param1.paddingBottom = TextLayoutFormat.paddingBottomProperty.defaultValue;
            }
            if (param1.columnCount != TextLayoutFormat.columnCountProperty.defaultValue)
            {
                param1.columnCount = TextLayoutFormat.columnCountProperty.defaultValue;
            }
            if (param1.columnWidth != TextLayoutFormat.columnWidthProperty.defaultValue)
            {
                param1.columnWidth = TextLayoutFormat.columnWidthProperty.defaultValue;
            }
            if (param1.verticalAlign != TextLayoutFormat.verticalAlignProperty.defaultValue)
            {
                param1.verticalAlign = TextLayoutFormat.verticalAlignProperty.defaultValue;
            }
            if (param1.lineBreak != TextLayoutFormat.lineBreakProperty.defaultValue)
            {
                param1.lineBreak = TextLayoutFormat.lineBreakProperty.defaultValue;
            }
            if (param1.clearFloats != TextLayoutFormat.clearFloatsProperty.defaultValue)
            {
                param1.clearFloats = TextLayoutFormat.clearFloatsProperty.defaultValue;
            }
            if (param1.styleName != TextLayoutFormat.styleNameProperty.defaultValue)
            {
                param1.styleName = TextLayoutFormat.styleNameProperty.defaultValue;
            }
            return;
        }// end function

        public static function createTextLayoutFormat(param1:Object) : TextLayoutFormat
        {
            var _loc_4:* = null;
            var _loc_2:* = param1 as ITextLayoutFormat;
            var _loc_3:* = new TextLayoutFormat(_loc_2);
            if (_loc_2 == null && param1)
            {
                for (_loc_4 in param1)
                {
                    
                    _loc_3.setStyle(_loc_4, param1[_loc_4]);
                }
            }
            return _loc_3;
        }// end function

    }
}
