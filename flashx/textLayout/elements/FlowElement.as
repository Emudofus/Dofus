package flashx.textLayout.elements
{
    import flash.events.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;
    import flashx.textLayout.property.*;

    public class FlowElement extends Object implements ITextLayoutFormat
    {
        private var _parent:FlowGroupElement;
        private var _format:FlowValueHolder;
        protected var _computedFormat:TextLayoutFormat;
        private var _parentRelativeStart:int = 0;
        private var _textLength:int = 0;
        private static const idString:String = "id";
        private static const typeNameString:String = "typeName";
        private static const impliedElementString:String = "impliedElement";
        static var _scratchTextLayoutFormat:TextLayoutFormat = new TextLayoutFormat();

        public function FlowElement()
        {
            if (this.abstract)
            {
                throw new Error(GlobalSettings.resourceStringFunction("invalidFlowElementConstruct"));
            }
            return;
        }// end function

        public function initialized(param1:Object, param2:String) : void
        {
            this.id = param2;
            return;
        }// end function

        protected function get abstract() : Boolean
        {
            return true;
        }// end function

        public function get userStyles() : Object
        {
            return this._format ? (this._format.userStyles) : (null);
        }// end function

        public function set userStyles(param1:Object) : void
        {
            var _loc_2:* = null;
            for (_loc_2 in this.userStyles)
            {
                
                this.setStyle(_loc_2, undefined);
            }
            for (_loc_2 in param1)
            {
                
                if (!TextLayoutFormat.description.hasOwnProperty(_loc_2))
                {
                    this.setStyle(_loc_2, param1[_loc_2]);
                }
            }
            return;
        }// end function

        public function get coreStyles() : Object
        {
            return this._format ? (this._format.coreStyles) : (null);
        }// end function

        public function get styles() : Object
        {
            return this._format ? (this._format.styles) : (null);
        }// end function

        function setStylesInternal(param1:Object) : void
        {
            if (param1)
            {
                this.writableTextLayoutFormat().setStyles(Property.shallowCopy(param1), false);
            }
            else if (this._format)
            {
                this._format.clearStyles();
            }
            this.formatChanged();
            return;
        }// end function

        public function equalUserStyles(param1:FlowElement) : Boolean
        {
            return Property.equalStyles(this.userStyles, param1.userStyles, null);
        }// end function

        function equalStylesForMerge(param1:FlowElement) : Boolean
        {
            return this.id == param1.id && this.typeName == param1.typeName && TextLayoutFormat.isEqual(param1.format, this.format);
        }// end function

        public function shallowCopy(param1:int = 0, param2:int = -1) : FlowElement
        {
            var _loc_3:* = new (getDefinitionByName(getQualifiedClassName(this)) as Class)();
            if (this._format != null)
            {
                _loc_3._format = new FlowValueHolder(this._format);
            }
            return _loc_3;
        }// end function

        public function deepCopy(param1:int = 0, param2:int = -1) : FlowElement
        {
            if (param2 == -1)
            {
                param2 = this._textLength;
            }
            return this.shallowCopy(param1, param2);
        }// end function

        public function getText(param1:int = 0, param2:int = -1, param3:String = "\n") : String
        {
            return "";
        }// end function

        public function splitAtPosition(param1:int) : FlowElement
        {
            if (param1 < 0 || param1 > this._textLength)
            {
                throw RangeError(GlobalSettings.resourceStringFunction("invalidSplitAtPosition"));
            }
            return this;
        }// end function

        function get bindableElement() : Boolean
        {
            return this.getPrivateStyle("bindable") == true;
        }// end function

        function set bindableElement(param1:Boolean) : void
        {
            this.setPrivateStyle("bindable", param1);
            return;
        }// end function

        function mergeToPreviousIfPossible() : Boolean
        {
            return false;
        }// end function

        function createContentElement() : void
        {
            return;
        }// end function

        function releaseContentElement() : void
        {
            return;
        }// end function

        public function get parent() : FlowGroupElement
        {
            return this._parent;
        }// end function

        function setParentAndRelativeStart(param1:FlowGroupElement, param2:int) : void
        {
            this._parent = param1;
            this._parentRelativeStart = param2;
            this.attributesChanged(false);
            return;
        }// end function

        function setParentAndRelativeStartOnly(param1:FlowGroupElement, param2:int) : void
        {
            this._parent = param1;
            this._parentRelativeStart = param2;
            return;
        }// end function

        public function get textLength() : int
        {
            return this._textLength;
        }// end function

        function setTextLength(param1:int) : void
        {
            this._textLength = param1;
            return;
        }// end function

        public function get parentRelativeStart() : int
        {
            return this._parentRelativeStart;
        }// end function

        function setParentRelativeStart(param1:int) : void
        {
            this._parentRelativeStart = param1;
            return;
        }// end function

        public function get parentRelativeEnd() : int
        {
            return this._parentRelativeStart + this._textLength;
        }// end function

        function getAncestorWithContainer() : ContainerFormattedElement
        {
            var _loc_2:* = null;
            var _loc_1:* = this;
            while (_loc_1)
            {
                
                _loc_2 = _loc_1 as ContainerFormattedElement;
                if (_loc_2)
                {
                    if (!_loc_2._parent || _loc_2.flowComposer)
                    {
                        return _loc_2;
                    }
                }
                _loc_1 = _loc_1._parent;
            }
            return null;
        }// end function

        function getPrivateStyle(param1:String)
        {
            return this._format ? (this._format.getPrivateData(param1)) : (undefined);
        }// end function

        function setPrivateStyle(param1:String, param2) : void
        {
            if (this.getPrivateStyle(param1) != param2)
            {
                this.writableTextLayoutFormat().setPrivateData(param1, param2);
                this.modelChanged(ModelChange.STYLE_SELECTOR_CHANGED, this, 0, this._textLength);
            }
            return;
        }// end function

        public function get id() : String
        {
            return this.getPrivateStyle(idString);
        }// end function

        public function set id(param1:String) : void
        {
            return this.setPrivateStyle(idString, param1);
        }// end function

        public function get typeName() : String
        {
            var _loc_1:* = this.getPrivateStyle(typeNameString);
            return _loc_1 ? (_loc_1) : (this.defaultTypeName);
        }// end function

        public function set typeName(param1:String) : void
        {
            if (param1 != this.typeName)
            {
                this.setPrivateStyle(typeNameString, param1 == this.defaultTypeName ? (undefined) : (param1));
            }
            return;
        }// end function

        function get defaultTypeName() : String
        {
            return null;
        }// end function

        function get impliedElement() : Boolean
        {
            return this.getPrivateStyle(impliedElementString) !== undefined;
        }// end function

        function set impliedElement(param1) : void
        {
            this.setPrivateStyle(impliedElementString, param1);
            return;
        }// end function

        public function get color()
        {
            return this._format ? (this._format.color) : (undefined);
        }// end function

        public function set color(param1) : void
        {
            this.writableTextLayoutFormat().color = param1;
            this.formatChanged();
            return;
        }// end function

        public function get backgroundColor()
        {
            return this._format ? (this._format.backgroundColor) : (undefined);
        }// end function

        public function set backgroundColor(param1) : void
        {
            this.writableTextLayoutFormat().backgroundColor = param1;
            this.formatChanged();
            return;
        }// end function

        public function get lineThrough()
        {
            return this._format ? (this._format.lineThrough) : (undefined);
        }// end function

        public function set lineThrough(param1) : void
        {
            this.writableTextLayoutFormat().lineThrough = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textAlpha()
        {
            return this._format ? (this._format.textAlpha) : (undefined);
        }// end function

        public function set textAlpha(param1) : void
        {
            this.writableTextLayoutFormat().textAlpha = param1;
            this.formatChanged();
            return;
        }// end function

        public function get backgroundAlpha()
        {
            return this._format ? (this._format.backgroundAlpha) : (undefined);
        }// end function

        public function set backgroundAlpha(param1) : void
        {
            this.writableTextLayoutFormat().backgroundAlpha = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontSize()
        {
            return this._format ? (this._format.fontSize) : (undefined);
        }// end function

        public function set fontSize(param1) : void
        {
            this.writableTextLayoutFormat().fontSize = param1;
            this.formatChanged();
            return;
        }// end function

        public function get baselineShift()
        {
            return this._format ? (this._format.baselineShift) : (undefined);
        }// end function

        public function set baselineShift(param1) : void
        {
            this.writableTextLayoutFormat().baselineShift = param1;
            this.formatChanged();
            return;
        }// end function

        public function get trackingLeft()
        {
            return this._format ? (this._format.trackingLeft) : (undefined);
        }// end function

        public function set trackingLeft(param1) : void
        {
            this.writableTextLayoutFormat().trackingLeft = param1;
            this.formatChanged();
            return;
        }// end function

        public function get trackingRight()
        {
            return this._format ? (this._format.trackingRight) : (undefined);
        }// end function

        public function set trackingRight(param1) : void
        {
            this.writableTextLayoutFormat().trackingRight = param1;
            this.formatChanged();
            return;
        }// end function

        public function get lineHeight()
        {
            return this._format ? (this._format.lineHeight) : (undefined);
        }// end function

        public function set lineHeight(param1) : void
        {
            this.writableTextLayoutFormat().lineHeight = param1;
            this.formatChanged();
            return;
        }// end function

        public function get breakOpportunity()
        {
            return this._format ? (this._format.breakOpportunity) : (undefined);
        }// end function

        public function set breakOpportunity(param1) : void
        {
            this.writableTextLayoutFormat().breakOpportunity = param1;
            this.formatChanged();
            return;
        }// end function

        public function get digitCase()
        {
            return this._format ? (this._format.digitCase) : (undefined);
        }// end function

        public function set digitCase(param1) : void
        {
            this.writableTextLayoutFormat().digitCase = param1;
            this.formatChanged();
            return;
        }// end function

        public function get digitWidth()
        {
            return this._format ? (this._format.digitWidth) : (undefined);
        }// end function

        public function set digitWidth(param1) : void
        {
            this.writableTextLayoutFormat().digitWidth = param1;
            this.formatChanged();
            return;
        }// end function

        public function get dominantBaseline()
        {
            return this._format ? (this._format.dominantBaseline) : (undefined);
        }// end function

        public function set dominantBaseline(param1) : void
        {
            this.writableTextLayoutFormat().dominantBaseline = param1;
            this.formatChanged();
            return;
        }// end function

        public function get kerning()
        {
            return this._format ? (this._format.kerning) : (undefined);
        }// end function

        public function set kerning(param1) : void
        {
            this.writableTextLayoutFormat().kerning = param1;
            this.formatChanged();
            return;
        }// end function

        public function get ligatureLevel()
        {
            return this._format ? (this._format.ligatureLevel) : (undefined);
        }// end function

        public function set ligatureLevel(param1) : void
        {
            this.writableTextLayoutFormat().ligatureLevel = param1;
            this.formatChanged();
            return;
        }// end function

        public function get alignmentBaseline()
        {
            return this._format ? (this._format.alignmentBaseline) : (undefined);
        }// end function

        public function set alignmentBaseline(param1) : void
        {
            this.writableTextLayoutFormat().alignmentBaseline = param1;
            this.formatChanged();
            return;
        }// end function

        public function get locale()
        {
            return this._format ? (this._format.locale) : (undefined);
        }// end function

        public function set locale(param1) : void
        {
            this.writableTextLayoutFormat().locale = param1;
            this.formatChanged();
            return;
        }// end function

        public function get typographicCase()
        {
            return this._format ? (this._format.typographicCase) : (undefined);
        }// end function

        public function set typographicCase(param1) : void
        {
            this.writableTextLayoutFormat().typographicCase = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontFamily()
        {
            return this._format ? (this._format.fontFamily) : (undefined);
        }// end function

        public function set fontFamily(param1) : void
        {
            this.writableTextLayoutFormat().fontFamily = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textDecoration()
        {
            return this._format ? (this._format.textDecoration) : (undefined);
        }// end function

        public function set textDecoration(param1) : void
        {
            this.writableTextLayoutFormat().textDecoration = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontWeight()
        {
            return this._format ? (this._format.fontWeight) : (undefined);
        }// end function

        public function set fontWeight(param1) : void
        {
            this.writableTextLayoutFormat().fontWeight = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontStyle()
        {
            return this._format ? (this._format.fontStyle) : (undefined);
        }// end function

        public function set fontStyle(param1) : void
        {
            this.writableTextLayoutFormat().fontStyle = param1;
            this.formatChanged();
            return;
        }// end function

        public function get whiteSpaceCollapse()
        {
            return this._format ? (this._format.whiteSpaceCollapse) : (undefined);
        }// end function

        public function set whiteSpaceCollapse(param1) : void
        {
            this.writableTextLayoutFormat().whiteSpaceCollapse = param1;
            this.formatChanged();
            return;
        }// end function

        public function get renderingMode()
        {
            return this._format ? (this._format.renderingMode) : (undefined);
        }// end function

        public function set renderingMode(param1) : void
        {
            this.writableTextLayoutFormat().renderingMode = param1;
            this.formatChanged();
            return;
        }// end function

        public function get cffHinting()
        {
            return this._format ? (this._format.cffHinting) : (undefined);
        }// end function

        public function set cffHinting(param1) : void
        {
            this.writableTextLayoutFormat().cffHinting = param1;
            this.formatChanged();
            return;
        }// end function

        public function get fontLookup()
        {
            return this._format ? (this._format.fontLookup) : (undefined);
        }// end function

        public function set fontLookup(param1) : void
        {
            this.writableTextLayoutFormat().fontLookup = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textRotation()
        {
            return this._format ? (this._format.textRotation) : (undefined);
        }// end function

        public function set textRotation(param1) : void
        {
            this.writableTextLayoutFormat().textRotation = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textIndent()
        {
            return this._format ? (this._format.textIndent) : (undefined);
        }// end function

        public function set textIndent(param1) : void
        {
            this.writableTextLayoutFormat().textIndent = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paragraphStartIndent()
        {
            return this._format ? (this._format.paragraphStartIndent) : (undefined);
        }// end function

        public function set paragraphStartIndent(param1) : void
        {
            this.writableTextLayoutFormat().paragraphStartIndent = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paragraphEndIndent()
        {
            return this._format ? (this._format.paragraphEndIndent) : (undefined);
        }// end function

        public function set paragraphEndIndent(param1) : void
        {
            this.writableTextLayoutFormat().paragraphEndIndent = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paragraphSpaceBefore()
        {
            return this._format ? (this._format.paragraphSpaceBefore) : (undefined);
        }// end function

        public function set paragraphSpaceBefore(param1) : void
        {
            this.writableTextLayoutFormat().paragraphSpaceBefore = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paragraphSpaceAfter()
        {
            return this._format ? (this._format.paragraphSpaceAfter) : (undefined);
        }// end function

        public function set paragraphSpaceAfter(param1) : void
        {
            this.writableTextLayoutFormat().paragraphSpaceAfter = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textAlign()
        {
            return this._format ? (this._format.textAlign) : (undefined);
        }// end function

        public function set textAlign(param1) : void
        {
            this.writableTextLayoutFormat().textAlign = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textAlignLast()
        {
            return this._format ? (this._format.textAlignLast) : (undefined);
        }// end function

        public function set textAlignLast(param1) : void
        {
            this.writableTextLayoutFormat().textAlignLast = param1;
            this.formatChanged();
            return;
        }// end function

        public function get textJustify()
        {
            return this._format ? (this._format.textJustify) : (undefined);
        }// end function

        public function set textJustify(param1) : void
        {
            this.writableTextLayoutFormat().textJustify = param1;
            this.formatChanged();
            return;
        }// end function

        public function get justificationRule()
        {
            return this._format ? (this._format.justificationRule) : (undefined);
        }// end function

        public function set justificationRule(param1) : void
        {
            this.writableTextLayoutFormat().justificationRule = param1;
            this.formatChanged();
            return;
        }// end function

        public function get justificationStyle()
        {
            return this._format ? (this._format.justificationStyle) : (undefined);
        }// end function

        public function set justificationStyle(param1) : void
        {
            this.writableTextLayoutFormat().justificationStyle = param1;
            this.formatChanged();
            return;
        }// end function

        public function get direction()
        {
            return this._format ? (this._format.direction) : (undefined);
        }// end function

        public function set direction(param1) : void
        {
            this.writableTextLayoutFormat().direction = param1;
            this.formatChanged();
            return;
        }// end function

        public function get wordSpacing()
        {
            return this._format ? (this._format.wordSpacing) : (undefined);
        }// end function

        public function set wordSpacing(param1) : void
        {
            this.writableTextLayoutFormat().wordSpacing = param1;
            this.formatChanged();
            return;
        }// end function

        public function get tabStops()
        {
            return this._format ? (this._format.tabStops) : (undefined);
        }// end function

        public function set tabStops(param1) : void
        {
            this.writableTextLayoutFormat().tabStops = param1;
            this.formatChanged();
            return;
        }// end function

        public function get leadingModel()
        {
            return this._format ? (this._format.leadingModel) : (undefined);
        }// end function

        public function set leadingModel(param1) : void
        {
            this.writableTextLayoutFormat().leadingModel = param1;
            this.formatChanged();
            return;
        }// end function

        public function get columnGap()
        {
            return this._format ? (this._format.columnGap) : (undefined);
        }// end function

        public function set columnGap(param1) : void
        {
            this.writableTextLayoutFormat().columnGap = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paddingLeft()
        {
            return this._format ? (this._format.paddingLeft) : (undefined);
        }// end function

        public function set paddingLeft(param1) : void
        {
            this.writableTextLayoutFormat().paddingLeft = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paddingTop()
        {
            return this._format ? (this._format.paddingTop) : (undefined);
        }// end function

        public function set paddingTop(param1) : void
        {
            this.writableTextLayoutFormat().paddingTop = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paddingRight()
        {
            return this._format ? (this._format.paddingRight) : (undefined);
        }// end function

        public function set paddingRight(param1) : void
        {
            this.writableTextLayoutFormat().paddingRight = param1;
            this.formatChanged();
            return;
        }// end function

        public function get paddingBottom()
        {
            return this._format ? (this._format.paddingBottom) : (undefined);
        }// end function

        public function set paddingBottom(param1) : void
        {
            this.writableTextLayoutFormat().paddingBottom = param1;
            this.formatChanged();
            return;
        }// end function

        public function get columnCount()
        {
            return this._format ? (this._format.columnCount) : (undefined);
        }// end function

        public function set columnCount(param1) : void
        {
            this.writableTextLayoutFormat().columnCount = param1;
            this.formatChanged();
            return;
        }// end function

        public function get columnWidth()
        {
            return this._format ? (this._format.columnWidth) : (undefined);
        }// end function

        public function set columnWidth(param1) : void
        {
            this.writableTextLayoutFormat().columnWidth = param1;
            this.formatChanged();
            return;
        }// end function

        public function get firstBaselineOffset()
        {
            return this._format ? (this._format.firstBaselineOffset) : (undefined);
        }// end function

        public function set firstBaselineOffset(param1) : void
        {
            this.writableTextLayoutFormat().firstBaselineOffset = param1;
            this.formatChanged();
            return;
        }// end function

        public function get verticalAlign()
        {
            return this._format ? (this._format.verticalAlign) : (undefined);
        }// end function

        public function set verticalAlign(param1) : void
        {
            this.writableTextLayoutFormat().verticalAlign = param1;
            this.formatChanged();
            return;
        }// end function

        public function get blockProgression()
        {
            return this._format ? (this._format.blockProgression) : (undefined);
        }// end function

        public function set blockProgression(param1) : void
        {
            this.writableTextLayoutFormat().blockProgression = param1;
            this.formatChanged();
            return;
        }// end function

        public function get lineBreak()
        {
            return this._format ? (this._format.lineBreak) : (undefined);
        }// end function

        public function set lineBreak(param1) : void
        {
            this.writableTextLayoutFormat().lineBreak = param1;
            this.formatChanged();
            return;
        }// end function

        public function get listStyleType()
        {
            return this._format ? (this._format.listStyleType) : (undefined);
        }// end function

        public function set listStyleType(param1) : void
        {
            this.writableTextLayoutFormat().listStyleType = param1;
            this.formatChanged();
            return;
        }// end function

        public function get listStylePosition()
        {
            return this._format ? (this._format.listStylePosition) : (undefined);
        }// end function

        public function set listStylePosition(param1) : void
        {
            this.writableTextLayoutFormat().listStylePosition = param1;
            this.formatChanged();
            return;
        }// end function

        public function get listAutoPadding()
        {
            return this._format ? (this._format.listAutoPadding) : (undefined);
        }// end function

        public function set listAutoPadding(param1) : void
        {
            this.writableTextLayoutFormat().listAutoPadding = param1;
            this.formatChanged();
            return;
        }// end function

        public function get clearFloats()
        {
            return this._format ? (this._format.clearFloats) : (undefined);
        }// end function

        public function set clearFloats(param1) : void
        {
            this.writableTextLayoutFormat().clearFloats = param1;
            this.formatChanged();
            return;
        }// end function

        public function get styleName()
        {
            return this._format ? (this._format.styleName) : (undefined);
        }// end function

        public function set styleName(param1) : void
        {
            this.writableTextLayoutFormat().styleName = param1;
            this.styleSelectorChanged();
            return;
        }// end function

        public function get linkNormalFormat()
        {
            return this._format ? (this._format.linkNormalFormat) : (undefined);
        }// end function

        public function set linkNormalFormat(param1) : void
        {
            this.writableTextLayoutFormat().linkNormalFormat = param1;
            this.formatChanged();
            return;
        }// end function

        public function get linkActiveFormat()
        {
            return this._format ? (this._format.linkActiveFormat) : (undefined);
        }// end function

        public function set linkActiveFormat(param1) : void
        {
            this.writableTextLayoutFormat().linkActiveFormat = param1;
            this.formatChanged();
            return;
        }// end function

        public function get linkHoverFormat()
        {
            return this._format ? (this._format.linkHoverFormat) : (undefined);
        }// end function

        public function set linkHoverFormat(param1) : void
        {
            this.writableTextLayoutFormat().linkHoverFormat = param1;
            this.formatChanged();
            return;
        }// end function

        public function get listMarkerFormat()
        {
            return this._format ? (this._format.listMarkerFormat) : (undefined);
        }// end function

        public function set listMarkerFormat(param1) : void
        {
            this.writableTextLayoutFormat().listMarkerFormat = param1;
            this.formatChanged();
            return;
        }// end function

        public function get format() : ITextLayoutFormat
        {
            return this._format;
        }// end function

        public function set format(param1:ITextLayoutFormat) : void
        {
            if (param1 == this._format)
            {
                return;
            }
            var _loc_2:* = this.styleName;
            if (param1 == null)
            {
                this._format.clearStyles();
            }
            else
            {
                this.writableTextLayoutFormat().copy(param1);
            }
            this.formatChanged();
            if (_loc_2 != this.styleName)
            {
                this.styleSelectorChanged();
            }
            return;
        }// end function

        function writableTextLayoutFormat() : FlowValueHolder
        {
            if (this._format == null)
            {
                this._format = new FlowValueHolder();
            }
            return this._format;
        }// end function

        function formatChanged(param1:Boolean = true) : void
        {
            if (param1)
            {
                this.modelChanged(ModelChange.TEXTLAYOUT_FORMAT_CHANGED, this, 0, this._textLength);
            }
            this._computedFormat = null;
            return;
        }// end function

        function styleSelectorChanged() : void
        {
            this.modelChanged(ModelChange.STYLE_SELECTOR_CHANGED, this, 0, this._textLength);
            this._computedFormat = null;
            return;
        }// end function

        function get formatForCascade() : ITextLayoutFormat
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_1:* = this.getTextFlow();
            if (_loc_1)
            {
                _loc_2 = _loc_1.getTextLayoutFormatStyle(this);
                if (_loc_2)
                {
                    _loc_3 = this.format;
                    if (_loc_3 == null)
                    {
                        return _loc_2;
                    }
                    _loc_4 = new TextLayoutFormat();
                    _loc_4.apply(_loc_2);
                    _loc_4.apply(_loc_3);
                    return _loc_4;
                }
            }
            return this._format;
        }// end function

        public function get computedFormat() : ITextLayoutFormat
        {
            if (this._computedFormat == null)
            {
                this._computedFormat = this.doComputeTextLayoutFormat();
            }
            return this._computedFormat;
        }// end function

        function doComputeTextLayoutFormat() : TextLayoutFormat
        {
            var _loc_1:* = this._parent ? (TextLayoutFormat(this._parent.computedFormat)) : (null);
            return FlowElement.createTextLayoutFormatPrototype(this.formatForCascade, _loc_1);
        }// end function

        function attributesChanged(param1:Boolean = true) : void
        {
            this.formatChanged(param1);
            return;
        }// end function

        public function getStyle(param1:String)
        {
            if (TextLayoutFormat.description.hasOwnProperty(param1))
            {
                return this.computedFormat.getStyle(param1);
            }
            var _loc_2:* = this.getTextFlow();
            if (!_loc_2 || !_loc_2.formatResolver)
            {
                return this.computedFormat.getStyle(param1);
            }
            return this.getUserStyleWorker(param1);
        }// end function

        function getUserStyleWorker(param1:String)
        {
            var _loc_3:* = undefined;
            if (this._format != null)
            {
                _loc_3 = this._format.getStyle(param1);
                if (_loc_3 !== undefined)
                {
                    return _loc_3;
                }
            }
            var _loc_2:* = this.getTextFlow();
            if (_loc_2 && _loc_2.formatResolver)
            {
                _loc_3 = _loc_2.formatResolver.resolveUserFormat(this, param1);
                if (_loc_3 !== undefined)
                {
                    return _loc_3;
                }
            }
            return this._parent ? (this._parent.getUserStyleWorker(param1)) : (undefined);
        }// end function

        public function setStyle(param1:String, param2) : void
        {
            if (TextLayoutFormat.description[param1])
            {
                this[param1] = param2;
            }
            else
            {
                this.writableTextLayoutFormat().setStyle(param1, param2);
                this.formatChanged();
            }
            return;
        }// end function

        public function clearStyle(param1:String) : void
        {
            this.setStyle(param1, undefined);
            return;
        }// end function

        function modelChanged(param1:String, param2:FlowElement, param3:int, param4:int, param5:Boolean = true, param6:Boolean = true) : void
        {
            var _loc_7:* = this.getTextFlow();
            if (this.getTextFlow())
            {
                _loc_7.processModelChanged(param1, param2, this.getAbsoluteStart() + param3, param4, param5, param6);
            }
            return;
        }// end function

        function appendElementsForDelayedUpdate(param1:TextFlow, param2:String) : void
        {
            return;
        }// end function

        function applyDelayedElementUpdate(param1:TextFlow, param2:Boolean, param3:Boolean) : void
        {
            return;
        }// end function

        function getEffectivePaddingLeft() : Number
        {
            return this.computedFormat.paddingLeft == FormatValue.AUTO ? (0) : (this.computedFormat.paddingLeft);
        }// end function

        function getEffectivePaddingRight() : Number
        {
            return this.computedFormat.paddingRight == FormatValue.AUTO ? (0) : (this.computedFormat.paddingRight);
        }// end function

        function getEffectivePaddingTop() : Number
        {
            return this.computedFormat.paddingTop == FormatValue.AUTO ? (0) : (this.computedFormat.paddingTop);
        }// end function

        function getEffectivePaddingBottom() : Number
        {
            return this.computedFormat.paddingBottom == FormatValue.AUTO ? (0) : (this.computedFormat.paddingBottom);
        }// end function

        public function set tracking(param1:Object) : void
        {
            this.trackingRight = param1;
            return;
        }// end function

        function applyWhiteSpaceCollapse(param1:String) : void
        {
            if (this.whiteSpaceCollapse !== undefined)
            {
                this.whiteSpaceCollapse = undefined;
            }
            this.setPrivateStyle(impliedElementString, undefined);
            return;
        }// end function

        public function getAbsoluteStart() : int
        {
            var _loc_1:* = this._parentRelativeStart;
            var _loc_2:* = this._parent;
            while (_loc_2)
            {
                
                _loc_1 = _loc_1 + _loc_2._parentRelativeStart;
                _loc_2 = _loc_2._parent;
            }
            return _loc_1;
        }// end function

        public function getElementRelativeStart(param1:FlowElement) : int
        {
            var _loc_2:* = this._parentRelativeStart;
            var _loc_3:* = this._parent;
            while (_loc_3 && _loc_3 != param1)
            {
                
                _loc_2 = _loc_2 + _loc_3._parentRelativeStart;
                _loc_3 = _loc_3._parent;
            }
            return _loc_2;
        }// end function

        public function getTextFlow() : TextFlow
        {
            var _loc_1:* = this;
            while (_loc_1._parent != null)
            {
                
                _loc_1 = _loc_1._parent;
            }
            return _loc_1 as TextFlow;
        }// end function

        public function getParagraph() : ParagraphElement
        {
            var _loc_1:* = null;
            var _loc_2:* = this;
            while (_loc_2)
            {
                
                _loc_1 = _loc_2 as ParagraphElement;
                if (_loc_1)
                {
                    break;
                }
                _loc_2 = _loc_2._parent;
            }
            return _loc_1;
        }// end function

        public function getParentByType(param1:Class) : FlowElement
        {
            var _loc_2:* = this._parent;
            while (_loc_2)
            {
                
                if (_loc_2 is param1)
                {
                    return _loc_2;
                }
                _loc_2 = _loc_2._parent;
            }
            return null;
        }// end function

        public function getPreviousSibling() : FlowElement
        {
            if (!this._parent)
            {
                return null;
            }
            var _loc_1:* = this._parent.getChildIndex(this);
            return _loc_1 == 0 ? (null) : (this._parent.getChildAt((_loc_1 - 1)));
        }// end function

        public function getNextSibling() : FlowElement
        {
            if (!this._parent)
            {
                return null;
            }
            var _loc_1:* = this._parent.getChildIndex(this);
            return _loc_1 == (this._parent.numChildren - 1) ? (null) : (this._parent.getChildAt((_loc_1 + 1)));
        }// end function

        public function getCharAtPosition(param1:int) : String
        {
            return null;
        }// end function

        public function getCharCodeAtPosition(param1:int) : int
        {
            var _loc_2:* = this.getCharAtPosition(param1);
            return _loc_2 && _loc_2.length > 0 ? (_loc_2.charCodeAt(0)) : (0);
        }// end function

        function applyFunctionToElements(param1:Function) : Boolean
        {
            return this.param1(this);
        }// end function

        function getEventMirror() : IEventDispatcher
        {
            return null;
        }// end function

        function hasActiveEventMirror() : Boolean
        {
            return false;
        }// end function

        private function updateRange(param1:int) : void
        {
            this.setParentRelativeStart(this._parentRelativeStart + param1);
            return;
        }// end function

        function updateLengths(param1:int, param2:int, param3:Boolean) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            this.setTextLength(this._textLength + param2);
            var _loc_4:* = this._parent;
            if (this._parent)
            {
                _loc_5 = _loc_4.getChildIndex(this) + 1;
                _loc_6 = _loc_4.numChildren;
                while (_loc_5 < _loc_6)
                {
                    
                    _loc_7 = _loc_4.getChildAt(_loc_5++);
                    _loc_7.updateRange(param2);
                }
                _loc_4.updateLengths(param1, param2, param3);
            }
            return;
        }// end function

        function getEnclosingController(param1:int) : ContainerController
        {
            var _loc_2:* = this.getTextFlow();
            if (_loc_2 == null || _loc_2.flowComposer == null)
            {
                return null;
            }
            var _loc_3:* = this;
            while (_loc_3 && (!(_loc_3 is ContainerFormattedElement) || ContainerFormattedElement(_loc_3).flowComposer == null))
            {
                
                _loc_3 = _loc_3._parent;
            }
            var _loc_4:* = ContainerFormattedElement(_loc_3).flowComposer;
            if (!ContainerFormattedElement(_loc_3).flowComposer)
            {
                return null;
            }
            var _loc_5:* = ContainerFormattedElement(_loc_3).flowComposer.findControllerIndexAtPosition(this.getAbsoluteStart() + param1, false);
            return ContainerFormattedElement(_loc_3).flowComposer.findControllerIndexAtPosition(this.getAbsoluteStart() + param1, false) != -1 ? (_loc_4.getControllerAt(_loc_5)) : (null);
        }// end function

        function deleteContainerText(param1:int, param2:int) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            var _loc_11:* = null;
            if (this.getTextFlow())
            {
                _loc_3 = this.getAbsoluteStart() + param1;
                _loc_4 = _loc_3 - param2;
                while (param2 > 0)
                {
                    
                    _loc_6 = this.getEnclosingController((param1 - 1));
                    if (!_loc_6)
                    {
                        _loc_6 = this.getEnclosingController(param1 - param2);
                        if (_loc_6)
                        {
                            _loc_9 = _loc_6.flowComposer;
                            _loc_10 = _loc_9.getControllerIndex(_loc_6);
                            _loc_11 = _loc_6;
                            while ((_loc_10 + 1) < _loc_9.numControllers && _loc_6.absoluteStart + _loc_6.textLength < param1)
                            {
                                
                                _loc_6 = _loc_9.getControllerAt((_loc_10 + 1));
                                if (_loc_6.textLength)
                                {
                                    _loc_11 = _loc_6;
                                    break;
                                }
                                _loc_10++;
                            }
                        }
                        if (!_loc_6 || !_loc_6.textLength)
                        {
                            _loc_6 = _loc_11;
                        }
                        if (!_loc_6)
                        {
                            break;
                        }
                    }
                    _loc_7 = _loc_6.absoluteStart;
                    if (_loc_4 < _loc_7)
                    {
                        _loc_5 = _loc_3 - _loc_7 + 1;
                    }
                    else if (_loc_4 < _loc_7 + _loc_6.textLength)
                    {
                        _loc_5 = param2;
                    }
                    _loc_8 = _loc_6.textLength < _loc_5 ? (_loc_6.textLength) : (_loc_5);
                    if (_loc_8 <= 0)
                    {
                        break;
                    }
                    ContainerController(_loc_6).setTextLengthOnly(_loc_6.textLength - _loc_8);
                    param2 = param2 - _loc_8;
                    _loc_3 = _loc_3 - _loc_8;
                    param1 = param1 - _loc_8;
                }
            }
            return;
        }// end function

        function normalizeRange(param1:uint, param2:uint) : void
        {
            return;
        }// end function

        function quickCloneTextLayoutFormat(param1:FlowElement) : void
        {
            this._format = param1._format ? (new FlowValueHolder(param1._format)) : (null);
            this._computedFormat = null;
            return;
        }// end function

        function updateForMustUseComposer(param1:TextFlow) : Boolean
        {
            return false;
        }// end function

        static function createTextLayoutFormatPrototype(param1:ITextLayoutFormat, param2:TextLayoutFormat) : TextLayoutFormat
        {
            var _loc_5:* = null;
            var _loc_7:* = null;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_3:* = true;
            var _loc_4:* = false;
            if (param2)
            {
                _loc_5 = param2.getStyles();
                if (_loc_5.hasNonInheritedStyles !== undefined)
                {
                    if (_loc_5.hasNonInheritedStyles === true)
                    {
                        _loc_12 = Property.createObjectWithPrototype(_loc_5);
                        TextLayoutFormat.resetModifiedNoninheritedStyles(_loc_12);
                        _loc_5.hasNonInheritedStyles = _loc_12;
                        _loc_5 = _loc_12;
                    }
                    else
                    {
                        _loc_5 = _loc_5.hasNonInheritedStyles;
                    }
                    _loc_3 = false;
                }
            }
            else
            {
                param2 = TextLayoutFormat.defaultFormat as TextLayoutFormat;
                _loc_5 = param2.getStyles();
            }
            var _loc_6:* = Property.createObjectWithPrototype(_loc_5);
            var _loc_10:* = false;
            if (param1 != null)
            {
                _loc_13 = param1 as TextLayoutFormat;
                if (_loc_13)
                {
                    _loc_14 = _loc_13.getStyles();
                    for (_loc_7 in _loc_14)
                    {
                        
                        _loc_8 = _loc_14[_loc_7];
                        if (_loc_8 == FormatValue.INHERIT)
                        {
                            if (param2)
                            {
                                _loc_9 = TextLayoutFormat.description[_loc_7];
                                if (_loc_9 && !_loc_9.inherited)
                                {
                                    _loc_8 = param2[_loc_7];
                                    if (_loc_6[_loc_7] != _loc_8)
                                    {
                                        _loc_6[_loc_7] = _loc_8;
                                        _loc_10 = true;
                                        _loc_4 = true;
                                    }
                                }
                            }
                            continue;
                        }
                        if (_loc_6[_loc_7] != _loc_8)
                        {
                            _loc_9 = TextLayoutFormat.description[_loc_7];
                            if (_loc_9 && !_loc_9.inherited)
                            {
                                _loc_10 = true;
                            }
                            _loc_6[_loc_7] = _loc_8;
                            _loc_4 = true;
                        }
                    }
                }
                else
                {
                    for each (_loc_9 in TextLayoutFormat.description)
                    {
                        
                        _loc_7 = _loc_9.name;
                        _loc_8 = param1[_loc_7];
                        if (_loc_8 !== undefined)
                        {
                            if (_loc_8 == FormatValue.INHERIT)
                            {
                                if (param2)
                                {
                                    if (!_loc_9.inherited)
                                    {
                                        _loc_8 = param2[_loc_7];
                                        if (_loc_6[_loc_7] != _loc_8)
                                        {
                                            _loc_6[_loc_7] = _loc_8;
                                            _loc_10 = true;
                                            _loc_4 = true;
                                        }
                                    }
                                }
                                continue;
                            }
                            if (_loc_6[_loc_7] != _loc_8)
                            {
                                if (!_loc_9.inherited)
                                {
                                    _loc_10 = true;
                                }
                                _loc_6[_loc_7] = _loc_8;
                                _loc_4 = true;
                            }
                        }
                    }
                }
            }
            if (!_loc_4)
            {
                if (_loc_3)
                {
                    return param2;
                }
                _loc_11 = new TextLayoutFormat();
                _loc_11.setStyles(_loc_6, true);
                return _loc_11;
            }
            if (_loc_10)
            {
                _loc_6.hasNonInheritedStyles = true;
                _loc_6.setPropertyIsEnumerable("hasNonInheritedStyles", false);
            }
            else if (_loc_6.hasNonInheritedStyles !== undefined)
            {
                _loc_6.hasNonInheritedStyles = undefined;
                _loc_6.setPropertyIsEnumerable("hasNonInheritedStyles", false);
            }
            _loc_11 = new TextLayoutFormat();
            _loc_11.setStyles(_loc_6, false);
            return _loc_11;
        }// end function

    }
}
