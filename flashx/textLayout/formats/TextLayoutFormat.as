package flashx.textLayout.formats
{
    import flash.text.engine.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    public class TextLayoutFormat extends Object implements ITextLayoutFormat
    {
        private var _styles:Object;
        private var _sharedStyles:Boolean;
        private static var _columnBreakBeforeProperty:Property;
        private static var _columnBreakAfterProperty:Property;
        private static var _containerBreakBeforeProperty:Property;
        private static var _containerBreakAfterProperty:Property;
        private static var _colorProperty:Property;
        private static var _backgroundColorProperty:Property;
        private static var _lineThroughProperty:Property;
        private static var _textAlphaProperty:Property;
        private static var _backgroundAlphaProperty:Property;
        private static var _fontSizeProperty:Property;
        private static var _baselineShiftProperty:Property;
        private static var _trackingLeftProperty:Property;
        private static var _trackingRightProperty:Property;
        private static var _lineHeightProperty:Property;
        private static var _breakOpportunityProperty:Property;
        private static var _digitCaseProperty:Property;
        private static var _digitWidthProperty:Property;
        private static var _dominantBaselineProperty:Property;
        private static var _kerningProperty:Property;
        private static var _ligatureLevelProperty:Property;
        private static var _alignmentBaselineProperty:Property;
        private static var _localeProperty:Property;
        private static var _typographicCaseProperty:Property;
        private static var _fontFamilyProperty:Property;
        private static var _textDecorationProperty:Property;
        private static var _fontWeightProperty:Property;
        private static var _fontStyleProperty:Property;
        private static var _whiteSpaceCollapseProperty:Property;
        private static var _renderingModeProperty:Property;
        private static var _cffHintingProperty:Property;
        private static var _fontLookupProperty:Property;
        private static var _textRotationProperty:Property;
        private static var _textIndentProperty:Property;
        private static var _paragraphStartIndentProperty:Property;
        private static var _paragraphEndIndentProperty:Property;
        private static var _paragraphSpaceBeforeProperty:Property;
        private static var _paragraphSpaceAfterProperty:Property;
        private static var _textAlignProperty:Property;
        private static var _textAlignLastProperty:Property;
        private static var _textJustifyProperty:Property;
        private static var _justificationRuleProperty:Property;
        private static var _justificationStyleProperty:Property;
        private static var _directionProperty:Property;
        private static var _wordSpacingProperty:Property;
        private static var _tabStopsProperty:Property;
        private static var _leadingModelProperty:Property;
        private static var _columnGapProperty:Property;
        private static var _paddingLeftProperty:Property;
        private static var _paddingTopProperty:Property;
        private static var _paddingRightProperty:Property;
        private static var _paddingBottomProperty:Property;
        private static var _columnCountProperty:Property;
        private static var _columnWidthProperty:Property;
        private static var _firstBaselineOffsetProperty:Property;
        private static var _verticalAlignProperty:Property;
        private static var _blockProgressionProperty:Property;
        private static var _lineBreakProperty:Property;
        private static var _listStyleTypeProperty:Property;
        private static var _listStylePositionProperty:Property;
        private static var _listAutoPaddingProperty:Property;
        private static var _clearFloatsProperty:Property;
        private static var _styleNameProperty:Property;
        private static var _linkNormalFormatProperty:Property;
        private static var _linkActiveFormatProperty:Property;
        private static var _linkHoverFormatProperty:Property;
        private static var _listMarkerFormatProperty:Property;
        private static var _description:Object = {columnBreakBefore:columnBreakBeforeProperty, columnBreakAfter:columnBreakAfterProperty, containerBreakBefore:containerBreakBeforeProperty, containerBreakAfter:containerBreakAfterProperty, color:colorProperty, backgroundColor:backgroundColorProperty, lineThrough:lineThroughProperty, textAlpha:textAlphaProperty, backgroundAlpha:backgroundAlphaProperty, fontSize:fontSizeProperty, baselineShift:baselineShiftProperty, trackingLeft:trackingLeftProperty, trackingRight:trackingRightProperty, lineHeight:lineHeightProperty, breakOpportunity:breakOpportunityProperty, digitCase:digitCaseProperty, digitWidth:digitWidthProperty, dominantBaseline:dominantBaselineProperty, kerning:kerningProperty, ligatureLevel:ligatureLevelProperty, alignmentBaseline:alignmentBaselineProperty, locale:localeProperty, typographicCase:typographicCaseProperty, fontFamily:fontFamilyProperty, textDecoration:textDecorationProperty, fontWeight:fontWeightProperty, fontStyle:fontStyleProperty, whiteSpaceCollapse:whiteSpaceCollapseProperty, renderingMode:renderingModeProperty, cffHinting:cffHintingProperty, fontLookup:fontLookupProperty, textRotation:textRotationProperty, textIndent:textIndentProperty, paragraphStartIndent:paragraphStartIndentProperty, paragraphEndIndent:paragraphEndIndentProperty, paragraphSpaceBefore:paragraphSpaceBeforeProperty, paragraphSpaceAfter:paragraphSpaceAfterProperty, textAlign:textAlignProperty, textAlignLast:textAlignLastProperty, textJustify:textJustifyProperty, justificationRule:justificationRuleProperty, justificationStyle:justificationStyleProperty, direction:directionProperty, wordSpacing:wordSpacingProperty, tabStops:tabStopsProperty, leadingModel:leadingModelProperty, columnGap:columnGapProperty, paddingLeft:paddingLeftProperty, paddingTop:paddingTopProperty, paddingRight:paddingRightProperty, paddingBottom:paddingBottomProperty, columnCount:columnCountProperty, columnWidth:columnWidthProperty, firstBaselineOffset:firstBaselineOffsetProperty, verticalAlign:verticalAlignProperty, blockProgression:blockProgressionProperty, lineBreak:lineBreakProperty, listStyleType:listStyleTypeProperty, listStylePosition:listStylePositionProperty, listAutoPadding:listAutoPaddingProperty, clearFloats:clearFloatsProperty, styleName:styleNameProperty, linkNormalFormat:linkNormalFormatProperty, linkActiveFormat:linkActiveFormatProperty, linkHoverFormat:linkHoverFormatProperty, listMarkerFormat:listMarkerFormatProperty};
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

        public function get columnBreakBefore()
        {
            return this._styles.columnBreakBefore;
        }// end function

        public function set columnBreakBefore(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.columnBreakBeforeProperty, param1);
            return;
        }// end function

        public function get columnBreakAfter()
        {
            return this._styles.columnBreakAfter;
        }// end function

        public function set columnBreakAfter(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.columnBreakAfterProperty, param1);
            return;
        }// end function

        public function get containerBreakBefore()
        {
            return this._styles.containerBreakBefore;
        }// end function

        public function set containerBreakBefore(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.containerBreakBeforeProperty, param1);
            return;
        }// end function

        public function get containerBreakAfter()
        {
            return this._styles.containerBreakAfter;
        }// end function

        public function set containerBreakAfter(param1) : void
        {
            this.setStyleByProperty(TextLayoutFormat.containerBreakAfterProperty, param1);
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

        public static function get columnBreakBeforeProperty() : Property
        {
            if (!_columnBreakBeforeProperty)
            {
                _columnBreakBeforeProperty = Property.NewEnumStringProperty("columnBreakBefore", BreakStyle.AUTO, false, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), BreakStyle.AUTO, BreakStyle.ALWAYS);
            }
            return _columnBreakBeforeProperty;
        }// end function

        public static function get columnBreakAfterProperty() : Property
        {
            if (!_columnBreakAfterProperty)
            {
                _columnBreakAfterProperty = Property.NewEnumStringProperty("columnBreakAfter", BreakStyle.AUTO, false, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), BreakStyle.AUTO, BreakStyle.ALWAYS);
            }
            return _columnBreakAfterProperty;
        }// end function

        public static function get containerBreakBeforeProperty() : Property
        {
            if (!_containerBreakBeforeProperty)
            {
                _containerBreakBeforeProperty = Property.NewEnumStringProperty("containerBreakBefore", BreakStyle.AUTO, false, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), BreakStyle.AUTO, BreakStyle.ALWAYS);
            }
            return _containerBreakBeforeProperty;
        }// end function

        public static function get containerBreakAfterProperty() : Property
        {
            if (!_containerBreakAfterProperty)
            {
                _containerBreakAfterProperty = Property.NewEnumStringProperty("containerBreakAfter", BreakStyle.AUTO, false, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), BreakStyle.AUTO, BreakStyle.ALWAYS);
            }
            return _containerBreakAfterProperty;
        }// end function

        public static function get colorProperty() : Property
        {
            if (!_colorProperty)
            {
                _colorProperty = Property.NewUintOrEnumProperty("color", 0, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), ColorName.BLACK, ColorName.GREEN, ColorName.GRAY, ColorName.BLUE, ColorName.SILVER, ColorName.LIME, ColorName.OLIVE, ColorName.WHITE, ColorName.YELLOW, ColorName.MAROON, ColorName.NAVY, ColorName.RED, ColorName.PURPLE, ColorName.TEAL, ColorName.FUCHSIA, ColorName.AQUA, ColorName.MAGENTA, ColorName.CYAN);
            }
            return _colorProperty;
        }// end function

        public static function get backgroundColorProperty() : Property
        {
            if (!_backgroundColorProperty)
            {
                _backgroundColorProperty = Property.NewUintOrEnumProperty("backgroundColor", BackgroundColor.TRANSPARENT, false, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), BackgroundColor.TRANSPARENT);
            }
            return _backgroundColorProperty;
        }// end function

        public static function get lineThroughProperty() : Property
        {
            if (!_lineThroughProperty)
            {
                _lineThroughProperty = Property.NewBooleanProperty("lineThrough", false, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]));
            }
            return _lineThroughProperty;
        }// end function

        public static function get textAlphaProperty() : Property
        {
            if (!_textAlphaProperty)
            {
                _textAlphaProperty = Property.NewNumberProperty("textAlpha", 1, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), 0, 1);
            }
            return _textAlphaProperty;
        }// end function

        public static function get backgroundAlphaProperty() : Property
        {
            if (!_backgroundAlphaProperty)
            {
                _backgroundAlphaProperty = Property.NewNumberProperty("backgroundAlpha", 1, false, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), 0, 1);
            }
            return _backgroundAlphaProperty;
        }// end function

        public static function get fontSizeProperty() : Property
        {
            if (!_fontSizeProperty)
            {
                _fontSizeProperty = Property.NewNumberProperty("fontSize", 12, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), 1, 720);
            }
            return _fontSizeProperty;
        }// end function

        public static function get baselineShiftProperty() : Property
        {
            if (!_baselineShiftProperty)
            {
                _baselineShiftProperty = Property.NewNumberOrPercentOrEnumProperty("baselineShift", 0, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), -1000, 1000, "-1000%", "1000%", BaselineShift.SUPERSCRIPT, BaselineShift.SUBSCRIPT);
            }
            return _baselineShiftProperty;
        }// end function

        public static function get trackingLeftProperty() : Property
        {
            if (!_trackingLeftProperty)
            {
                _trackingLeftProperty = Property.NewNumberOrPercentProperty("trackingLeft", 0, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), -1000, 1000, "-1000%", "1000%");
            }
            return _trackingLeftProperty;
        }// end function

        public static function get trackingRightProperty() : Property
        {
            if (!_trackingRightProperty)
            {
                _trackingRightProperty = Property.NewNumberOrPercentProperty("trackingRight", 0, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), -1000, 1000, "-1000%", "1000%");
            }
            return _trackingRightProperty;
        }// end function

        public static function get lineHeightProperty() : Property
        {
            if (!_lineHeightProperty)
            {
                _lineHeightProperty = Property.NewNumberOrPercentProperty("lineHeight", "120%", true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), -720, 720, "-1000%", "1000%");
            }
            return _lineHeightProperty;
        }// end function

        public static function get breakOpportunityProperty() : Property
        {
            if (!_breakOpportunityProperty)
            {
                _breakOpportunityProperty = Property.NewEnumStringProperty("breakOpportunity", BreakOpportunity.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), BreakOpportunity.ALL, BreakOpportunity.ANY, BreakOpportunity.AUTO, BreakOpportunity.NONE);
            }
            return _breakOpportunityProperty;
        }// end function

        public static function get digitCaseProperty() : Property
        {
            if (!_digitCaseProperty)
            {
                _digitCaseProperty = Property.NewEnumStringProperty("digitCase", DigitCase.DEFAULT, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), DigitCase.DEFAULT, DigitCase.LINING, DigitCase.OLD_STYLE);
            }
            return _digitCaseProperty;
        }// end function

        public static function get digitWidthProperty() : Property
        {
            if (!_digitWidthProperty)
            {
                _digitWidthProperty = Property.NewEnumStringProperty("digitWidth", DigitWidth.DEFAULT, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), DigitWidth.DEFAULT, DigitWidth.PROPORTIONAL, DigitWidth.TABULAR);
            }
            return _digitWidthProperty;
        }// end function

        public static function get dominantBaselineProperty() : Property
        {
            if (!_dominantBaselineProperty)
            {
                _dominantBaselineProperty = Property.NewEnumStringProperty("dominantBaseline", FormatValue.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), FormatValue.AUTO, TextBaseline.ROMAN, TextBaseline.ASCENT, TextBaseline.DESCENT, TextBaseline.IDEOGRAPHIC_TOP, TextBaseline.IDEOGRAPHIC_CENTER, TextBaseline.IDEOGRAPHIC_BOTTOM);
            }
            return _dominantBaselineProperty;
        }// end function

        public static function get kerningProperty() : Property
        {
            if (!_kerningProperty)
            {
                _kerningProperty = Property.NewEnumStringProperty("kerning", Kerning.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), Kerning.ON, Kerning.OFF, Kerning.AUTO);
            }
            return _kerningProperty;
        }// end function

        public static function get ligatureLevelProperty() : Property
        {
            if (!_ligatureLevelProperty)
            {
                _ligatureLevelProperty = Property.NewEnumStringProperty("ligatureLevel", LigatureLevel.COMMON, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), LigatureLevel.MINIMUM, LigatureLevel.COMMON, LigatureLevel.UNCOMMON, LigatureLevel.EXOTIC);
            }
            return _ligatureLevelProperty;
        }// end function

        public static function get alignmentBaselineProperty() : Property
        {
            if (!_alignmentBaselineProperty)
            {
                _alignmentBaselineProperty = Property.NewEnumStringProperty("alignmentBaseline", TextBaseline.USE_DOMINANT_BASELINE, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), TextBaseline.ROMAN, TextBaseline.ASCENT, TextBaseline.DESCENT, TextBaseline.IDEOGRAPHIC_TOP, TextBaseline.IDEOGRAPHIC_CENTER, TextBaseline.IDEOGRAPHIC_BOTTOM, TextBaseline.USE_DOMINANT_BASELINE);
            }
            return _alignmentBaselineProperty;
        }// end function

        public static function get localeProperty() : Property
        {
            if (!_localeProperty)
            {
                _localeProperty = Property.NewStringProperty("locale", "en", true, TextLayoutFormat.Vector.<String>([Category.CHARACTER, Category.PARAGRAPH]));
            }
            return _localeProperty;
        }// end function

        public static function get typographicCaseProperty() : Property
        {
            if (!_typographicCaseProperty)
            {
                _typographicCaseProperty = Property.NewEnumStringProperty("typographicCase", TLFTypographicCase.DEFAULT, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), TLFTypographicCase.DEFAULT, TLFTypographicCase.CAPS_TO_SMALL_CAPS, TLFTypographicCase.UPPERCASE, TLFTypographicCase.LOWERCASE, TLFTypographicCase.LOWERCASE_TO_SMALL_CAPS);
            }
            return _typographicCaseProperty;
        }// end function

        public static function get fontFamilyProperty() : Property
        {
            if (!_fontFamilyProperty)
            {
                _fontFamilyProperty = Property.NewStringProperty("fontFamily", "Arial", true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]));
            }
            return _fontFamilyProperty;
        }// end function

        public static function get textDecorationProperty() : Property
        {
            if (!_textDecorationProperty)
            {
                _textDecorationProperty = Property.NewEnumStringProperty("textDecoration", TextDecoration.NONE, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), TextDecoration.NONE, TextDecoration.UNDERLINE);
            }
            return _textDecorationProperty;
        }// end function

        public static function get fontWeightProperty() : Property
        {
            if (!_fontWeightProperty)
            {
                _fontWeightProperty = Property.NewEnumStringProperty("fontWeight", FontWeight.NORMAL, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), FontWeight.NORMAL, FontWeight.BOLD);
            }
            return _fontWeightProperty;
        }// end function

        public static function get fontStyleProperty() : Property
        {
            if (!_fontStyleProperty)
            {
                _fontStyleProperty = Property.NewEnumStringProperty("fontStyle", FontPosture.NORMAL, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), FontPosture.NORMAL, FontPosture.ITALIC);
            }
            return _fontStyleProperty;
        }// end function

        public static function get whiteSpaceCollapseProperty() : Property
        {
            if (!_whiteSpaceCollapseProperty)
            {
                _whiteSpaceCollapseProperty = Property.NewEnumStringProperty("whiteSpaceCollapse", WhiteSpaceCollapse.COLLAPSE, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), WhiteSpaceCollapse.PRESERVE, WhiteSpaceCollapse.COLLAPSE);
            }
            return _whiteSpaceCollapseProperty;
        }// end function

        public static function get renderingModeProperty() : Property
        {
            if (!_renderingModeProperty)
            {
                _renderingModeProperty = Property.NewEnumStringProperty("renderingMode", RenderingMode.CFF, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), RenderingMode.NORMAL, RenderingMode.CFF);
            }
            return _renderingModeProperty;
        }// end function

        public static function get cffHintingProperty() : Property
        {
            if (!_cffHintingProperty)
            {
                _cffHintingProperty = Property.NewEnumStringProperty("cffHinting", CFFHinting.HORIZONTAL_STEM, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), CFFHinting.NONE, CFFHinting.HORIZONTAL_STEM);
            }
            return _cffHintingProperty;
        }// end function

        public static function get fontLookupProperty() : Property
        {
            if (!_fontLookupProperty)
            {
                _fontLookupProperty = Property.NewEnumStringProperty("fontLookup", FontLookup.DEVICE, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), FontLookup.DEVICE, FontLookup.EMBEDDED_CFF);
            }
            return _fontLookupProperty;
        }// end function

        public static function get textRotationProperty() : Property
        {
            if (!_textRotationProperty)
            {
                _textRotationProperty = Property.NewEnumStringProperty("textRotation", TextRotation.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CHARACTER]), TextRotation.ROTATE_0, TextRotation.ROTATE_180, TextRotation.ROTATE_270, TextRotation.ROTATE_90, TextRotation.AUTO);
            }
            return _textRotationProperty;
        }// end function

        public static function get textIndentProperty() : Property
        {
            if (!_textIndentProperty)
            {
                _textIndentProperty = Property.NewNumberProperty("textIndent", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), -8000, 8000);
            }
            return _textIndentProperty;
        }// end function

        public static function get paragraphStartIndentProperty() : Property
        {
            if (!_paragraphStartIndentProperty)
            {
                _paragraphStartIndentProperty = Property.NewNumberProperty("paragraphStartIndent", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), 0, 8000);
            }
            return _paragraphStartIndentProperty;
        }// end function

        public static function get paragraphEndIndentProperty() : Property
        {
            if (!_paragraphEndIndentProperty)
            {
                _paragraphEndIndentProperty = Property.NewNumberProperty("paragraphEndIndent", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), 0, 8000);
            }
            return _paragraphEndIndentProperty;
        }// end function

        public static function get paragraphSpaceBeforeProperty() : Property
        {
            if (!_paragraphSpaceBeforeProperty)
            {
                _paragraphSpaceBeforeProperty = Property.NewNumberProperty("paragraphSpaceBefore", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), 0, 8000);
            }
            return _paragraphSpaceBeforeProperty;
        }// end function

        public static function get paragraphSpaceAfterProperty() : Property
        {
            if (!_paragraphSpaceAfterProperty)
            {
                _paragraphSpaceAfterProperty = Property.NewNumberProperty("paragraphSpaceAfter", 0, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), 0, 8000);
            }
            return _paragraphSpaceAfterProperty;
        }// end function

        public static function get textAlignProperty() : Property
        {
            if (!_textAlignProperty)
            {
                _textAlignProperty = Property.NewEnumStringProperty("textAlign", TextAlign.START, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), TextAlign.LEFT, TextAlign.RIGHT, TextAlign.CENTER, TextAlign.JUSTIFY, TextAlign.START, TextAlign.END);
            }
            return _textAlignProperty;
        }// end function

        public static function get textAlignLastProperty() : Property
        {
            if (!_textAlignLastProperty)
            {
                _textAlignLastProperty = Property.NewEnumStringProperty("textAlignLast", TextAlign.START, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), TextAlign.LEFT, TextAlign.RIGHT, TextAlign.CENTER, TextAlign.JUSTIFY, TextAlign.START, TextAlign.END);
            }
            return _textAlignLastProperty;
        }// end function

        public static function get textJustifyProperty() : Property
        {
            if (!_textJustifyProperty)
            {
                _textJustifyProperty = Property.NewEnumStringProperty("textJustify", TextJustify.INTER_WORD, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), TextJustify.INTER_WORD, TextJustify.DISTRIBUTE);
            }
            return _textJustifyProperty;
        }// end function

        public static function get justificationRuleProperty() : Property
        {
            if (!_justificationRuleProperty)
            {
                _justificationRuleProperty = Property.NewEnumStringProperty("justificationRule", FormatValue.AUTO, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), JustificationRule.EAST_ASIAN, JustificationRule.SPACE, FormatValue.AUTO);
            }
            return _justificationRuleProperty;
        }// end function

        public static function get justificationStyleProperty() : Property
        {
            if (!_justificationStyleProperty)
            {
                _justificationStyleProperty = Property.NewEnumStringProperty("justificationStyle", FormatValue.AUTO, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), JustificationStyle.PRIORITIZE_LEAST_ADJUSTMENT, JustificationStyle.PUSH_IN_KINSOKU, JustificationStyle.PUSH_OUT_ONLY, FormatValue.AUTO);
            }
            return _justificationStyleProperty;
        }// end function

        public static function get directionProperty() : Property
        {
            if (!_directionProperty)
            {
                _directionProperty = Property.NewEnumStringProperty("direction", Direction.LTR, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), Direction.LTR, Direction.RTL);
            }
            return _directionProperty;
        }// end function

        public static function get wordSpacingProperty() : Property
        {
            if (!_wordSpacingProperty)
            {
                _wordSpacingProperty = Property.NewSpacingLimitProperty("wordSpacing", "100%, 50%, 150%", true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), "-1000%", "1000%");
            }
            return _wordSpacingProperty;
        }// end function

        public static function get tabStopsProperty() : Property
        {
            if (!_tabStopsProperty)
            {
                _tabStopsProperty = Property.NewTabStopsProperty("tabStops", null, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]));
            }
            return _tabStopsProperty;
        }// end function

        public static function get leadingModelProperty() : Property
        {
            if (!_leadingModelProperty)
            {
                _leadingModelProperty = Property.NewEnumStringProperty("leadingModel", LeadingModel.AUTO, true, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), LeadingModel.ROMAN_UP, LeadingModel.IDEOGRAPHIC_TOP_UP, LeadingModel.IDEOGRAPHIC_CENTER_UP, LeadingModel.IDEOGRAPHIC_TOP_DOWN, LeadingModel.IDEOGRAPHIC_CENTER_DOWN, LeadingModel.APPROXIMATE_TEXT_FIELD, LeadingModel.ASCENT_DESCENT_UP, LeadingModel.BOX, LeadingModel.AUTO);
            }
            return _leadingModelProperty;
        }// end function

        public static function get columnGapProperty() : Property
        {
            if (!_columnGapProperty)
            {
                _columnGapProperty = Property.NewNumberProperty("columnGap", 20, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), 0, 1000);
            }
            return _columnGapProperty;
        }// end function

        public static function get paddingLeftProperty() : Property
        {
            if (!_paddingLeftProperty)
            {
                _paddingLeftProperty = Property.NewNumberOrEnumProperty("paddingLeft", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER, Category.PARAGRAPH]), -8000, 8000, FormatValue.AUTO);
            }
            return _paddingLeftProperty;
        }// end function

        public static function get paddingTopProperty() : Property
        {
            if (!_paddingTopProperty)
            {
                _paddingTopProperty = Property.NewNumberOrEnumProperty("paddingTop", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER, Category.PARAGRAPH]), -8000, 8000, FormatValue.AUTO);
            }
            return _paddingTopProperty;
        }// end function

        public static function get paddingRightProperty() : Property
        {
            if (!_paddingRightProperty)
            {
                _paddingRightProperty = Property.NewNumberOrEnumProperty("paddingRight", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER, Category.PARAGRAPH]), -8000, 8000, FormatValue.AUTO);
            }
            return _paddingRightProperty;
        }// end function

        public static function get paddingBottomProperty() : Property
        {
            if (!_paddingBottomProperty)
            {
                _paddingBottomProperty = Property.NewNumberOrEnumProperty("paddingBottom", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER, Category.PARAGRAPH]), -8000, 8000, FormatValue.AUTO);
            }
            return _paddingBottomProperty;
        }// end function

        public static function get columnCountProperty() : Property
        {
            if (!_columnCountProperty)
            {
                _columnCountProperty = Property.NewIntOrEnumProperty("columnCount", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), 1, 50, FormatValue.AUTO);
            }
            return _columnCountProperty;
        }// end function

        public static function get columnWidthProperty() : Property
        {
            if (!_columnWidthProperty)
            {
                _columnWidthProperty = Property.NewNumberOrEnumProperty("columnWidth", FormatValue.AUTO, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), 0, 8000, FormatValue.AUTO);
            }
            return _columnWidthProperty;
        }// end function

        public static function get firstBaselineOffsetProperty() : Property
        {
            if (!_firstBaselineOffsetProperty)
            {
                _firstBaselineOffsetProperty = Property.NewNumberOrEnumProperty("firstBaselineOffset", BaselineOffset.AUTO, true, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), 0, 1000, BaselineOffset.AUTO, BaselineOffset.ASCENT, BaselineOffset.LINE_HEIGHT);
            }
            return _firstBaselineOffsetProperty;
        }// end function

        public static function get verticalAlignProperty() : Property
        {
            if (!_verticalAlignProperty)
            {
                _verticalAlignProperty = Property.NewEnumStringProperty("verticalAlign", VerticalAlign.TOP, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), VerticalAlign.TOP, VerticalAlign.MIDDLE, VerticalAlign.BOTTOM, VerticalAlign.JUSTIFY);
            }
            return _verticalAlignProperty;
        }// end function

        public static function get blockProgressionProperty() : Property
        {
            if (!_blockProgressionProperty)
            {
                _blockProgressionProperty = Property.NewEnumStringProperty("blockProgression", BlockProgression.TB, true, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), BlockProgression.RL, BlockProgression.TB);
            }
            return _blockProgressionProperty;
        }// end function

        public static function get lineBreakProperty() : Property
        {
            if (!_lineBreakProperty)
            {
                _lineBreakProperty = Property.NewEnumStringProperty("lineBreak", LineBreak.TO_FIT, false, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), LineBreak.EXPLICIT, LineBreak.TO_FIT);
            }
            return _lineBreakProperty;
        }// end function

        public static function get listStyleTypeProperty() : Property
        {
            if (!_listStyleTypeProperty)
            {
                _listStyleTypeProperty = Property.NewEnumStringProperty("listStyleType", ListStyleType.DISC, true, TextLayoutFormat.Vector.<String>([Category.LIST]), ListStyleType.UPPER_ALPHA, ListStyleType.LOWER_ALPHA, ListStyleType.UPPER_ROMAN, ListStyleType.LOWER_ROMAN, ListStyleType.NONE, ListStyleType.DISC, ListStyleType.CIRCLE, ListStyleType.SQUARE, ListStyleType.BOX, ListStyleType.CHECK, ListStyleType.DIAMOND, ListStyleType.HYPHEN, ListStyleType.ARABIC_INDIC, ListStyleType.BENGALI, ListStyleType.DECIMAL, ListStyleType.DECIMAL_LEADING_ZERO, ListStyleType.DEVANAGARI, ListStyleType.GUJARATI, ListStyleType.GURMUKHI, ListStyleType.KANNADA, ListStyleType.PERSIAN, ListStyleType.THAI, ListStyleType.URDU, ListStyleType.CJK_EARTHLY_BRANCH, ListStyleType.CJK_HEAVENLY_STEM, ListStyleType.HANGUL, ListStyleType.HANGUL_CONSTANT, ListStyleType.HIRAGANA, ListStyleType.HIRAGANA_IROHA, ListStyleType.KATAKANA, ListStyleType.KATAKANA_IROHA, ListStyleType.LOWER_ALPHA, ListStyleType.LOWER_GREEK, ListStyleType.LOWER_LATIN, ListStyleType.UPPER_ALPHA, ListStyleType.UPPER_GREEK, ListStyleType.UPPER_LATIN);
            }
            return _listStyleTypeProperty;
        }// end function

        public static function get listStylePositionProperty() : Property
        {
            if (!_listStylePositionProperty)
            {
                _listStylePositionProperty = Property.NewEnumStringProperty("listStylePosition", ListStylePosition.OUTSIDE, true, TextLayoutFormat.Vector.<String>([Category.LIST]), ListStylePosition.INSIDE, ListStylePosition.OUTSIDE);
            }
            return _listStylePositionProperty;
        }// end function

        public static function get listAutoPaddingProperty() : Property
        {
            if (!_listAutoPaddingProperty)
            {
                _listAutoPaddingProperty = Property.NewNumberProperty("listAutoPadding", 40, true, TextLayoutFormat.Vector.<String>([Category.CONTAINER]), -1000, 1000);
            }
            return _listAutoPaddingProperty;
        }// end function

        public static function get clearFloatsProperty() : Property
        {
            if (!_clearFloatsProperty)
            {
                _clearFloatsProperty = Property.NewEnumStringProperty("clearFloats", ClearFloats.NONE, false, TextLayoutFormat.Vector.<String>([Category.PARAGRAPH]), ClearFloats.START, ClearFloats.END, ClearFloats.LEFT, ClearFloats.RIGHT, ClearFloats.BOTH, ClearFloats.NONE);
            }
            return _clearFloatsProperty;
        }// end function

        public static function get styleNameProperty() : Property
        {
            if (!_styleNameProperty)
            {
                _styleNameProperty = Property.NewStringProperty("styleName", null, false, TextLayoutFormat.Vector.<String>([Category.STYLE]));
            }
            return _styleNameProperty;
        }// end function

        public static function get linkNormalFormatProperty() : Property
        {
            if (!_linkNormalFormatProperty)
            {
                _linkNormalFormatProperty = Property.NewTextLayoutFormatProperty("linkNormalFormat", null, true, TextLayoutFormat.Vector.<String>([Category.STYLE]));
            }
            return _linkNormalFormatProperty;
        }// end function

        public static function get linkActiveFormatProperty() : Property
        {
            if (!_linkActiveFormatProperty)
            {
                _linkActiveFormatProperty = Property.NewTextLayoutFormatProperty("linkActiveFormat", null, true, TextLayoutFormat.Vector.<String>([Category.STYLE]));
            }
            return _linkActiveFormatProperty;
        }// end function

        public static function get linkHoverFormatProperty() : Property
        {
            if (!_linkHoverFormatProperty)
            {
                _linkHoverFormatProperty = Property.NewTextLayoutFormatProperty("linkHoverFormat", null, true, TextLayoutFormat.Vector.<String>([Category.STYLE]));
            }
            return _linkHoverFormatProperty;
        }// end function

        public static function get listMarkerFormatProperty() : Property
        {
            if (!_listMarkerFormatProperty)
            {
                _listMarkerFormatProperty = Property.NewListMarkerFormatProperty("listMarkerFormat", null, true, TextLayoutFormat.Vector.<String>([Category.STYLE]));
            }
            return _listMarkerFormatProperty;
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
            var _loc_2:* = param1 as TextLayoutFormat;
            if (_loc_2)
            {
                _loc_2.writableStyles();
                param1 = _loc_2.getStyles();
            }
            if (param1.columnBreakBefore != undefined && param1.columnBreakBefore != TextLayoutFormat.columnBreakBeforeProperty.defaultValue)
            {
                param1.columnBreakBefore = TextLayoutFormat.columnBreakBeforeProperty.defaultValue;
            }
            if (param1.columnBreakAfter != undefined && param1.columnBreakAfter != TextLayoutFormat.columnBreakAfterProperty.defaultValue)
            {
                param1.columnBreakAfter = TextLayoutFormat.columnBreakAfterProperty.defaultValue;
            }
            if (param1.containerBreakBefore != undefined && param1.containerBreakBefore != TextLayoutFormat.containerBreakBeforeProperty.defaultValue)
            {
                param1.containerBreakBefore = TextLayoutFormat.containerBreakBeforeProperty.defaultValue;
            }
            if (param1.containerBreakAfter != undefined && param1.containerBreakAfter != TextLayoutFormat.containerBreakAfterProperty.defaultValue)
            {
                param1.containerBreakAfter = TextLayoutFormat.containerBreakAfterProperty.defaultValue;
            }
            if (param1.backgroundColor != undefined && param1.backgroundColor != TextLayoutFormat.backgroundColorProperty.defaultValue)
            {
                param1.backgroundColor = TextLayoutFormat.backgroundColorProperty.defaultValue;
            }
            if (param1.backgroundAlpha != undefined && param1.backgroundAlpha != TextLayoutFormat.backgroundAlphaProperty.defaultValue)
            {
                param1.backgroundAlpha = TextLayoutFormat.backgroundAlphaProperty.defaultValue;
            }
            if (param1.columnGap != undefined && param1.columnGap != TextLayoutFormat.columnGapProperty.defaultValue)
            {
                param1.columnGap = TextLayoutFormat.columnGapProperty.defaultValue;
            }
            if (param1.paddingLeft != undefined && param1.paddingLeft != TextLayoutFormat.paddingLeftProperty.defaultValue)
            {
                param1.paddingLeft = TextLayoutFormat.paddingLeftProperty.defaultValue;
            }
            if (param1.paddingTop != undefined && param1.paddingTop != TextLayoutFormat.paddingTopProperty.defaultValue)
            {
                param1.paddingTop = TextLayoutFormat.paddingTopProperty.defaultValue;
            }
            if (param1.paddingRight != undefined && param1.paddingRight != TextLayoutFormat.paddingRightProperty.defaultValue)
            {
                param1.paddingRight = TextLayoutFormat.paddingRightProperty.defaultValue;
            }
            if (param1.paddingBottom != undefined && param1.paddingBottom != TextLayoutFormat.paddingBottomProperty.defaultValue)
            {
                param1.paddingBottom = TextLayoutFormat.paddingBottomProperty.defaultValue;
            }
            if (param1.columnCount != undefined && param1.columnCount != TextLayoutFormat.columnCountProperty.defaultValue)
            {
                param1.columnCount = TextLayoutFormat.columnCountProperty.defaultValue;
            }
            if (param1.columnWidth != undefined && param1.columnWidth != TextLayoutFormat.columnWidthProperty.defaultValue)
            {
                param1.columnWidth = TextLayoutFormat.columnWidthProperty.defaultValue;
            }
            if (param1.verticalAlign != undefined && param1.verticalAlign != TextLayoutFormat.verticalAlignProperty.defaultValue)
            {
                param1.verticalAlign = TextLayoutFormat.verticalAlignProperty.defaultValue;
            }
            if (param1.lineBreak != undefined && param1.lineBreak != TextLayoutFormat.lineBreakProperty.defaultValue)
            {
                param1.lineBreak = TextLayoutFormat.lineBreakProperty.defaultValue;
            }
            if (param1.clearFloats != undefined && param1.clearFloats != TextLayoutFormat.clearFloatsProperty.defaultValue)
            {
                param1.clearFloats = TextLayoutFormat.clearFloatsProperty.defaultValue;
            }
            if (param1.styleName != undefined && param1.styleName != TextLayoutFormat.styleNameProperty.defaultValue)
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
