package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.managers.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.geom.*;
    import flash.text.*;
    import flash.utils.*;

    public class Label extends GraphicContainer implements UIComponent, IRectangle, FinalizableUIComponent
    {
        private var _finalized:Boolean;
        protected var _tText:TextField;
        private var _cssApplied:Boolean = false;
        protected var _sText:String = "";
        protected var _sType:String = "default";
        private var _binded:Boolean = false;
        private var _needToFinalize:Boolean = false;
        private var _lastWidth:Number = -1;
        protected var _sCssUrl:Uri;
        protected var _nWidth:uint = 100;
        protected var _nHeight:uint = 20;
        protected var _bHtmlAllowed:Boolean = true;
        protected var _sAntialiasType:String = "normal";
        protected var _bFixedWidth:Boolean = true;
        protected var _hyperlinkEnabled:Boolean = false;
        protected var _bFixedHeight:Boolean = true;
        protected var aStyleObj:Array;
        protected var _ssSheet:ExtendedStyleSheet;
        protected var _tfFormatter:TextFormat;
        protected var _useEmbedFonts:Boolean = true;
        protected var _nPaddingLeft:int = 0;
        protected var _nTextIndent:int = 0;
        protected var _bDisabled:Boolean;
        protected var _nTextHeight:int;
        protected var _sVerticalAlign:String = "none";
        protected var _useExtendWidth:Boolean = false;
        protected var _autoResize:Boolean = true;
        protected var _useStyleSheet:Boolean = false;
        protected var _currentStyleSheet:StyleSheet;
        protected var _useCustomFormat:Boolean = false;
        protected var _neverIndent:Boolean = false;
        private var _useTooltipExtension:Boolean = true;
        private var _textFieldTooltipExtension:TextField;
        private var _textTooltipExtensionColor:uint;
        protected var _sCssClass:String;
        public static var HEIGHT_OFFSET:int = 0;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);
        static const _log:Logger = Log.getLogger(getQualifiedClassName(Label));
        private static const VALIGN_NONE:String = "NONE";
        private static const VALIGN_TOP:String = "TOP";
        private static const VALIGN_CENTER:String = "CENTER";
        private static const VALIGN_BOTTOM:String = "BOTTOM";

        public function Label()
        {
            this._aStyleObj = new Array();
            this.createTextField();
            this._tText.type = TextFieldType.DYNAMIC;
            this._tText.selectable = false;
            this._tText.mouseEnabled = false;
            MEMORY_LOG[this] = 1;
            return;
        }// end function

        public function get text() : String
        {
            return this._tText.text;
        }// end function

        public function set text(param1:String) : void
        {
            if (param1 == null)
            {
                param1 = "";
            }
            this._sText = param1;
            if (this._bHtmlAllowed)
            {
                if (this._useStyleSheet)
                {
                    this._tText.styleSheet = null;
                }
                this._tText.htmlText = param1;
                if (!this._useCustomFormat)
                {
                    if (this._sCssUrl != null && !this._cssApplied)
                    {
                        this.applyCSS(this._sCssUrl);
                        this._cssApplied = true;
                    }
                    else
                    {
                        this.updateCss();
                        if (_bgColor != -1)
                        {
                            this.bgColor = _bgColor;
                        }
                    }
                }
            }
            else
            {
                this._tText.text = param1;
            }
            if (!this._useCustomFormat)
            {
                if (!this._sCssClass)
                {
                    this.cssClass = "p";
                }
            }
            if (this._hyperlinkEnabled)
            {
                HyperlinkFactory.createHyperlink(this._tText, this._useStyleSheet);
            }
            if (this._currentStyleSheet)
            {
                this._tText.styleSheet = this._currentStyleSheet;
                this._tText.htmlText = param1;
            }
            if (this._finalized && this._autoResize)
            {
                this.resizeText();
            }
            return;
        }// end function

        public function get hyperlinkEnabled() : Boolean
        {
            return this._hyperlinkEnabled;
        }// end function

        public function set hyperlinkEnabled(param1:Boolean) : void
        {
            this._hyperlinkEnabled = param1;
            mouseEnabled = param1;
            mouseChildren = param1;
            this._tText.mouseEnabled = param1;
            return;
        }// end function

        public function get useStyleSheet() : Boolean
        {
            return this._useStyleSheet;
        }// end function

        public function set useStyleSheet(param1:Boolean) : void
        {
            this._useStyleSheet = param1;
            return;
        }// end function

        public function get useCustomFormat() : Boolean
        {
            return this._useCustomFormat;
        }// end function

        public function set useCustomFormat(param1:Boolean) : void
        {
            this._useCustomFormat = param1;
            return;
        }// end function

        public function get neverIndent() : Boolean
        {
            return this._neverIndent;
        }// end function

        public function set neverIndent(param1:Boolean) : void
        {
            this._neverIndent = param1;
            return;
        }// end function

        public function get autoResize() : Boolean
        {
            return this._autoResize;
        }// end function

        public function set autoResize(param1:Boolean) : void
        {
            this._autoResize = param1;
            return;
        }// end function

        public function get caretIndex() : int
        {
            return this._tText.caretIndex;
        }// end function

        public function set caretIndex(param1:int) : void
        {
            var _loc_2:* = 0;
            if (param1 == -1)
            {
                _loc_2 = this._tText.text.length;
                this._tText.setSelection(_loc_2, _loc_2);
            }
            else
            {
                this._tText.setSelection(param1, param1);
            }
            return;
        }// end function

        public function selectAll() : void
        {
            this._tText.setSelection(0, this._tText.length);
            return;
        }// end function

        public function get type() : String
        {
            return this._sType;
        }// end function

        public function set type(param1:String) : void
        {
            this._sType = param1;
            return;
        }// end function

        public function get css() : Uri
        {
            return this._sCssUrl;
        }// end function

        public function set css(param1:Uri) : void
        {
            this._cssApplied = false;
            this.applyCSS(param1);
            return;
        }// end function

        public function set cssClass(param1:String) : void
        {
            this._sCssClass = param1 == "" ? ("p") : (param1);
            this.bindCss();
            return;
        }// end function

        public function get cssClass() : String
        {
            return this._sCssClass;
        }// end function

        public function get antialias() : String
        {
            return this._sAntialiasType;
        }// end function

        public function set antialias(param1:String) : void
        {
            this._sAntialiasType = param1;
            this._tText.antiAliasType = this._sAntialiasType;
            return;
        }// end function

        public function get thickness() : int
        {
            return this._tText.thickness;
        }// end function

        public function set thickness(param1:int) : void
        {
            this._tText.thickness = param1;
            return;
        }// end function

        public function set _aStyleObj(param1:Object) : void
        {
            this.aStyleObj = param1 as Array;
            return;
        }// end function

        public function get _aStyleObj() : Object
        {
            return this.aStyleObj;
        }// end function

        override public function get width() : Number
        {
            return this._useExtendWidth && this._tText.numLines < 2 ? (this._tText.textWidth + 7) : (this._nWidth);
        }// end function

        override public function set width(param1:Number) : void
        {
            this._nWidth = param1;
            this._tText.width = this._nWidth;
            if (_bgColor != -1)
            {
                this.bgColor = _bgColor;
            }
            if (!this._bFixedHeight)
            {
                this.bindCss();
            }
            return;
        }// end function

        override public function get height() : Number
        {
            return this._nHeight;
        }// end function

        override public function set height(param1:Number) : void
        {
            var _loc_2:* = NaN;
            if (!this._tText.multiline)
            {
                _loc_2 = this._tText.textHeight;
                if (param1 < _loc_2)
                {
                    param1 = _loc_2;
                }
            }
            this._nHeight = param1;
            this._tText.height = this._nHeight;
            __height = this._nHeight;
            if (_bgColor != -1)
            {
                this.bgColor = _bgColor;
            }
            this.updateAlign();
            return;
        }// end function

        public function get textWidth() : Number
        {
            return this._tText.textWidth;
        }// end function

        public function get textHeight() : Number
        {
            return this._tText.textHeight;
        }// end function

        public function get finalized() : Boolean
        {
            return this._finalized;
        }// end function

        public function set finalized(param1:Boolean) : void
        {
            this._finalized = param1;
            return;
        }// end function

        public function get html() : Boolean
        {
            return this._bHtmlAllowed;
        }// end function

        public function set html(param1:Boolean) : void
        {
            this._bHtmlAllowed = param1;
            return;
        }// end function

        public function set wordWrap(param1:Boolean) : void
        {
            this._tText.wordWrap = param1;
            return;
        }// end function

        public function get wordWrap() : Boolean
        {
            return this._tText.wordWrap;
        }// end function

        public function set multiline(param1:Boolean) : void
        {
            this._tText.multiline = param1;
            return;
        }// end function

        public function get multiline() : Boolean
        {
            return this._tText.multiline;
        }// end function

        public function get border() : Boolean
        {
            return this._tText.border;
        }// end function

        public function set border(param1:Boolean) : void
        {
            this._tText.border = param1;
            return;
        }// end function

        public function get fixedWidth() : Boolean
        {
            return this._bFixedWidth;
        }// end function

        public function set fixedWidth(param1:Boolean) : void
        {
            this._bFixedWidth = param1;
            if (this._bFixedWidth)
            {
                this._tText.autoSize = TextFieldAutoSize.NONE;
            }
            else
            {
                this._tText.autoSize = TextFieldAutoSize.LEFT;
            }
            return;
        }// end function

        public function get useExtendWidth() : Boolean
        {
            return this._useExtendWidth;
        }// end function

        public function set useExtendWidth(param1:Boolean) : void
        {
            this._useExtendWidth = param1;
            return;
        }// end function

        public function get fixedHeight() : Boolean
        {
            return this._bFixedHeight;
        }// end function

        public function set fixedHeight(param1:Boolean) : void
        {
            this._bFixedHeight = param1;
            this._tText.wordWrap = !this._bFixedHeight;
            return;
        }// end function

        override public function set bgColor(param1:int) : void
        {
            _bgColor = param1;
            graphics.clear();
            if (bgColor == -1 || !this.width || !this.height)
            {
                return;
            }
            if (_borderColor != -1)
            {
                graphics.lineStyle(1, _borderColor);
            }
            graphics.beginFill(param1, _bgAlpha);
            if (!_bgCornerRadius)
            {
                graphics.drawRect(x, y, this.width, this.height + 2);
            }
            else
            {
                graphics.drawRoundRect(this._tText.x, this._tText.y, this._tText.width, this._tText.height + 2, _bgCornerRadius, _bgCornerRadius);
            }
            graphics.endFill();
            return;
        }// end function

        override public function set borderColor(param1:int) : void
        {
            if (param1 == -1)
            {
                this._tText.border = false;
            }
            else
            {
                this._tText.border = true;
                this._tText.borderColor = param1;
            }
            return;
        }// end function

        public function set selectable(param1:Boolean) : void
        {
            this._tText.selectable = param1;
            return;
        }// end function

        public function get length() : uint
        {
            return this._tText.length;
        }// end function

        public function set scrollV(param1:int) : void
        {
            this._tText.scrollV = param1;
            return;
        }// end function

        public function get scrollV() : int
        {
            this._tText.getCharBoundaries(0);
            return this._tText.scrollV;
        }// end function

        public function get maxScrollV() : int
        {
            this._tText.getCharBoundaries(0);
            return this._tText.maxScrollV;
        }// end function

        public function get textfield() : TextField
        {
            return this._tText;
        }// end function

        public function get useEmbedFonts() : Boolean
        {
            return this._useEmbedFonts;
        }// end function

        public function set useEmbedFonts(param1:Boolean) : void
        {
            this._useEmbedFonts = param1;
            this._tText.embedFonts = param1;
            return;
        }// end function

        override public function set disabled(param1:Boolean) : void
        {
            if (param1)
            {
                HandCursor = false;
                mouseEnabled = false;
                this._tText.mouseEnabled = false;
            }
            else
            {
                HandCursor = true;
                mouseEnabled = true;
                this._tText.mouseEnabled = true;
            }
            this._bDisabled = param1;
            return;
        }// end function

        public function get verticalAlign() : String
        {
            return this._sVerticalAlign;
        }// end function

        public function set verticalAlign(param1:String) : void
        {
            this._sVerticalAlign = param1;
            this.updateAlign();
            return;
        }// end function

        public function get textFormat() : TextFormat
        {
            return this._tfFormatter;
        }// end function

        public function set textFormat(param1:TextFormat) : void
        {
            this._tfFormatter = param1;
            this._tText.setTextFormat(this._tfFormatter);
            return;
        }// end function

        public function set restrict(param1:String) : void
        {
            this._tText.restrict = param1;
            return;
        }// end function

        public function get restrict() : String
        {
            return this._tText.restrict;
        }// end function

        public function set colorText(param1:uint) : void
        {
            if (!this._tfFormatter)
            {
                _log.error("Error. Try to change the size before formatter was initialized.");
                return;
            }
            this._tfFormatter.color = param1;
            this._tText.setTextFormat(this._tfFormatter);
            this._tText.defaultTextFormat = this._tfFormatter;
            return;
        }// end function

        public function setCssColor(param1:String, param2:String = null) : void
        {
            this.changeCssClassColor(param1, param2);
            return;
        }// end function

        public function setCssSize(param1:uint, param2:String = null) : void
        {
            this.changeCssClassSize(param1, param2);
            return;
        }// end function

        public function setStyleSheet(param1:StyleSheet) : void
        {
            this._useStyleSheet = true;
            this._currentStyleSheet = param1;
            return;
        }// end function

        public function applyCSS(param1:Uri) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (param1 == this._sCssUrl && this._tfFormatter)
            {
                this.updateCss();
            }
            else
            {
                this._sCssUrl = param1;
                CssManager.getInstance().askCss(param1.uri, new Callback(this.bindCss));
            }
            return;
        }// end function

        public function setBorderColor(param1:int) : void
        {
            this._tText.borderColor = param1;
            return;
        }// end function

        public function allowTextMouse(param1:Boolean) : void
        {
            this.mouseChildren = param1;
            this._tText.mouseEnabled = param1;
            return;
        }// end function

        override public function remove() : void
        {
            super.remove();
            if (this._tText && this._tText.parent)
            {
                removeChild(this._tText);
            }
            TooltipManager.hide("TextExtension");
            return;
        }// end function

        override public function free() : void
        {
            super.free();
            this._sType = "default";
            this._nWidth = 100;
            this._nHeight = 20;
            this._bHtmlAllowed = true;
            this._sAntialiasType = "normal";
            this._bFixedWidth = true;
            this._bFixedHeight = true;
            this._ssSheet = null;
            this._useEmbedFonts = true;
            this._nPaddingLeft = 0;
            this._nTextIndent = 0;
            this._bDisabled = false;
            this._nTextHeight = 0;
            this._sVerticalAlign = "none";
            this._useExtendWidth = false;
            this._sCssClass = null;
            this._tText.type = TextFieldType.DYNAMIC;
            this._tText.selectable = false;
            return;
        }// end function

        private function createTextField() : void
        {
            this._tText = new TextField();
            this._tText.addEventListener(TextEvent.LINK, this.onTextClick);
            addChild(this._tText);
            return;
        }// end function

        private function changeCssClassColor(param1:String, param2:String = null) : void
        {
            var _loc_3:* = undefined;
            if (param2)
            {
                this._aStyleObj[param2].color = param1;
                this._tfFormatter = this._ssSheet.transform(this._aStyleObj[param2]);
                this._tText.setTextFormat(this._tfFormatter);
                this._tText.defaultTextFormat = this._tfFormatter;
            }
            else
            {
                for each (_loc_3 in this._aStyleObj)
                {
                    
                    _loc_3.color = param1;
                }
            }
            return;
        }// end function

        private function changeCssClassSize(param1:uint, param2:String = null) : void
        {
            var _loc_3:* = undefined;
            if (param2)
            {
                this._aStyleObj[param2].fontSize = param1 + "px";
            }
            else
            {
                for each (_loc_3 in this._aStyleObj)
                {
                    
                    _loc_3.fontSize = param1 + "px";
                }
            }
            return;
        }// end function

        public function appendText(param1:String, param2:String = null) : void
        {
            var _loc_3:* = null;
            if (param2 && this._aStyleObj[param2])
            {
                if (this._tText.filters.length)
                {
                    this._tText.filters = new Array();
                }
                _loc_3 = this._ssSheet.transform(this._aStyleObj[param2]);
                _loc_3.bold = false;
                this._tText.defaultTextFormat = _loc_3;
            }
            if (this._hyperlinkEnabled)
            {
                param1 = HyperlinkFactory.decode(param1);
            }
            this._tText.htmlText = this._tText.htmlText + param1;
            return;
        }// end function

        public function activeSmallHyperlink() : void
        {
            HyperlinkFactory.activeSmallHyperlink(this._tText);
            return;
        }// end function

        private function bindCss() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            if (!this._sCssUrl)
            {
                if (this._needToFinalize)
                {
                    this.finalize();
                }
                return;
            }
            var _loc_1:* = this._ssSheet;
            this._ssSheet = CssManager.getInstance().getCss(this._sCssUrl.uri);
            if (!this._ssSheet)
            {
                if (this._needToFinalize)
                {
                    this.finalize();
                }
                return;
            }
            var _loc_2:* = this._tText.styleSheet;
            this._tText.styleSheet = null;
            for each (_loc_4 in this._ssSheet.styleNames)
            {
                
                if (!_loc_3 || _loc_4 == this._sCssClass || this._sCssClass != _loc_3 && _loc_4 == "p")
                {
                    _loc_3 = _loc_4;
                }
                if (this._ssSheet != _loc_1 || !this._aStyleObj[_loc_4])
                {
                    this._aStyleObj[_loc_4] = this._ssSheet.getStyle(_loc_4);
                }
            }
            if (this._aStyleObj[_loc_3]["shadowSize"] || this._aStyleObj[_loc_3]["shadowColor"])
            {
                _loc_5 = this._aStyleObj[_loc_3]["shadowColor"] ? (parseInt(this._aStyleObj[_loc_3]["shadowColor"].substr(1))) : (0);
                _loc_6 = this._aStyleObj[_loc_3]["shadowSize"] ? (parseInt(this._aStyleObj[_loc_3]["shadowSize"])) : (5);
                this._tText.filters = [new DropShadowFilter(0, 0, _loc_5, 0.5, _loc_6, _loc_6, 3)];
            }
            if (this._aStyleObj[_loc_3]["useEmbedFonts"])
            {
                this._useEmbedFonts = this._aStyleObj[_loc_3]["useEmbedFonts"] == "true";
            }
            if (this._aStyleObj[_loc_3]["paddingLeft"])
            {
                this._nPaddingLeft = parseInt(this._aStyleObj[_loc_3]["paddingLeft"]);
            }
            if (this._aStyleObj[_loc_3]["verticalHeight"])
            {
                this._nTextHeight = parseInt(this._aStyleObj[_loc_3]["verticalHeight"]);
            }
            if (this._aStyleObj[_loc_3]["verticalAlign"])
            {
                this.verticalAlign = this._aStyleObj[_loc_3]["verticalAlign"];
            }
            if (this._aStyleObj[_loc_3]["thickness"])
            {
                this._tText.thickness = this._aStyleObj[_loc_3]["thickness"];
            }
            this._tText.gridFitType = GridFitType.PIXEL;
            this._tText.htmlText = this._sText ? (this._sText) : (this.text);
            this._tfFormatter = this._ssSheet.transform(this._aStyleObj[_loc_3]);
            if (this._aStyleObj[_loc_3]["leading"])
            {
                this._tfFormatter.leading = this._aStyleObj[_loc_3]["leading"];
            }
            if (this._aStyleObj[_loc_3]["letterSpacing"])
            {
                this._tfFormatter.letterSpacing = parseFloat(this._aStyleObj[_loc_3]["letterSpacing"]);
            }
            if (this._aStyleObj[_loc_3]["kerning"])
            {
                this._tfFormatter.kerning = this._aStyleObj[_loc_3]["kerning"] == "true";
            }
            if (!this._neverIndent)
            {
                this._tfFormatter.indent = this._nTextIndent;
            }
            this._tfFormatter.leftMargin = this._nPaddingLeft;
            if (this._useEmbedFonts)
            {
                _loc_7 = FontManager.getInstance().getFontClassName(this._tfFormatter.font);
                if (_loc_7)
                {
                    this._tfFormatter.size = Math.round(int(this._tfFormatter.size) * FontManager.getInstance().getSizeMultipicator(this._tfFormatter.font));
                    this._tfFormatter.font = _loc_7;
                    this._tText.defaultTextFormat.font = _loc_7;
                    this._tText.embedFonts = true;
                    this._tText.antiAliasType = AntiAliasType.ADVANCED;
                }
                else if (this._tfFormatter)
                {
                    _log.warn("System font [" + this._tfFormatter.font + "] used (in " + (getUi() ? (getUi().name) : ("unknow")) + ", from " + this._sCssUrl.uri + ")");
                }
                else
                {
                    _log.fatal("Erreur de formattage.");
                }
            }
            else
            {
                _loc_8 = FontManager.getInstance().getRealFontName(this._tfFormatter.font);
                this._tfFormatter.font = _loc_8 != "" ? (_loc_8) : (this._tfFormatter.font);
                this._tText.embedFonts = false;
            }
            this._tText.setTextFormat(this._tfFormatter);
            this._tText.defaultTextFormat = this._tfFormatter;
            if (this._hyperlinkEnabled)
            {
                HyperlinkFactory.createHyperlink(this._tText, true);
            }
            if (this._nTextHeight)
            {
                this._tText.height = this._nTextHeight;
                this._tText.y = this._tText.y + (this._nHeight / 2 - this._tText.height / 2);
            }
            else if (!this._bFixedHeight)
            {
                this._tText.height = this._tText.textHeight + 5;
                this._nHeight = this._tText.height;
            }
            else
            {
                this._tText.height = this._nHeight;
            }
            if (this._useExtendWidth)
            {
                this._tText.width = this._tText.textWidth + 7;
                this._nWidth = this._tText.width;
            }
            if (_bgColor != -1)
            {
                this.bgColor = _bgColor;
            }
            this.updateAlign();
            if (this._useExtendWidth && getUi())
            {
                getUi().render();
            }
            this._binded = true;
            this.updateTooltipExtensionStyle();
            if (this._needToFinalize)
            {
                this.finalize();
            }
            return;
        }// end function

        public function updateCss() : void
        {
            if (!this._tfFormatter)
            {
                return;
            }
            this._tText.setTextFormat(this._tfFormatter);
            this._tText.defaultTextFormat = this._tfFormatter;
            this.updateTooltipExtensionStyle();
            if (!this._bFixedHeight)
            {
                this._tText.height = this._tText.textHeight + 5;
                this._nHeight = this._tText.height;
            }
            else
            {
                this._tText.height = this._nHeight;
            }
            if (this._useExtendWidth)
            {
                this._tText.width = this._tText.textWidth + 7;
                this._nWidth = this._tText.width;
            }
            if (_bgColor != -1)
            {
                this.bgColor = _bgColor;
            }
            this.updateAlign();
            if (this._useExtendWidth && getUi())
            {
                getUi().render();
            }
            return;
        }// end function

        public function fullSize(param1:int) : void
        {
            this.removeTooltipExtension();
            this._nWidth = param1;
            this._tText.width = param1;
            var _loc_2:* = this._tText.textHeight + 8;
            this._tText.height = _loc_2;
            this._nHeight = _loc_2;
            return;
        }// end function

        public function fullWidth(param1:uint = 0) : void
        {
            this._nWidth = int(this._tText.textWidth + 5);
            this._tText.width = this._nWidth;
            if (param1 > 0)
            {
                this._nWidth = param1;
                this._tText.width = param1;
                if (this._tText.textWidth < param1)
                {
                    this._tText.width = this._tText.textWidth + 10;
                }
            }
            this._nHeight = this._tText.textHeight + 8;
            this._tText.height = this._nHeight;
            return;
        }// end function

        public function resizeText(param1:Boolean = true) : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = false;
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            this.removeTooltipExtension();
            if (!this._tText.multiline && this._tText.autoSize == "none" && this._tfFormatter && !this._tText.wordWrap)
            {
                _loc_2 = int(this._tfFormatter.size);
                _loc_3 = _loc_2;
                if (param1)
                {
                    if (_loc_3 < 12)
                    {
                        _loc_3 = 12;
                    }
                }
                else
                {
                    _loc_3 = 0;
                }
                _loc_4 = false;
                _loc_5 = this._tText.width;
                while (true)
                {
                    
                    _loc_6 = this._tText.textWidth;
                    if (_loc_6 > _loc_5)
                    {
                        _loc_2 = _loc_2 - 1;
                        if (_loc_2 < _loc_3)
                        {
                            if (this._useTooltipExtension)
                            {
                                _loc_4 = true;
                            }
                            else
                            {
                                _log.warn("Attention : Ce texte est beaucoup trop long pour entrer dans ce TextField (Texte : " + this._tText.text + ")");
                            }
                            break;
                        }
                        this._tfFormatter.size = _loc_2;
                        this._tText.setTextFormat(this._tfFormatter);
                        continue;
                    }
                    break;
                }
                if (_loc_4 && (!this.multiline && !this.wordWrap))
                {
                    this.addTooltipExtension();
                }
                else if (this._lastWidth != this._tText.width)
                {
                    this._lastWidth = this._tText.width + 4;
                    this._tText.width = this._lastWidth;
                }
            }
            return;
        }// end function

        public function removeTooltipExtension() : void
        {
            if (this._textFieldTooltipExtension)
            {
                removeChild(this._textFieldTooltipExtension);
                this._tText.width = __width + int(this._textFieldTooltipExtension.width + 2);
                __width = this._tText.width;
                this._textFieldTooltipExtension.removeEventListener(MouseEvent.ROLL_OVER, this.onTooltipExtensionOver);
                this._textFieldTooltipExtension.removeEventListener(MouseEvent.ROLL_OUT, this.onTooltipExtensionOut);
                this._textFieldTooltipExtension = null;
            }
            return;
        }// end function

        private function addTooltipExtension() : void
        {
            this._textFieldTooltipExtension = new TextField();
            this._textFieldTooltipExtension.selectable = false;
            this._textFieldTooltipExtension.height = 1;
            this._textFieldTooltipExtension.width = 1;
            this._textFieldTooltipExtension.autoSize = TextFieldAutoSize.LEFT;
            this.updateTooltipExtensionStyle();
            this._textFieldTooltipExtension.text = "...";
            this._textFieldTooltipExtension.name = "extension_" + name;
            addChild(this._textFieldTooltipExtension);
            var _loc_1:* = this._textFieldTooltipExtension.width + 2;
            this._tText.width = this._tText.width - _loc_1;
            __width = this._tText.width;
            this._textFieldTooltipExtension.x = this._tText.width - 2;
            this._textFieldTooltipExtension.y = this._tText.y;
            this._tText.height = this._tText.textHeight + 3;
            __height = this._tText.height;
            var _loc_2:* = this;
            var _loc_3:* = 0;
            while (_loc_3 < 4)
            {
                
                if (_loc_2 is ButtonContainer)
                {
                    (_loc_2 as ButtonContainer).mouseChildren = true;
                    break;
                }
                _loc_2 = _loc_2.parent;
                if (!_loc_2)
                {
                    break;
                }
                _loc_3++;
            }
            this._textFieldTooltipExtension.addEventListener(MouseEvent.ROLL_OVER, this.onTooltipExtensionOver, false, 0, true);
            this._textFieldTooltipExtension.addEventListener(MouseEvent.ROLL_OUT, this.onTooltipExtensionOut, false, 0, true);
            this._textFieldTooltipExtension.addEventListener(MouseEvent.MOUSE_WHEEL, this.onTooltipExtensionOut, false, 0, true);
            return;
        }// end function

        private function updateTooltipExtensionStyle() : void
        {
            if (!this._textFieldTooltipExtension)
            {
                return;
            }
            this._textFieldTooltipExtension.embedFonts = this._tText.embedFonts;
            this._textFieldTooltipExtension.defaultTextFormat = this._tfFormatter;
            this._textFieldTooltipExtension.setTextFormat(this._tfFormatter);
            this._textTooltipExtensionColor = uint(this._tfFormatter.color);
            this._textFieldTooltipExtension.textColor = this._textTooltipExtensionColor;
            return;
        }// end function

        private function onTextClick(event:TextEvent) : void
        {
            Berilia.getInstance().handler.process(new TextClickMessage(this, event.text));
            return;
        }// end function

        protected function updateAlign() : void
        {
            if (!this._tText.textHeight)
            {
                return;
            }
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            while (_loc_2 < this._tText.numLines)
            {
                
                _loc_1 = _loc_1 + (TextLineMetrics(this._tText.getLineMetrics(_loc_2)).height + TextLineMetrics(this._tText.getLineMetrics(_loc_2)).leading + TextLineMetrics(this._tText.getLineMetrics(_loc_2)).descent);
                _loc_2++;
            }
            switch(this._sVerticalAlign.toUpperCase())
            {
                case VALIGN_CENTER:
                {
                    this._tText.height = _loc_1;
                    this._tText.y = (this.height - this._tText.height) / 2;
                    break;
                }
                case VALIGN_BOTTOM:
                {
                    this._tText.height = this.height;
                    this._tText.y = this.height - _loc_1;
                    break;
                }
                case VALIGN_TOP:
                {
                    this._tText.height = _loc_1;
                    this._tText.y = 0;
                    break;
                }
                case VALIGN_NONE:
                {
                    this._tText.height = this._tText.textHeight + 4 + HEIGHT_OFFSET;
                    this._tText.y = 0;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onTooltipExtensionOver(event:MouseEvent) : void
        {
            var _loc_2:* = Berilia.getInstance().docMain;
            TooltipManager.show(new TextTooltipInfo(this._tText.text), this, UiModuleManager.getInstance().getModule("Ankama_Tooltips"), false, "TextExtension", LocationEnum.POINT_TOP, LocationEnum.POINT_BOTTOM, 20, true, null, TooltipManager.defaultTooltipUiScript, null, "TextInfo");
            this._textFieldTooltipExtension.textColor = 16765814;
            return;
        }// end function

        private function onTooltipExtensionOut(event:MouseEvent = null) : void
        {
            TooltipManager.hide("TextExtension");
            this._textFieldTooltipExtension.textColor = this._textTooltipExtensionColor;
            return;
        }// end function

        public function finalize() : void
        {
            var _loc_1:* = null;
            if (this._binded)
            {
                if (this._autoResize)
                {
                    this.resizeText();
                }
                if (this._hyperlinkEnabled)
                {
                    HyperlinkFactory.createHyperlink(this._tText);
                }
                this._finalized = true;
                _loc_1 = getUi();
                if (_loc_1)
                {
                    _loc_1.iAmFinalized(this);
                }
            }
            else
            {
                this._needToFinalize = true;
            }
            return;
        }// end function

        public function get bmpText() : BitmapData
        {
            var _loc_1:* = new Matrix();
            var _loc_2:* = new BitmapData(this.width, this.height, true, 16711680);
            _loc_2.draw(this._tText, _loc_1, null, null, null, true);
            return _loc_2;
        }// end function

    }
}
