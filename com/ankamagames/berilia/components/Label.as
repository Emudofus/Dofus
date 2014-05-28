package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.berilia.factories.HyperlinkFactory;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.berilia.managers.TooltipManager;
   import flash.events.TextEvent;
   import flash.text.*;
   import flash.filters.DropShadowFilter;
   import com.ankamagames.jerakine.managers.FontManager;
   import flash.events.MouseEvent;
   import flash.display.DisplayObjectContainer;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.messages.TextClickMessage;
   import flash.display.Sprite;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class Label extends GraphicContainer implements UIComponent, IRectangle, FinalizableUIComponent
   {
      
      public function Label() {
         super();
         this.aStyleObj = new Array();
         this.createTextField();
         this._tText.type = TextFieldType.DYNAMIC;
         this._tText.selectable = false;
         this._tText.mouseEnabled = false;
         MEMORY_LOG[this] = 1;
      }
      
      public static var HEIGHT_OFFSET:int = 0;
      
      public static var MEMORY_LOG:Dictionary;
      
      protected static const _log:Logger;
      
      private static const VALIGN_NONE:String = "NONE";
      
      private static const VALIGN_TOP:String = "TOP";
      
      private static const VALIGN_CENTER:String = "CENTER";
      
      private static const VALIGN_BOTTOM:String = "BOTTOM";
      
      private static const VALIGN_FIXEDHEIGHT:String = "FIXEDHEIGHT";
      
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
      
      protected var _aStyleObj:Array;
      
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
      
      public function get text() : String {
         return this._tText.text;
      }
      
      public function set text(sValue:String) : void {
         if(sValue == null)
         {
            sValue = "";
         }
         this._sText = sValue;
         if(this._bHtmlAllowed)
         {
            if(this._useStyleSheet)
            {
               this._tText.styleSheet = null;
            }
            this._tText.htmlText = sValue;
            if(!this._useCustomFormat)
            {
               if((!(this._sCssUrl == null)) && (!this._cssApplied))
               {
                  this.applyCSS(this._sCssUrl);
                  this._cssApplied = true;
               }
               else
               {
                  this.updateCss();
                  if(_bgColor != -1)
                  {
                     this.bgColor = _bgColor;
                  }
               }
            }
         }
         else
         {
            this._tText.text = sValue;
         }
         if(!this._useCustomFormat)
         {
            if(!this._sCssClass)
            {
               this.cssClass = "p";
            }
         }
         if(this._hyperlinkEnabled)
         {
            HyperlinkFactory.createTextClickHandler(this._tText,this._useStyleSheet);
         }
         if(this._currentStyleSheet)
         {
            this._tText.styleSheet = this._currentStyleSheet;
            this._tText.htmlText = sValue;
         }
         if((this._finalized) && (this._autoResize))
         {
            this.resizeText();
         }
      }
      
      public function get htmlText() : String {
         return this._tText.htmlText;
      }
      
      public function set htmlText(val:String) : void {
         this._tText.htmlText = val;
      }
      
      public function get hyperlinkEnabled() : Boolean {
         return this._hyperlinkEnabled;
      }
      
      public function set hyperlinkEnabled(bValue:Boolean) : void {
         this._hyperlinkEnabled = bValue;
         mouseEnabled = bValue;
         mouseChildren = bValue;
         this._tText.mouseEnabled = bValue;
      }
      
      public function get useStyleSheet() : Boolean {
         return this._useStyleSheet;
      }
      
      public function set useStyleSheet(bValue:Boolean) : void {
         this._useStyleSheet = bValue;
      }
      
      public function get useCustomFormat() : Boolean {
         return this._useCustomFormat;
      }
      
      public function set useCustomFormat(bValue:Boolean) : void {
         this._useCustomFormat = bValue;
      }
      
      public function get neverIndent() : Boolean {
         return this._neverIndent;
      }
      
      public function set neverIndent(bValue:Boolean) : void {
         this._neverIndent = bValue;
      }
      
      public function get autoResize() : Boolean {
         return this._autoResize;
      }
      
      public function set autoResize(bValue:Boolean) : void {
         this._autoResize = bValue;
      }
      
      public function get caretIndex() : int {
         return this._tText.caretIndex;
      }
      
      public function set caretIndex(pos:int) : void {
         var lastPos:* = 0;
         if(pos == -1)
         {
            lastPos = this._tText.text.length;
            this._tText.setSelection(lastPos,lastPos);
         }
         else
         {
            this._tText.setSelection(pos,pos);
         }
      }
      
      public function selectAll() : void {
         this._tText.setSelection(0,this._tText.length);
      }
      
      public function get type() : String {
         return this._sType;
      }
      
      public function set type(sValue:String) : void {
         this._sType = sValue;
      }
      
      public function get css() : Uri {
         return this._sCssUrl;
      }
      
      public function set css(sFile:Uri) : void {
         this._cssApplied = false;
         this.applyCSS(sFile);
      }
      
      public function set cssClass(c:String) : void {
         this._sCssClass = c == ""?"p":c;
         this.bindCss();
      }
      
      public function get cssClass() : String {
         return this._sCssClass;
      }
      
      public function get antialias() : String {
         return this._sAntialiasType;
      }
      
      public function set antialias(s:String) : void {
         this._sAntialiasType = s;
         this._tText.antiAliasType = this._sAntialiasType;
      }
      
      public function get thickness() : int {
         return this._tText.thickness;
      }
      
      public function set thickness(value:int) : void {
         this._tText.thickness = value;
      }
      
      public function set aStyleObj(value:Object) : void {
         this._aStyleObj = value as Array;
      }
      
      public function get aStyleObj() : Object {
         return this._aStyleObj;
      }
      
      override public function get width() : Number {
         return (this._useExtendWidth) && (this._tText.numLines < 2)?this._tText.textWidth + 7:this._nWidth;
      }
      
      override public function set width(nValue:Number) : void {
         this._nWidth = nValue;
         this._tText.width = this._nWidth;
         if(_bgColor != -1)
         {
            this.bgColor = _bgColor;
         }
         if(!this._bFixedHeight)
         {
            this.bindCss();
         }
      }
      
      override public function get height() : Number {
         return this._nHeight;
      }
      
      override public function set height(nValue:Number) : void {
         var valMin:* = NaN;
         if(!this._tText.multiline)
         {
            valMin = this._tText.textHeight;
            if(nValue < valMin)
            {
               nValue = valMin;
            }
         }
         this._nHeight = nValue;
         this._tText.height = this._nHeight;
         __height = this._nHeight;
         if(_bgColor != -1)
         {
            this.bgColor = _bgColor;
         }
         this.updateAlign();
      }
      
      public function get textWidth() : Number {
         return this._tText.textWidth;
      }
      
      public function get textHeight() : Number {
         return this._tText.textHeight;
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set finalized(value:Boolean) : void {
         this._finalized = value;
      }
      
      public function get html() : Boolean {
         return this._bHtmlAllowed;
      }
      
      public function set html(bValue:Boolean) : void {
         this._bHtmlAllowed = bValue;
      }
      
      public function set wordWrap(bWordWrap:Boolean) : void {
         this._tText.wordWrap = bWordWrap;
      }
      
      public function get wordWrap() : Boolean {
         return this._tText.wordWrap;
      }
      
      public function set multiline(bMultiline:Boolean) : void {
         this._tText.multiline = bMultiline;
      }
      
      public function get multiline() : Boolean {
         return this._tText.multiline;
      }
      
      public function get border() : Boolean {
         return this._tText.border;
      }
      
      public function set border(bValue:Boolean) : void {
         this._tText.border = bValue;
      }
      
      public function get fixedWidth() : Boolean {
         return this._bFixedWidth;
      }
      
      public function set fixedWidth(bValue:Boolean) : void {
         this._bFixedWidth = bValue;
         if(this._bFixedWidth)
         {
            this._tText.autoSize = TextFieldAutoSize.NONE;
         }
         else
         {
            this._tText.autoSize = TextFieldAutoSize.LEFT;
         }
      }
      
      public function get useExtendWidth() : Boolean {
         return this._useExtendWidth;
      }
      
      public function set useExtendWidth(v:Boolean) : void {
         this._useExtendWidth = v;
      }
      
      public function get fixedHeight() : Boolean {
         return this._bFixedHeight;
      }
      
      public function set fixedHeight(bValue:Boolean) : void {
         this._bFixedHeight = bValue;
         this._tText.wordWrap = !this._bFixedHeight;
      }
      
      override public function set bgColor(nColor:int) : void {
         _bgColor = nColor;
         graphics.clear();
         if((bgColor == -1) || (!this.width) || (!this.height))
         {
            return;
         }
         if(_borderColor != -1)
         {
            graphics.lineStyle(1,_borderColor);
         }
         graphics.beginFill(nColor,_bgAlpha);
         if(!_bgCornerRadius)
         {
            graphics.drawRect(x,y,this.width,this.height + 2);
         }
         else
         {
            graphics.drawRoundRect(this._tText.x,this._tText.y,this._tText.width,this._tText.height + 2,_bgCornerRadius,_bgCornerRadius);
         }
         graphics.endFill();
      }
      
      override public function set borderColor(nColor:int) : void {
         if(nColor == -1)
         {
            this._tText.border = false;
         }
         else
         {
            this._tText.border = true;
            this._tText.borderColor = nColor;
         }
      }
      
      public function set selectable(bValue:Boolean) : void {
         this._tText.selectable = bValue;
      }
      
      public function get length() : uint {
         return this._tText.length;
      }
      
      public function set scrollV(nVal:int) : void {
         this._tText.scrollV = nVal;
      }
      
      public function get scrollV() : int {
         this._tText.getCharBoundaries(0);
         return this._tText.scrollV;
      }
      
      public function get maxScrollV() : int {
         this._tText.getCharBoundaries(0);
         return this._tText.maxScrollV;
      }
      
      public function get textfield() : TextField {
         return this._tText;
      }
      
      public function get useEmbedFonts() : Boolean {
         return this._useEmbedFonts;
      }
      
      public function set useEmbedFonts(b:Boolean) : void {
         this._useEmbedFonts = b;
         this._tText.embedFonts = b;
      }
      
      override public function set disabled(bool:Boolean) : void {
         if(bool)
         {
            handCursor = false;
            mouseEnabled = false;
            this._tText.mouseEnabled = false;
         }
         else
         {
            handCursor = true;
            mouseEnabled = true;
            this._tText.mouseEnabled = true;
         }
         this._bDisabled = bool;
      }
      
      public function get verticalAlign() : String {
         return this._sVerticalAlign;
      }
      
      public function set verticalAlign(s:String) : void {
         this._sVerticalAlign = s;
         this.updateAlign();
      }
      
      public function get textFormat() : TextFormat {
         return this._tfFormatter;
      }
      
      public function set textFormat(tf:TextFormat) : void {
         this._tfFormatter = tf;
         this._tText.setTextFormat(this._tfFormatter);
      }
      
      public function set restrict(restrictTo:String) : void {
         this._tText.restrict = restrictTo;
      }
      
      public function get restrict() : String {
         return this._tText.restrict;
      }
      
      public function set colorText(color:uint) : void {
         if(!this._tfFormatter)
         {
            _log.error("Error. Try to change the size before formatter was initialized.");
            return;
         }
         this._tfFormatter.color = color;
         this._tText.setTextFormat(this._tfFormatter);
         this._tText.defaultTextFormat = this._tfFormatter;
      }
      
      public function setCssColor(color:String, style:String = null) : void {
         this.changeCssClassColor(color,style);
      }
      
      public function setCssSize(size:uint, style:String = null) : void {
         this.changeCssClassSize(size,style);
      }
      
      public function setStyleSheet(styles:StyleSheet) : void {
         this._useStyleSheet = true;
         this._currentStyleSheet = styles;
      }
      
      public function applyCSS(sFile:Uri) : void {
         if(sFile == null)
         {
            return;
         }
         if((sFile == this._sCssUrl) && (this._tfFormatter))
         {
            this.updateCss();
         }
         else
         {
            this._sCssUrl = sFile;
            CssManager.getInstance().askCss(sFile.uri,new Callback(this.bindCss));
         }
      }
      
      public function setBorderColor(nColor:int) : void {
         this._tText.borderColor = nColor;
      }
      
      public function allowTextMouse(bValue:Boolean) : void {
         this.mouseChildren = bValue;
         this._tText.mouseEnabled = bValue;
      }
      
      override public function remove() : void {
         super.remove();
         if((this._tText) && (this._tText.parent))
         {
            removeChild(this._tText);
         }
         TooltipManager.hide("TextExtension");
      }
      
      override public function free() : void {
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
      }
      
      private function createTextField() : void {
         this._tText = new TextField();
         this._tText.addEventListener(TextEvent.LINK,this.onTextClick);
         addChild(this._tText);
      }
      
      private function changeCssClassColor(color:String, style:String = null) : void {
         var i:* = undefined;
         if(style)
         {
            this.aStyleObj[style].color = color;
            this._tfFormatter = this._ssSheet.transform(this.aStyleObj[style]);
            this._tText.setTextFormat(this._tfFormatter);
            this._tText.defaultTextFormat = this._tfFormatter;
         }
         else
         {
            for each(i in this.aStyleObj)
            {
               i.color = color;
            }
         }
      }
      
      private function changeCssClassSize(size:uint, style:String = null) : void {
         var i:* = undefined;
         if(style)
         {
            if(this.aStyleObj[style] == null)
            {
               this.aStyleObj[style] = new Object();
            }
            this.aStyleObj[style].fontSize = size + "px";
         }
         else
         {
            for each(i in this.aStyleObj)
            {
               i.fontSize = size + "px";
            }
         }
      }
      
      public function appendText(sTxt:String, style:String = null) : void {
         var textFormat:TextFormat = null;
         if((style) && (this.aStyleObj[style]))
         {
            if(this._tText.filters.length)
            {
               this._tText.filters = new Array();
            }
            textFormat = this._ssSheet.transform(this.aStyleObj[style]);
            textFormat.bold = false;
            this._tText.defaultTextFormat = textFormat;
         }
         if(this._hyperlinkEnabled)
         {
            sTxt = HyperlinkFactory.decode(sTxt);
         }
         this._tText.htmlText = this._tText.htmlText + sTxt;
      }
      
      public function activeSmallHyperlink() : void {
         HyperlinkFactory.activeSmallHyperlink(this._tText);
      }
      
      private function bindCss() : void {
         var styleToDisplay:String = null;
         var s:String = null;
         var sc:uint = 0;
         var ss:uint = 0;
         var fontClass:String = null;
         var font:String = null;
         if(!this._sCssUrl)
         {
            if(this._needToFinalize)
            {
               this.finalize();
            }
            return;
         }
         var oldCss:ExtendedStyleSheet = this._ssSheet;
         this._ssSheet = CssManager.getInstance().getCss(this._sCssUrl.uri);
         if(!this._ssSheet)
         {
            if(this._needToFinalize)
            {
               this.finalize();
            }
            return;
         }
         var currentStyleSheet:StyleSheet = this._tText.styleSheet;
         this._tText.styleSheet = null;
         this.aStyleObj = new Array();
         for each(s in this._ssSheet.styleNames)
         {
            if((!styleToDisplay) || (s == this._sCssClass) || (!(this._sCssClass == styleToDisplay)) && (s == "p"))
            {
               styleToDisplay = s;
            }
            if((!(this._ssSheet == oldCss)) || (!this.aStyleObj[s]))
            {
               this.aStyleObj[s] = this._ssSheet.getStyle(s);
            }
         }
         if((this.aStyleObj[styleToDisplay]["shadowSize"]) || (this.aStyleObj[styleToDisplay]["shadowColor"]))
         {
            sc = this.aStyleObj[styleToDisplay]["shadowColor"]?parseInt(this.aStyleObj[styleToDisplay]["shadowColor"].substr(1)):0;
            ss = this.aStyleObj[styleToDisplay]["shadowSize"]?parseInt(this.aStyleObj[styleToDisplay]["shadowSize"]):5;
            this._tText.filters = [new DropShadowFilter(0,0,sc,0.5,ss,ss,3)];
         }
         else
         {
            this._tText.filters = [];
         }
         if(this.aStyleObj[styleToDisplay]["useEmbedFonts"])
         {
            this._useEmbedFonts = this.aStyleObj[styleToDisplay]["useEmbedFonts"] == "true";
         }
         if(this.aStyleObj[styleToDisplay]["paddingLeft"])
         {
            this._nPaddingLeft = parseInt(this.aStyleObj[styleToDisplay]["paddingLeft"]);
         }
         if(this.aStyleObj[styleToDisplay]["verticalHeight"])
         {
            this._nTextHeight = parseInt(this.aStyleObj[styleToDisplay]["verticalHeight"]);
         }
         if(this.aStyleObj[styleToDisplay]["verticalAlign"])
         {
            this.verticalAlign = this.aStyleObj[styleToDisplay]["verticalAlign"];
         }
         if(this.aStyleObj[styleToDisplay]["thickness"])
         {
            this._tText.thickness = this.aStyleObj[styleToDisplay]["thickness"];
         }
         this._tText.gridFitType = GridFitType.PIXEL;
         this._tText.htmlText = this._sText?this._sText:this.text;
         this._tfFormatter = this._ssSheet.transform(this.aStyleObj[styleToDisplay]);
         if(this.aStyleObj[styleToDisplay]["leading"])
         {
            this._tfFormatter.leading = this.aStyleObj[styleToDisplay]["leading"];
         }
         if(this.aStyleObj[styleToDisplay]["letterSpacing"])
         {
            this._tfFormatter.letterSpacing = parseFloat(this.aStyleObj[styleToDisplay]["letterSpacing"]);
         }
         if(this.aStyleObj[styleToDisplay]["kerning"])
         {
            this._tfFormatter.kerning = this.aStyleObj[styleToDisplay]["kerning"] == "true";
         }
         if(!this._neverIndent)
         {
            this._tfFormatter.indent = this._nTextIndent;
         }
         this._tfFormatter.leftMargin = this._nPaddingLeft;
         if(this._useEmbedFonts)
         {
            fontClass = FontManager.getInstance().getFontClassName(this._tfFormatter.font);
            if(fontClass)
            {
               this._tfFormatter.size = Math.round(int(this._tfFormatter.size) * FontManager.getInstance().getSizeMultipicator(this._tfFormatter.font));
               this._tfFormatter.font = fontClass;
               this._tText.defaultTextFormat.font = fontClass;
               this._tText.embedFonts = true;
               this._tText.antiAliasType = AntiAliasType.ADVANCED;
            }
            else if(this._tfFormatter)
            {
               _log.warn("System font [" + this._tfFormatter.font + "] used (in " + (getUi()?getUi().name:"unknow") + ", from " + this._sCssUrl.uri + ")");
            }
            else
            {
               _log.fatal("Erreur de formattage.");
            }
            
         }
         else
         {
            font = FontManager.getInstance().getRealFontName(this._tfFormatter.font);
            this._tfFormatter.font = !(font == "")?font:this._tfFormatter.font;
            this._tText.embedFonts = false;
         }
         this._tText.setTextFormat(this._tfFormatter);
         this._tText.defaultTextFormat = this._tfFormatter;
         if(this._hyperlinkEnabled)
         {
            HyperlinkFactory.createTextClickHandler(this._tText,true);
         }
         if(this._nTextHeight)
         {
            this._tText.height = this._nTextHeight;
            this._tText.y = this._tText.y + (this._nHeight / 2 - this._tText.height / 2);
         }
         else if(!this._bFixedHeight)
         {
            this._tText.height = this._tText.textHeight + 5;
            this._nHeight = this._tText.height;
         }
         else
         {
            this._tText.height = this._nHeight;
         }
         
         if(this._useExtendWidth)
         {
            this._tText.width = this._tText.textWidth + 7;
            this._nWidth = this._tText.width;
         }
         if(_bgColor != -1)
         {
            this.bgColor = _bgColor;
         }
         this.updateAlign();
         if((this._useExtendWidth) && (getUi()))
         {
            getUi().render();
         }
         this._binded = true;
         this.updateTooltipExtensionStyle();
         if(this._needToFinalize)
         {
            this.finalize();
         }
      }
      
      public function updateCss() : void {
         if(!this._tfFormatter)
         {
            return;
         }
         this._tText.setTextFormat(this._tfFormatter);
         this._tText.defaultTextFormat = this._tfFormatter;
         this.updateTooltipExtensionStyle();
         if(!this._bFixedHeight)
         {
            this._tText.height = this._tText.textHeight + 5;
            this._nHeight = this._tText.height;
         }
         else
         {
            this._tText.height = this._nHeight;
         }
         if(this._useExtendWidth)
         {
            this._tText.width = this._tText.textWidth + 7;
            this._nWidth = this._tText.width;
         }
         if(_bgColor != -1)
         {
            this.bgColor = _bgColor;
         }
         this.updateAlign();
         if((this._useExtendWidth) && (getUi()))
         {
            getUi().render();
         }
      }
      
      public function fullSize(width:int) : void {
         this.removeTooltipExtension();
         this._nWidth = width;
         this._tText.width = width;
         var tHeight:uint = this._tText.textHeight + 8;
         this._tText.height = tHeight;
         this._nHeight = tHeight;
      }
      
      public function fullWidth(maxWidth:uint = 0) : void {
         this._nWidth = int(this._tText.textWidth + 5);
         this._tText.width = this._nWidth;
         if(maxWidth > 0)
         {
            this._nWidth = maxWidth;
            this._tText.width = maxWidth;
            if(this._tText.textWidth < maxWidth)
            {
               this._tText.width = this._tText.textWidth + 10;
            }
         }
         this._nHeight = this._tText.textHeight + 8;
         this._tText.height = this._nHeight;
      }
      
      public function resizeText(useSizeMin:Boolean = true) : void {
         var currentSize:* = 0;
         var sizeMin:* = 0;
         var needTooltipExtension:* = false;
         var currentTextFieldWidth:* = 0;
         var textWidth:* = NaN;
         this.removeTooltipExtension();
         if((this._bFixedHeight) && (!this._tText.multiline) && (this._tText.autoSize == "none") && (this._tfFormatter))
         {
            currentSize = int(this._tfFormatter.size);
            sizeMin = currentSize;
            if(useSizeMin)
            {
               if(sizeMin < 12)
               {
                  sizeMin = 12;
               }
            }
            else
            {
               sizeMin = 0;
            }
            needTooltipExtension = false;
            currentTextFieldWidth = this._tText.width;
            while(true)
            {
               textWidth = this._tText.textWidth;
               if((textWidth > currentTextFieldWidth) || (this._tText.textHeight > this._tText.height))
               {
                  currentSize--;
                  if(currentSize < sizeMin)
                  {
                     if(this._useTooltipExtension)
                     {
                        needTooltipExtension = true;
                     }
                     else
                     {
                        _log.warn("Attention : Ce texte est beaucoup trop long pour entrer dans ce TextField (Texte : " + this._tText.text + ")");
                     }
                     break;
                  }
                  this._tfFormatter.size = currentSize;
                  this._tText.setTextFormat(this._tfFormatter);
                  continue;
               }
               break;
            }
            if((needTooltipExtension) && (!this.multiline) && (this._bFixedHeight))
            {
               this.addTooltipExtension();
            }
            else if(this._lastWidth != this._tText.width)
            {
               this._lastWidth = this._tText.width + 4;
               this._tText.width = this._lastWidth;
            }
            
         }
      }
      
      public function removeTooltipExtension() : void {
         if(this._textFieldTooltipExtension)
         {
            removeChild(this._textFieldTooltipExtension);
            this._tText.width = __width + int(this._textFieldTooltipExtension.width + 2);
            __width = this._tText.width;
            this._textFieldTooltipExtension.removeEventListener(MouseEvent.ROLL_OVER,this.onTooltipExtensionOver);
            this._textFieldTooltipExtension.removeEventListener(MouseEvent.ROLL_OUT,this.onTooltipExtensionOut);
            this._textFieldTooltipExtension = null;
         }
      }
      
      private function addTooltipExtension() : void {
         this._textFieldTooltipExtension = new TextField();
         this._textFieldTooltipExtension.selectable = false;
         this._textFieldTooltipExtension.height = 1;
         this._textFieldTooltipExtension.width = 1;
         this._textFieldTooltipExtension.autoSize = TextFieldAutoSize.LEFT;
         this.updateTooltipExtensionStyle();
         this._textFieldTooltipExtension.text = "...";
         this._textFieldTooltipExtension.name = "extension_" + name;
         addChild(this._textFieldTooltipExtension);
         var w:int = this._textFieldTooltipExtension.width + 2;
         this._tText.width = this._tText.width - w;
         __width = this._tText.width;
         this._textFieldTooltipExtension.x = this._tText.width;
         this._textFieldTooltipExtension.y = this._tText.y + this._tText.height - this._textFieldTooltipExtension.textHeight - 10;
         if(!this._tText.wordWrap)
         {
            this._textFieldTooltipExtension.y = this._tText.y;
            this._tText.height = this._tText.textHeight + 3;
            __height = this._tText.height;
         }
         var target:DisplayObjectContainer = this;
         var i:int = 0;
         while(i < 4)
         {
            if(target is ButtonContainer)
            {
               (target as ButtonContainer).mouseChildren = true;
               break;
            }
            target = target.parent;
            if(!target)
            {
               break;
            }
            i++;
         }
         this._textFieldTooltipExtension.addEventListener(MouseEvent.ROLL_OVER,this.onTooltipExtensionOver,false,0,true);
         this._textFieldTooltipExtension.addEventListener(MouseEvent.ROLL_OUT,this.onTooltipExtensionOut,false,0,true);
         this._textFieldTooltipExtension.addEventListener(MouseEvent.MOUSE_WHEEL,this.onTooltipExtensionOut,false,0,true);
      }
      
      private function updateTooltipExtensionStyle() : void {
         if(!this._textFieldTooltipExtension)
         {
            return;
         }
         this._textFieldTooltipExtension.embedFonts = this._tText.embedFonts;
         this._textFieldTooltipExtension.defaultTextFormat = this._tfFormatter;
         this._textFieldTooltipExtension.setTextFormat(this._tfFormatter);
         this._textTooltipExtensionColor = uint(this._tfFormatter.color);
         this._textFieldTooltipExtension.textColor = this._textTooltipExtensionColor;
      }
      
      private function onTextClick(e:TextEvent) : void {
         e.stopPropagation();
         Berilia.getInstance().handler.process(new TextClickMessage(this,e.text));
      }
      
      protected function updateAlign() : void {
         if(!this._tText.textHeight)
         {
            return;
         }
         var h:int = 0;
         var i:int = 0;
         while(i < this._tText.numLines)
         {
            h = h + (TextLineMetrics(this._tText.getLineMetrics(i)).height + TextLineMetrics(this._tText.getLineMetrics(i)).leading + TextLineMetrics(this._tText.getLineMetrics(i)).descent);
            i++;
         }
         switch(this._sVerticalAlign.toUpperCase())
         {
            case VALIGN_CENTER:
               this._tText.height = h;
               this._tText.y = (this.height - this._tText.height) / 2;
               break;
            case VALIGN_BOTTOM:
               this._tText.height = this.height;
               this._tText.y = this.height - h;
               break;
            case VALIGN_TOP:
               this._tText.height = h;
               this._tText.y = 0;
               break;
            case VALIGN_FIXEDHEIGHT:
               if((!this._tText.wordWrap) || (this._tText.multiline))
               {
                  this._tText.height = this._tText.textHeight + HEIGHT_OFFSET;
               }
               this._tText.y = 0;
               break;
            case VALIGN_NONE:
               if((!this._tText.wordWrap) || (this._tText.multiline))
               {
                  this._tText.height = this._tText.textHeight + 4 + HEIGHT_OFFSET;
               }
               this._tText.y = 0;
               break;
         }
      }
      
      private function onTooltipExtensionOver(e:MouseEvent) : void {
         var docMain:Sprite = Berilia.getInstance().docMain;
         TooltipManager.show(new TextTooltipInfo(this._tText.text),this,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"TextExtension",LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,20,true,null,TooltipManager.defaultTooltipUiScript,null,"TextInfo");
         this._textFieldTooltipExtension.textColor = 16765814;
      }
      
      private function onTooltipExtensionOut(e:MouseEvent = null) : void {
         TooltipManager.hide("TextExtension");
         this._textFieldTooltipExtension.textColor = this._textTooltipExtensionColor;
      }
      
      public function finalize() : void {
         var ui:UiRootContainer = null;
         if(this._binded)
         {
            if(this._autoResize)
            {
               this.resizeText();
            }
            if(this._hyperlinkEnabled)
            {
               HyperlinkFactory.createTextClickHandler(this._tText);
            }
            this._finalized = true;
            ui = getUi();
            if(ui)
            {
               ui.iAmFinalized(this);
            }
         }
         else
         {
            this._needToFinalize = true;
         }
      }
      
      public function get bmpText() : BitmapData {
         var m:Matrix = new Matrix();
         var bmpdt:BitmapData = new BitmapData(this.width,this.height,true,16711680);
         bmpdt.draw(this._tText,m,null,null,null,true);
         return bmpdt;
      }
   }
}
