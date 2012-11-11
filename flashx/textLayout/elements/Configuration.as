package flashx.textLayout.elements
{
    import flash.display.*;
    import flash.system.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.formats.*;

    public class Configuration extends Object implements IConfiguration
    {
        private var _manageTabKey:Boolean;
        private var _manageEnterKey:Boolean;
        private var _overflowPolicy:String;
        private var _enableAccessibility:Boolean;
        private var _releaseLineCreationData:Boolean;
        private var _defaultLinkNormalFormat:ITextLayoutFormat;
        private var _defaultLinkActiveFormat:ITextLayoutFormat;
        private var _defaultLinkHoverFormat:ITextLayoutFormat;
        private var _defaultListMarkerFormat:IListMarkerFormat;
        private var _textFlowInitialFormat:ITextLayoutFormat;
        private var _focusedSelectionFormat:SelectionFormat;
        private var _unfocusedSelectionFormat:SelectionFormat;
        private var _inactiveSelectionFormat:SelectionFormat;
        private var _scrollDragDelay:Number;
        private var _scrollDragPixels:Number;
        private var _scrollPagePercentage:Number;
        private var _scrollMouseWheelMultiplier:Number;
        private var _flowComposerClass:Class;
        private var _inlineGraphicResolverFunction:Function;
        private var _cursorFunction:Function;
        private var _immutableClone:IConfiguration;
        static const playerEnablesArgoFeatures:Boolean = versionIsAtLeast(10, 1);
        static const playerEnablesSpicyFeatures:Boolean = versionIsAtLeast(10, 2) && new Sprite().hasOwnProperty("needsSoftKeyboard");
        static const hasTouchScreen:Boolean = playerEnablesArgoFeatures && Capabilities["touchScreenType"] != "none";

        public function Configuration(param1:Boolean = true)
        {
            if (param1)
            {
                this.initialize();
            }
            return;
        }// end function

        private function initialize() : void
        {
            var _loc_1:* = null;
            this._manageTabKey = false;
            this._manageEnterKey = true;
            this._overflowPolicy = OverflowPolicy.FIT_DESCENDERS;
            this._enableAccessibility = false;
            this._releaseLineCreationData = false;
            this._focusedSelectionFormat = new SelectionFormat(16777215, 1, BlendMode.DIFFERENCE);
            this._unfocusedSelectionFormat = new SelectionFormat(16777215, 0, BlendMode.DIFFERENCE, 16777215, 0, BlendMode.DIFFERENCE, 0);
            this._inactiveSelectionFormat = this._unfocusedSelectionFormat;
            _loc_1 = new TextLayoutFormat();
            _loc_1.textDecoration = TextDecoration.UNDERLINE;
            _loc_1.color = 255;
            this._defaultLinkNormalFormat = _loc_1;
            var _loc_2:* = new ListMarkerFormat();
            _loc_2.paragraphEndIndent = 4;
            this._defaultListMarkerFormat = _loc_2;
            _loc_1 = new TextLayoutFormat();
            _loc_1.lineBreak = FormatValue.INHERIT;
            _loc_1.paddingLeft = FormatValue.INHERIT;
            _loc_1.paddingRight = FormatValue.INHERIT;
            _loc_1.paddingTop = FormatValue.INHERIT;
            _loc_1.paddingBottom = FormatValue.INHERIT;
            _loc_1.verticalAlign = FormatValue.INHERIT;
            _loc_1.columnCount = FormatValue.INHERIT;
            _loc_1.columnCount = FormatValue.INHERIT;
            _loc_1.columnGap = FormatValue.INHERIT;
            _loc_1.columnWidth = FormatValue.INHERIT;
            this._textFlowInitialFormat = _loc_1;
            this._scrollDragDelay = 35;
            this._scrollDragPixels = 20;
            this._scrollPagePercentage = 7 / 8;
            this._scrollMouseWheelMultiplier = 20;
            this._flowComposerClass = StandardFlowComposer;
            return;
        }// end function

        function getImmutableClone() : IConfiguration
        {
            var _loc_1:* = null;
            if (!this._immutableClone)
            {
                _loc_1 = this.clone();
                this._immutableClone = _loc_1;
                _loc_1._immutableClone = _loc_1;
            }
            return this._immutableClone;
        }// end function

        public function clone() : Configuration
        {
            var _loc_1:* = new Configuration(false);
            _loc_1.defaultLinkActiveFormat = this.defaultLinkActiveFormat;
            _loc_1.defaultLinkHoverFormat = this.defaultLinkHoverFormat;
            _loc_1.defaultLinkNormalFormat = this.defaultLinkNormalFormat;
            _loc_1.defaultListMarkerFormat = this.defaultListMarkerFormat;
            _loc_1.textFlowInitialFormat = this._textFlowInitialFormat;
            _loc_1.focusedSelectionFormat = this._focusedSelectionFormat;
            _loc_1.unfocusedSelectionFormat = this._unfocusedSelectionFormat;
            _loc_1.inactiveSelectionFormat = this._inactiveSelectionFormat;
            _loc_1.manageTabKey = this._manageTabKey;
            _loc_1.manageEnterKey = this._manageEnterKey;
            _loc_1.overflowPolicy = this._overflowPolicy;
            _loc_1.enableAccessibility = this._enableAccessibility;
            _loc_1.releaseLineCreationData = this._releaseLineCreationData;
            _loc_1.scrollDragDelay = this._scrollDragDelay;
            _loc_1.scrollDragPixels = this._scrollDragPixels;
            _loc_1.scrollPagePercentage = this._scrollPagePercentage;
            _loc_1.scrollMouseWheelMultiplier = this._scrollMouseWheelMultiplier;
            _loc_1.flowComposerClass = this._flowComposerClass;
            _loc_1._inlineGraphicResolverFunction = this._inlineGraphicResolverFunction;
            _loc_1._cursorFunction = this._cursorFunction;
            return _loc_1;
        }// end function

        public function get manageTabKey() : Boolean
        {
            return this._manageTabKey;
        }// end function

        public function set manageTabKey(param1:Boolean) : void
        {
            this._manageTabKey = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get manageEnterKey() : Boolean
        {
            return this._manageEnterKey;
        }// end function

        public function set manageEnterKey(param1:Boolean) : void
        {
            this._manageEnterKey = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get overflowPolicy() : String
        {
            return this._overflowPolicy;
        }// end function

        public function set overflowPolicy(param1:String) : void
        {
            this._overflowPolicy = param1;
            return;
        }// end function

        public function get defaultLinkNormalFormat() : ITextLayoutFormat
        {
            return this._defaultLinkNormalFormat;
        }// end function

        public function set defaultLinkNormalFormat(param1:ITextLayoutFormat) : void
        {
            this._defaultLinkNormalFormat = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get defaultListMarkerFormat() : IListMarkerFormat
        {
            return this._defaultListMarkerFormat;
        }// end function

        public function set defaultListMarkerFormat(param1:IListMarkerFormat) : void
        {
            this._defaultListMarkerFormat = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get defaultLinkHoverFormat() : ITextLayoutFormat
        {
            return this._defaultLinkHoverFormat;
        }// end function

        public function set defaultLinkHoverFormat(param1:ITextLayoutFormat) : void
        {
            this._defaultLinkHoverFormat = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get defaultLinkActiveFormat() : ITextLayoutFormat
        {
            return this._defaultLinkActiveFormat;
        }// end function

        public function set defaultLinkActiveFormat(param1:ITextLayoutFormat) : void
        {
            this._defaultLinkActiveFormat = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get textFlowInitialFormat() : ITextLayoutFormat
        {
            return this._textFlowInitialFormat;
        }// end function

        public function set textFlowInitialFormat(param1:ITextLayoutFormat) : void
        {
            this._textFlowInitialFormat = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get focusedSelectionFormat() : SelectionFormat
        {
            return this._focusedSelectionFormat;
        }// end function

        public function set focusedSelectionFormat(param1:SelectionFormat) : void
        {
            if (param1 != null)
            {
                this._focusedSelectionFormat = param1;
                this._immutableClone = null;
            }
            return;
        }// end function

        public function get unfocusedSelectionFormat() : SelectionFormat
        {
            return this._unfocusedSelectionFormat;
        }// end function

        public function set unfocusedSelectionFormat(param1:SelectionFormat) : void
        {
            if (param1 != null)
            {
                this._unfocusedSelectionFormat = param1;
                this._immutableClone = null;
            }
            return;
        }// end function

        public function get inactiveSelectionFormat() : SelectionFormat
        {
            return this._inactiveSelectionFormat;
        }// end function

        public function set inactiveSelectionFormat(param1:SelectionFormat) : void
        {
            if (param1 != null)
            {
                this._inactiveSelectionFormat = param1;
                this._immutableClone = null;
            }
            return;
        }// end function

        public function get scrollDragDelay() : Number
        {
            return this._scrollDragDelay;
        }// end function

        public function set scrollDragDelay(param1:Number) : void
        {
            if (param1 > 0)
            {
                this._scrollDragDelay = param1;
                this._immutableClone = null;
            }
            return;
        }// end function

        public function get scrollDragPixels() : Number
        {
            return this._scrollDragPixels;
        }// end function

        public function set scrollDragPixels(param1:Number) : void
        {
            if (param1 > 0)
            {
                this._scrollDragPixels = param1;
                this._immutableClone = null;
            }
            return;
        }// end function

        public function get scrollPagePercentage() : Number
        {
            return this._scrollPagePercentage;
        }// end function

        public function set scrollPagePercentage(param1:Number) : void
        {
            if (param1 > 0)
            {
                this._scrollPagePercentage = param1;
                this._immutableClone = null;
            }
            return;
        }// end function

        public function get scrollMouseWheelMultiplier() : Number
        {
            return this._scrollMouseWheelMultiplier;
        }// end function

        public function set scrollMouseWheelMultiplier(param1:Number) : void
        {
            if (param1 > 0)
            {
                this._scrollMouseWheelMultiplier = param1;
                this._immutableClone = null;
            }
            return;
        }// end function

        public function get flowComposerClass() : Class
        {
            return this._flowComposerClass;
        }// end function

        public function set flowComposerClass(param1:Class) : void
        {
            this._flowComposerClass = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get enableAccessibility() : Boolean
        {
            return this._enableAccessibility;
        }// end function

        public function set enableAccessibility(param1:Boolean) : void
        {
            this._enableAccessibility = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get releaseLineCreationData() : Boolean
        {
            return this._releaseLineCreationData;
        }// end function

        public function set releaseLineCreationData(param1:Boolean) : void
        {
            this._releaseLineCreationData = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get inlineGraphicResolverFunction() : Function
        {
            return this._inlineGraphicResolverFunction;
        }// end function

        public function set inlineGraphicResolverFunction(param1:Function) : void
        {
            this._inlineGraphicResolverFunction = param1;
            this._immutableClone = null;
            return;
        }// end function

        public function get cursorFunction() : Function
        {
            return this._cursorFunction;
        }// end function

        public function set cursorFunction(param1:Function) : void
        {
            this._cursorFunction = param1;
            this._immutableClone = null;
            return;
        }// end function

        static function versionIsAtLeast(param1:int, param2:int) : Boolean
        {
            var _loc_3:* = Capabilities.version.split(" ")[1].split(",");
            return int(_loc_3[0]) > param1 || int(_loc_3[0]) == param1 && int(_loc_3[1]) >= param2;
        }// end function

        static function get debugCodeEnabled() : Boolean
        {
            return false;
        }// end function

        static function getCursorString(param1:IConfiguration, param2:String) : String
        {
            return param1.cursorFunction == null ? (param2) : (param1.cursorFunction(param2));
        }// end function

    }
}
