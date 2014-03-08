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
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Label));
      
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
      
      public function set text(param1:String) : void {
         if(param1 == null)
         {
            param1 = "";
         }
         this._sText = param1;
         if(this._bHtmlAllowed)
         {
            if(this._useStyleSheet)
            {
               this._tText.styleSheet = null;
            }
            this._tText.htmlText = param1;
            if(!this._useCustomFormat)
            {
               if(!(this._sCssUrl == null) && !this._cssApplied)
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
            this._tText.text = param1;
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
            this._tText.htmlText = param1;
         }
         if((this._finalized) && (this._autoResize))
         {
            this.resizeText();
         }
      }
      
      public function get htmlText() : String {
         return this._tText.htmlText;
      }
      
      public function set htmlText(param1:String) : void {
         this._tText.htmlText = param1;
      }
      
      public function get hyperlinkEnabled() : Boolean {
         return this._hyperlinkEnabled;
      }
      
      public function set hyperlinkEnabled(param1:Boolean) : void {
         this._hyperlinkEnabled = param1;
         mouseEnabled = param1;
         mouseChildren = param1;
         this._tText.mouseEnabled = param1;
      }
      
      public function get useStyleSheet() : Boolean {
         return this._useStyleSheet;
      }
      
      public function set useStyleSheet(param1:Boolean) : void {
         this._useStyleSheet = param1;
      }
      
      public function get useCustomFormat() : Boolean {
         return this._useCustomFormat;
      }
      
      public function set useCustomFormat(param1:Boolean) : void {
         this._useCustomFormat = param1;
      }
      
      public function get neverIndent() : Boolean {
         return this._neverIndent;
      }
      
      public function set neverIndent(param1:Boolean) : void {
         this._neverIndent = param1;
      }
      
      public function get autoResize() : Boolean {
         return this._autoResize;
      }
      
      public function set autoResize(param1:Boolean) : void {
         this._autoResize = param1;
      }
      
      public function get caretIndex() : int {
         return this._tText.caretIndex;
      }
      
      public function set caretIndex(param1:int) : void {
         var _loc2_:* = 0;
         if(param1 == -1)
         {
            _loc2_ = this._tText.text.length;
            this._tText.setSelection(_loc2_,_loc2_);
         }
         else
         {
            this._tText.setSelection(param1,param1);
         }
      }
      
      public function selectAll() : void {
         this._tText.setSelection(0,this._tText.length);
      }
      
      public function get type() : String {
         return this._sType;
      }
      
      public function set type(param1:String) : void {
         this._sType = param1;
      }
      
      public function get css() : Uri {
         return this._sCssUrl;
      }
      
      public function set css(param1:Uri) : void {
         this._cssApplied = false;
         this.applyCSS(param1);
      }
      
      public function set cssClass(param1:String) : void {
         this._sCssClass = param1 == ""?"p":param1;
         this.bindCss();
      }
      
      public function get cssClass() : String {
         return this._sCssClass;
      }
      
      public function get antialias() : String {
         return this._sAntialiasType;
      }
      
      public function set antialias(param1:String) : void {
         this._sAntialiasType = param1;
         this._tText.antiAliasType = this._sAntialiasType;
      }
      
      public function get thickness() : int {
         return this._tText.thickness;
      }
      
      public function set thickness(param1:int) : void {
         this._tText.thickness = param1;
      }
      
      public function set aStyleObj(param1:Object) : void {
         this._aStyleObj = param1 as Array;
      }
      
      public function get aStyleObj() : Object {
         return this._aStyleObj;
      }
      
      override public function get width() : Number {
         return (this._useExtendWidth) && this._tText.numLines < 2?this._tText.textWidth + 7:this._nWidth;
      }
      
      override public function set width(param1:Number) : void {
         this._nWidth = param1;
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
      
      override public function set height(param1:Number) : void {
         var _loc2_:* = NaN;
         if(!this._tText.multiline)
         {
            _loc2_ = this._tText.textHeight;
            if(param1 < _loc2_)
            {
               param1 = _loc2_;
            }
         }
         this._nHeight = param1;
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
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      public function get html() : Boolean {
         return this._bHtmlAllowed;
      }
      
      public function set html(param1:Boolean) : void {
         this._bHtmlAllowed = param1;
      }
      
      public function set wordWrap(param1:Boolean) : void {
         this._tText.wordWrap = param1;
      }
      
      public function get wordWrap() : Boolean {
         return this._tText.wordWrap;
      }
      
      public function set multiline(param1:Boolean) : void {
         this._tText.multiline = param1;
      }
      
      public function get multiline() : Boolean {
         return this._tText.multiline;
      }
      
      public function get border() : Boolean {
         return this._tText.border;
      }
      
      public function set border(param1:Boolean) : void {
         this._tText.border = param1;
      }
      
      public function get fixedWidth() : Boolean {
         return this._bFixedWidth;
      }
      
      public function set fixedWidth(param1:Boolean) : void {
         this._bFixedWidth = param1;
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
      
      public function set useExtendWidth(param1:Boolean) : void {
         this._useExtendWidth = param1;
      }
      
      public function get fixedHeight() : Boolean {
         return this._bFixedHeight;
      }
      
      public function set fixedHeight(param1:Boolean) : void {
         this._bFixedHeight = param1;
         this._tText.wordWrap = !this._bFixedHeight;
      }
      
      override public function set bgColor(param1:int) : void {
         _bgColor = param1;
         graphics.clear();
         if(bgColor == -1 || !this.width || !this.height)
         {
            return;
         }
         if(_borderColor != -1)
         {
            graphics.lineStyle(1,_borderColor);
         }
         graphics.beginFill(param1,_bgAlpha);
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
      
      override public function set borderColor(param1:int) : void {
         if(param1 == -1)
         {
            this._tText.border = false;
         }
         else
         {
            this._tText.border = true;
            this._tText.borderColor = param1;
         }
      }
      
      public function set selectable(param1:Boolean) : void {
         this._tText.selectable = param1;
      }
      
      public function get length() : uint {
         return this._tText.length;
      }
      
      public function set scrollV(param1:int) : void {
         this._tText.scrollV = param1;
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
      
      public function set useEmbedFonts(param1:Boolean) : void {
         this._useEmbedFonts = param1;
         this._tText.embedFonts = param1;
      }
      
      override public function set disabled(param1:Boolean) : void {
         if(param1)
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
         this._bDisabled = param1;
      }
      
      public function get verticalAlign() : String {
         return this._sVerticalAlign;
      }
      
      public function set verticalAlign(param1:String) : void {
         this._sVerticalAlign = param1;
         this.updateAlign();
      }
      
      public function get textFormat() : TextFormat {
         return this._tfFormatter;
      }
      
      public function set textFormat(param1:TextFormat) : void {
         this._tfFormatter = param1;
         this._tText.setTextFormat(this._tfFormatter);
      }
      
      public function set restrict(param1:String) : void {
         this._tText.restrict = param1;
      }
      
      public function get restrict() : String {
         return this._tText.restrict;
      }
      
      public function set colorText(param1:uint) : void {
         if(!this._tfFormatter)
         {
            _log.error("Error. Try to change the size before formatter was initialized.");
            return;
         }
         this._tfFormatter.color = param1;
         this._tText.setTextFormat(this._tfFormatter);
         this._tText.defaultTextFormat = this._tfFormatter;
      }
      
      public function setCssColor(param1:String, param2:String=null) : void {
         this.changeCssClassColor(param1,param2);
      }
      
      public function setCssSize(param1:uint, param2:String=null) : void {
         this.changeCssClassSize(param1,param2);
      }
      
      public function setStyleSheet(param1:StyleSheet) : void {
         this._useStyleSheet = true;
         this._currentStyleSheet = param1;
      }
      
      public function applyCSS(param1:Uri) : void {
         if(param1 == null)
         {
            return;
         }
         if(param1 == this._sCssUrl && (this._tfFormatter))
         {
            this.updateCss();
         }
         else
         {
            this._sCssUrl = param1;
            CssManager.getInstance().askCss(param1.uri,new Callback(this.bindCss));
         }
      }
      
      public function setBorderColor(param1:int) : void {
         this._tText.borderColor = param1;
      }
      
      public function allowTextMouse(param1:Boolean) : void {
         this.mouseChildren = param1;
         this._tText.mouseEnabled = param1;
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
      
      private function changeCssClassColor(param1:String, param2:String=null) : void {
         var _loc3_:* = undefined;
         if(param2)
         {
            this.aStyleObj[param2].color = param1;
            this._tfFormatter = this._ssSheet.transform(this.aStyleObj[param2]);
            this._tText.setTextFormat(this._tfFormatter);
            this._tText.defaultTextFormat = this._tfFormatter;
         }
         else
         {
            for each (_loc3_ in this.aStyleObj)
            {
               _loc3_.color = param1;
            }
         }
      }
      
      private function changeCssClassSize(param1:uint, param2:String=null) : void {
         var _loc3_:* = undefined;
         if(param2)
         {
            if(this.aStyleObj[param2] == null)
            {
               this.aStyleObj[param2] = new Object();
            }
            this.aStyleObj[param2].fontSize = param1 + "px";
         }
         else
         {
            for each (_loc3_ in this.aStyleObj)
            {
               _loc3_.fontSize = param1 + "px";
            }
         }
      }
      
      public function appendText(param1:String, param2:String=null) : void {
         var _loc3_:TextFormat = null;
         if((param2) && (this.aStyleObj[param2]))
         {
            if(this._tText.filters.length)
            {
               this._tText.filters = new Array();
            }
            _loc3_ = this._ssSheet.transform(this.aStyleObj[param2]);
            _loc3_.bold = false;
            this._tText.defaultTextFormat = _loc3_;
         }
         if(this._hyperlinkEnabled)
         {
            param1 = HyperlinkFactory.decode(param1);
         }
         this._tText.htmlText = this._tText.htmlText + param1;
      }
      
      public function activeSmallHyperlink() : void {
         HyperlinkFactory.activeSmallHyperlink(this._tText);
      }
      
      private function bindCss() : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(!this._sCssUrl)
         {
            if(this._needToFinalize)
            {
               this.finalize();
            }
            return;
         }
         var _loc1_:ExtendedStyleSheet = this._ssSheet;
         this._ssSheet = CssManager.getInstance().getCss(this._sCssUrl.uri);
         if(!this._ssSheet)
         {
            if(this._needToFinalize)
            {
               this.finalize();
            }
            return;
         }
         var _loc2_:StyleSheet = this._tText.styleSheet;
         this._tText.styleSheet = null;
         this.aStyleObj = new Array();
         for each (_loc4_ in this._ssSheet.styleNames)
         {
            if(!_loc3_ || _loc4_ == this._sCssClass || !(this._sCssClass == _loc3_) && _loc4_ == "p")
            {
               _loc3_ = _loc4_;
            }
            if(!(this._ssSheet == _loc1_) || !this.aStyleObj[_loc4_])
            {
               this.aStyleObj[_loc4_] = this._ssSheet.getStyle(_loc4_);
            }
         }
         if((this.aStyleObj[_loc3_]["shadowSize"]) || (this.aStyleObj[_loc3_]["shadowColor"]))
         {
            _loc5_ = this.aStyleObj[_loc3_]["shadowColor"]?parseInt(this.aStyleObj[_loc3_]["shadowColor"].substr(1)):0;
            _loc6_ = this.aStyleObj[_loc3_]["shadowSize"]?parseInt(this.aStyleObj[_loc3_]["shadowSize"]):5;
            this._tText.filters = [new DropShadowFilter(0,0,_loc5_,0.5,_loc6_,_loc6_,3)];
         }
         else
         {
            this._tText.filters = [];
         }
         if(this.aStyleObj[_loc3_]["useEmbedFonts"])
         {
            this._useEmbedFonts = this.aStyleObj[_loc3_]["useEmbedFonts"] == "true";
         }
         if(this.aStyleObj[_loc3_]["paddingLeft"])
         {
            this._nPaddingLeft = parseInt(this.aStyleObj[_loc3_]["paddingLeft"]);
         }
         if(this.aStyleObj[_loc3_]["verticalHeight"])
         {
            this._nTextHeight = parseInt(this.aStyleObj[_loc3_]["verticalHeight"]);
         }
         if(this.aStyleObj[_loc3_]["verticalAlign"])
         {
            this.verticalAlign = this.aStyleObj[_loc3_]["verticalAlign"];
         }
         if(this.aStyleObj[_loc3_]["thickness"])
         {
            this._tText.thickness = this.aStyleObj[_loc3_]["thickness"];
         }
         this._tText.gridFitType = GridFitType.PIXEL;
         this._tText.htmlText = this._sText?this._sText:this.text;
         this._tfFormatter = this._ssSheet.transform(this.aStyleObj[_loc3_]);
         if(this.aStyleObj[_loc3_]["leading"])
         {
            this._tfFormatter.leading = this.aStyleObj[_loc3_]["leading"];
         }
         if(this.aStyleObj[_loc3_]["letterSpacing"])
         {
            this._tfFormatter.letterSpacing = parseFloat(this.aStyleObj[_loc3_]["letterSpacing"]);
         }
         if(this.aStyleObj[_loc3_]["kerning"])
         {
            this._tfFormatter.kerning = this.aStyleObj[_loc3_]["kerning"] == "true";
         }
         if(!this._neverIndent)
         {
            this._tfFormatter.indent = this._nTextIndent;
         }
         this._tfFormatter.leftMargin = this._nPaddingLeft;
         if(this._useEmbedFonts)
         {
            _loc7_ = FontManager.getInstance().getFontClassName(this._tfFormatter.font);
            if(_loc7_)
            {
               this._tfFormatter.size = Math.round(int(this._tfFormatter.size) * FontManager.getInstance().getSizeMultipicator(this._tfFormatter.font));
               this._tfFormatter.font = _loc7_;
               this._tText.defaultTextFormat.font = _loc7_;
               this._tText.embedFonts = true;
               this._tText.antiAliasType = AntiAliasType.ADVANCED;
            }
            else
            {
               if(this._tfFormatter)
               {
                  _log.warn("System font [" + this._tfFormatter.font + "] used (in " + (getUi()?getUi().name:"unknow") + ", from " + this._sCssUrl.uri + ")");
               }
               else
               {
                  _log.fatal("Erreur de formattage.");
               }
            }
         }
         else
         {
            _loc8_ = FontManager.getInstance().getRealFontName(this._tfFormatter.font);
            this._tfFormatter.font = _loc8_ != ""?_loc8_:this._tfFormatter.font;
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
         else
         {
            if(!this._bFixedHeight)
            {
               this._tText.height = this._tText.textHeight + 5;
               this._nHeight = this._tText.height;
            }
            else
            {
               this._tText.height = this._nHeight;
            }
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
      
      public function fullSize(param1:int) : void {
         this.removeTooltipExtension();
         this._nWidth = param1;
         this._tText.width = param1;
         var _loc2_:uint = this._tText.textHeight + 8;
         this._tText.height = _loc2_;
         this._nHeight = _loc2_;
      }
      
      public function fullWidth(param1:uint=0) : void {
         this._nWidth = int(this._tText.textWidth + 5);
         this._tText.width = this._nWidth;
         if(param1 > 0)
         {
            this._nWidth = param1;
            this._tText.width = param1;
            if(this._tText.textWidth < param1)
            {
               this._tText.width = this._tText.textWidth + 10;
            }
         }
         this._nHeight = this._tText.textHeight + 8;
         this._tText.height = this._nHeight;
      }
      
      public function resizeText(param1:Boolean=true) : void {
         var _loc2_:* = 0;
         var _loc3_:* = 0;
         var _loc4_:* = false;
         var _loc5_:* = 0;
         var _loc6_:* = NaN;
         this.removeTooltipExtension();
         if((this._bFixedHeight) && !this._tText.multiline && this._tText.autoSize == "none" && (this._tfFormatter))
         {
            _loc2_ = int(this._tfFormatter.size);
            _loc3_ = _loc2_;
            if(param1)
            {
               if(_loc3_ < 12)
               {
                  _loc3_ = 12;
               }
            }
            else
            {
               _loc3_ = 0;
            }
            _loc4_ = false;
            _loc5_ = this._tText.width;
            while(true)
            {
               _loc6_ = this._tText.textWidth;
               if(_loc6_ > _loc5_ || this._tText.textHeight > this._tText.height)
               {
                  _loc2_--;
                  if(_loc2_ < _loc3_)
                  {
                     if(this._useTooltipExtension)
                     {
                        _loc4_ = true;
                     }
                     else
                     {
                        _log.warn("Attention : Ce texte est beaucoup trop long pour entrer dans ce TextField (Texte : " + this._tText.text + ")");
                     }
                     break;
                  }
                  this._tfFormatter.size = _loc2_;
                  this._tText.setTextFormat(this._tfFormatter);
                  continue;
               }
               break;
            }
            if((_loc4_) && !this.multiline && (this._bFixedHeight))
            {
               this.addTooltipExtension();
            }
            else
            {
               if(this._lastWidth != this._tText.width)
               {
                  this._lastWidth = this._tText.width + 4;
                  this._tText.width = this._lastWidth;
               }
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
         var _loc1_:int = this._textFieldTooltipExtension.width + 2;
         this._tText.width = this._tText.width - _loc1_;
         __width = this._tText.width;
         this._textFieldTooltipExtension.x = this._tText.width;
         this._textFieldTooltipExtension.y = this._tText.y + this._tText.height - this._textFieldTooltipExtension.textHeight - 10;
         if(!this._tText.wordWrap)
         {
            this._textFieldTooltipExtension.y = this._tText.y;
            this._tText.height = this._tText.textHeight + 3;
            __height = this._tText.height;
         }
         var _loc2_:DisplayObjectContainer = this;
         var _loc3_:* = 0;
         while(_loc3_ < 4)
         {
            if(_loc2_ is ButtonContainer)
            {
               (_loc2_ as ButtonContainer).mouseChildren = true;
               break;
            }
            _loc2_ = _loc2_.parent;
            if(!_loc2_)
            {
               break;
            }
            _loc3_++;
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
      
      private function onTextClick(param1:TextEvent) : void {
         param1.stopPropagation();
         Berilia.getInstance().handler.process(new TextClickMessage(this,param1.text));
      }
      
      protected function updateAlign() : void {
         if(!this._tText.textHeight)
         {
            return;
         }
         var _loc1_:* = 0;
         var _loc2_:* = 0;
         while(_loc2_ < this._tText.numLines)
         {
            _loc1_ = _loc1_ + (TextLineMetrics(this._tText.getLineMetrics(_loc2_)).height + TextLineMetrics(this._tText.getLineMetrics(_loc2_)).leading + TextLineMetrics(this._tText.getLineMetrics(_loc2_)).descent);
            _loc2_++;
         }
         switch(this._sVerticalAlign.toUpperCase())
         {
            case VALIGN_CENTER:
               this._tText.height = _loc1_;
               this._tText.y = (this.height - this._tText.height) / 2;
               break;
            case VALIGN_BOTTOM:
               this._tText.height = this.height;
               this._tText.y = this.height - _loc1_;
               break;
            case VALIGN_TOP:
               this._tText.height = _loc1_;
               this._tText.y = 0;
               break;
            case VALIGN_FIXEDHEIGHT:
               if(!this._tText.wordWrap || (this._tText.multiline))
               {
                  this._tText.height = this._tText.textHeight + HEIGHT_OFFSET;
               }
               this._tText.y = 0;
               break;
            case VALIGN_NONE:
               if(!this._tText.wordWrap || (this._tText.multiline))
               {
                  this._tText.height = this._tText.textHeight + 4 + HEIGHT_OFFSET;
               }
               this._tText.y = 0;
               break;
         }
      }
      
      private function onTooltipExtensionOver(param1:MouseEvent) : void {
         var _loc2_:Sprite = Berilia.getInstance().docMain;
         TooltipManager.show(new TextTooltipInfo(this._tText.text),this,UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"TextExtension",LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,20,true,null,TooltipManager.defaultTooltipUiScript,null,"TextInfo");
         this._textFieldTooltipExtension.textColor = 16765814;
      }
      
      private function onTooltipExtensionOut(param1:MouseEvent=null) : void {
         TooltipManager.hide("TextExtension");
         this._textFieldTooltipExtension.textColor = this._textTooltipExtensionColor;
      }
      
      public function finalize() : void {
         var _loc1_:UiRootContainer = null;
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
            _loc1_ = getUi();
            if(_loc1_)
            {
               _loc1_.iAmFinalized(this);
            }
         }
         else
         {
            this._needToFinalize = true;
         }
      }
      
      public function get bmpText() : BitmapData {
         var _loc1_:Matrix = new Matrix();
         var _loc2_:BitmapData = new BitmapData(this.width,this.height,true,16711680);
         _loc2_.draw(this._tText,_loc1_,null,null,null,true);
         return _loc2_;
      }
   }
}
