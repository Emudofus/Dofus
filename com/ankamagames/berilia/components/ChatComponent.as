package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flashx.textLayout.container.ContainerController;
   import flashx.textLayout.elements.TextFlow;
   import flash.display.Sprite;
   import flashx.textLayout.formats.TextLayoutFormat;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.jerakine.types.Uri;
   import __AS3__.vec.Vector;
   import com.adobe.utils.StringUtil;
   import flashx.textLayout.elements.ParagraphElement;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.berilia.factories.HyperlinkFactory;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.jerakine.types.Callback;
   import flashx.textLayout.compose.TextFlowLine;
   import flash.text.engine.FontWeight;
   import flashx.textLayout.formats.TextDecoration;
   import flashx.textLayout.elements.Configuration;
   import com.ankamagames.berilia.types.graphic.ChatTextContainer;
   import flashx.textLayout.compose.StandardFlowComposer;
   import flashx.textLayout.container.ScrollPolicy;
   import flashx.textLayout.formats.BlockProgression;
   import flashx.textLayout.edit.SelectionManager;
   import flashx.textLayout.events.FlowElementMouseEvent;
   import flashx.textLayout.events.SelectionEvent;
   import flash.events.MouseEvent;
   import flashx.textLayout.events.TextLayoutEvent;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.events.Event;
   import com.ankamagames.berilia.managers.TooltipManager;
   import flashx.textLayout.edit.ElementRange;
   import flashx.textLayout.elements.FlowLeafElement;
   import flashx.textLayout.elements.LinkElement;
   import com.ankamagames.berilia.events.LinkInteractionEvent;
   import flash.events.TextEvent;
   import flashx.textLayout.events.ScrollEvent;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flashx.textLayout.events.DamageEvent;
   import flashx.textLayout.formats.VerticalAlign;
   import flashx.textLayout.elements.SpanElement;
   import com.ankamagames.berilia.managers.HtmlManager;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.utils.Dictionary;
   import flashx.textLayout.elements.InlineGraphicElement;
   import flash.display.BitmapData;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flashx.textLayout.compose.IFlowComposer;
   import flash.utils.ByteArray;
   import flash.text.engine.TextBaseline;
   import flash.filesystem.FileStream;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   
   public class ChatComponent extends GraphicContainer implements UIComponent, IRectangle, FinalizableUIComponent
   {
      
      public function ChatComponent() {
         this._bmpdtList = new Dictionary();
         super();
         this._sbScrollBar = new ScrollBar();
         this._sbScrollBar.min = 1;
         this._sbScrollBar.max = 1;
         this._sbScrollBar.step = 1;
         this._sbScrollBar.scrollSpeed = 1 / 6;
         this._sbScrollBar.addEventListener(Event.CHANGE,this.onScroll);
         addChild(this._sbScrollBar);
         this._aStyleObj = new Array();
         this._cssApplied = false;
         this.createTextField();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatComponent));
      
      public static var KAMA_PATTERN:RegExp = new RegExp("(?:\\s|^)([0-9.,\\s]+\\s?)\\/k(?=\\W|$)","gi");
      
      public static var TAGS_PATTERN:RegExp = new RegExp("<([a-zA-Z]+)(>|(\\s*([^>]*)+)>)(.*?)<\\/\\1>","gi");
      
      public static var QUOTE_PATTERN:RegExp = new RegExp("(\'|\")","gi");
      
      public static var BOLD_PATTERN:RegExp = new RegExp("<\\/?b>","gi");
      
      public static var UNDERLINE_PATTERN:RegExp = new RegExp("<\\/?u>","gi");
      
      public static var ITALIC_PATTERN:RegExp = new RegExp("<\\/?i>","gi");
      
      private static var IMAGE_SIZE:int = 20;
      
      public static var LINE_HEIGHT:int = 20;
      
      public static function supprSpace(param1:String) : String {
         var _loc2_:RegExp = new RegExp("_","g");
         return param1;
      }
      
      public static function isValidSmiley(param1:String, param2:int, param3:String) : Boolean {
         if(param2 == 0 && param1.length == param3.length || param2 > 0 && param1.length == param2 + param3.length && param1.charAt(param2-1) == " " || param2 == 0 && param1.length > param3.length && param1.charAt(param2 + param3.length) == " " || param2 > 0 && param2 + param3.length < param1.length && param1.charAt(param2-1) == " " && param1.charAt(param2 + param3.length) == " ")
         {
            return true;
         }
         return false;
      }
      
      private var _finalized:Boolean = false;
      
      private var _controller:ContainerController;
      
      private var _textFlow:TextFlow;
      
      private var _textContainer:Sprite;
      
      private var _sbScrollBar:ScrollBar;
      
      private var _TLFFormat:TextLayoutFormat;
      
      private var _sCssClass:String;
      
      private var _ssSheet:ExtendedStyleSheet;
      
      private var _sCssUrl:Uri;
      
      private var _aStyleObj:Array;
      
      private var _cssApplied:Boolean;
      
      private var _nScrollPos:int = 5;
      
      private var _scrollTopMargin:int = 0;
      
      private var _scrollBottomMargin:int = 0;
      
      private var _smiliesUri:String;
      
      private var _smilies:Vector.<Smiley>;
      
      private var _smiliesActivated:Boolean = false;
      
      override public function remove() : void {
         super.remove();
      }
      
      public function initSmileyTab(param1:String, param2:Object) : void {
         var _loc3_:Object = null;
         var _loc4_:Smiley = null;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:String = null;
         this._smiliesUri = param1;
         this._smilies = new Vector.<Smiley>();
         for each (_loc3_ in param2)
         {
            if(!(_loc3_.triggers == null) && _loc3_.triggers.length > 0)
            {
               _loc4_ = new Smiley(_loc3_.gfxId);
               _loc4_.triggers = new Vector.<String>(_loc3_.triggers.length);
               _loc6_ = _loc3_.triggers.length;
               _loc5_ = 0;
               while(_loc5_ < _loc6_)
               {
                  _loc7_ = _loc3_.triggers[_loc5_];
                  _loc7_ = StringUtil.replace(_loc7_,"&","&amp;");
                  _loc7_ = StringUtil.replace(_loc7_,"<","&lt;");
                  _loc7_ = StringUtil.replace(_loc7_,">","&gt;");
                  _loc4_.triggers[_loc5_] = _loc7_;
                  _loc5_++;
               }
               this._smilies.push(_loc4_);
            }
         }
      }
      
      public function clearText() : void {
         var _loc1_:ParagraphElement = null;
         while(this._textFlow.numChildren > 0)
         {
            this.removeFirstLine();
         }
         this._isDamaged = true;
         this.updateScrollBar(true);
      }
      
      public function removeFirstLine() : void {
         if(this._textFlow.numChildren > 0)
         {
            this._textFlow.removeChildAt(0);
         }
      }
      
      public function removeLines(param1:int) : void {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(_loc2_ < param1)
         {
            this.removeFirstLine();
            _loc2_++;
         }
         this._isDamaged = true;
      }
      
      public function get smiliesActivated() : Boolean {
         return this._smiliesActivated;
      }
      
      public function set smiliesActivated(param1:Boolean) : void {
         this._smiliesActivated = param1;
      }
      
      override public function set width(param1:Number) : void {
         var param1:Number = param1 - this._sbScrollBar.width;
         super.width = param1;
         this._controller.setCompositionSize(param1,this._controller.compositionHeight);
         this._isDamaged = true;
         if(this._finalized)
         {
            this.updateScrollBarPos();
         }
      }
      
      override public function set height(param1:Number) : void {
         if(!(param1 == super.height) || !(param1 == this._sbScrollBar.height - this._scrollTopMargin - this._scrollBottomMargin))
         {
            param1 = param1 + 2;
            super.height = param1;
            this._sbScrollBar.height = param1 - this._scrollTopMargin - this._scrollBottomMargin;
            this._controller.setCompositionSize(this._controller.compositionWidth,param1);
            this._isDamaged = true;
            if(this._finalized)
            {
               this.updateScrollBar();
            }
         }
      }
      
      public function set scrollPos(param1:int) : void {
         this._nScrollPos = param1;
      }
      
      public function get scrollBottomMargin() : int {
         return this._scrollBottomMargin;
      }
      
      public function set scrollBottomMargin(param1:int) : void {
         this._scrollBottomMargin = param1;
         this._sbScrollBar.height = this._controller.compositionHeight - this._scrollTopMargin - this._scrollBottomMargin;
      }
      
      public function get scrollTopMargin() : int {
         return this._scrollTopMargin;
      }
      
      public function set scrollTopMargin(param1:int) : void {
         this._scrollTopMargin = param1;
         this._sbScrollBar.y = this._scrollTopMargin;
         this._sbScrollBar.height = this._controller.compositionHeight - this._scrollTopMargin - this._scrollBottomMargin;
      }
      
      public function appendText(param1:String, param2:String=null, param3:Boolean=true) : ParagraphElement {
         FpsManager.getInstance().startTracking("chat",4972530);
         if((param2) && (this._aStyleObj[param2]))
         {
            this._TLFFormat = this._ssSheet.TLFTransform(this._aStyleObj[param2]);
         }
         var param1:String = HyperlinkFactory.decode(param1);
         var _loc4_:ParagraphElement = this.createParagraphe(param1);
         if(param3)
         {
            this._textFlow.addChild(_loc4_);
            this._isDamaged = true;
            if(this._finalized)
            {
               this.updateScrollBar();
            }
         }
         FpsManager.getInstance().stopTracking("chat");
         return _loc4_;
      }
      
      public function set css(param1:Uri) : void {
         this._cssApplied = false;
         this.applyCSS(param1);
      }
      
      public function applyCSS(param1:Uri) : void {
         if(param1 == null)
         {
            return;
         }
         if(param1 != this._sCssUrl)
         {
            this._sCssUrl = param1;
            CssManager.getInstance().askCss(param1.uri,new Callback(this.bindCss));
         }
      }
      
      public function set cssClass(param1:String) : void {
         this._sCssClass = param1 == ""?"p":param1;
         this.bindCss();
      }
      
      private function bindCss() : void {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:ExtendedStyleSheet = this._ssSheet;
         this._ssSheet = CssManager.getInstance().getCss(this._sCssUrl.uri);
         for each (_loc3_ in this._ssSheet.styleNames)
         {
            if(!_loc2_ || _loc3_ == this._sCssClass || !(this._sCssClass == _loc2_) && _loc3_ == "p")
            {
               _loc2_ = _loc3_;
            }
            if(!(this._ssSheet == _loc1_) || !this._aStyleObj[_loc3_])
            {
               this._aStyleObj[_loc3_] = this._ssSheet.getStyle(_loc3_);
            }
         }
         this._TLFFormat = this._ssSheet.TLFTransform(this._aStyleObj[_loc2_]);
      }
      
      public function setCssColor(param1:String, param2:String=null) : void {
         this.changeCssClassColor(param1,param2);
      }
      
      public function setCssSize(param1:uint, param2:uint, param3:String=null) : void {
         this.changeCssClassSize(param1,param2,param3);
      }
      
      private function changeCssClassSize(param1:uint, param2:uint, param3:String=null) : void {
         var _loc4_:* = undefined;
         if(param3)
         {
            this._aStyleObj[param3].fontSize = param1 + "px";
         }
         else
         {
            for each (_loc4_ in this._aStyleObj)
            {
               _loc4_.fontSize = param1 + "px";
            }
         }
         this.bindCss();
         this._textFlow.lineHeight = param2;
      }
      
      private function changeCssClassColor(param1:String, param2:String=null) : void {
         var _loc3_:* = undefined;
         if(param2)
         {
            if(this._aStyleObj[param2] == null)
            {
               this._aStyleObj[param2] = new Object();
            }
            this._aStyleObj[param2].color = param1;
            this._TLFFormat.concat(this._ssSheet.TLFTransform(this._aStyleObj[param2]));
         }
         else
         {
            for each (_loc3_ in this._aStyleObj)
            {
               _loc3_.color = param1;
            }
         }
      }
      
      public function get scrollV() : int {
         return Math.round((this._controller.verticalScrollPosition + this._controller.compositionHeight) / this._textFlow.lineHeight);
      }
      
      public function set scrollV(param1:int) : void {
         this._controller.verticalScrollPosition = param1 * this._textFlow.lineHeight - this._controller.compositionHeight;
      }
      
      public function get maxScrollV() : int {
         this._textFlow.flowComposer.composeToPosition();
         return this._textFlow.flowComposer.numLines;
      }
      
      public function get textHeight() : Number {
         var _loc3_:* = 0;
         var _loc1_:Number = 0;
         var _loc2_:int = this._textFlow.numChildren;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc1_ + this.getParagraphHeight(this._textFlow.getChildAt(_loc3_) as ParagraphElement);
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function getParagraphHeight(param1:ParagraphElement) : Number {
         var _loc5_:TextFlowLine = null;
         var _loc2_:Number = 0;
         var _loc3_:int = param1.getAbsoluteStart();
         var _loc4_:int = _loc3_ + param1.textLength;
         while(_loc3_ < _loc4_)
         {
            _loc5_ = param1.getTextFlow().flowComposer.findLineAtPosition(_loc3_);
            _loc2_ = _loc2_ + _loc5_.height;
            _loc3_ = _loc3_ + _loc5_.textLength;
         }
         return _loc2_;
      }
      
      public function set scrollCss(param1:Uri) : void {
         this._sbScrollBar.css = param1;
      }
      
      public function get scrollCss() : Uri {
         return this._sbScrollBar.css;
      }
      
      private function createTextField() : void {
         var _loc1_:TextLayoutFormat = new TextLayoutFormat();
         _loc1_.fontWeight = FontWeight.BOLD;
         _loc1_.color = "#ff0000";
         _loc1_.textDecoration = TextDecoration.NONE;
         var _loc2_:Configuration = new Configuration();
         _loc2_.defaultLinkNormalFormat = _loc1_;
         TextFlow.defaultConfiguration = _loc2_;
         this._textContainer = new ChatTextContainer();
         this._textContainer.x = this._sbScrollBar.width;
         addChild(this._textContainer);
         this._textFlow = new TextFlow(_loc2_);
         this._textFlow.paddingBottom = 2;
         this._textFlow.flowComposer = new StandardFlowComposer();
         this._controller = new ContainerController(this._textContainer,width,height);
         this._controller.horizontalScrollPolicy = ScrollPolicy.ON;
         this._controller.blockProgression = BlockProgression.TB;
         this._textFlow.interactionManager = new SelectionManager();
         this._textFlow.addEventListener(FlowElementMouseEvent.ROLL_OVER,this.onMouseOverLink);
         this._textFlow.addEventListener(FlowElementMouseEvent.ROLL_OUT,this.onMouseOutLink);
         this._textFlow.addEventListener(SelectionEvent.SELECTION_CHANGE,this.selectionChanged);
         this._textContainer.addEventListener(MouseEvent.ROLL_OUT,this.onRollOutChat);
         this._textFlow.addEventListener(TextLayoutEvent.SCROLL,this.scrollTextFlow);
         this._textFlow.flowComposer.addController(this._controller);
         this._textFlow.flowComposer.updateAllControllers();
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,"updateChatControllers");
      }
      
      private var _isDamaged:Boolean = false;
      
      private function onEnterFrame(param1:Event) : void {
         if(this._isDamaged)
         {
            this._isDamaged = false;
            this._textFlow.flowComposer.updateAllControllers();
         }
      }
      
      private function onRollOutChat(param1:MouseEvent) : void {
         TooltipManager.hideAll();
      }
      
      private var _currentSelection:String = "";
      
      private function selectionChanged(param1:SelectionEvent) : void {
         var _loc3_:ParagraphElement = null;
         var _loc2_:ElementRange = param1.selectionState?ElementRange.createElementRange(param1.selectionState.textFlow,param1.selectionState.absoluteStart,param1.selectionState.absoluteEnd):null;
         this._currentSelection = "";
         var _loc4_:FlowLeafElement = _loc2_.firstLeaf;
         do
         {
               if(!(_loc3_ == null) && !(_loc3_ == _loc4_.getParagraph()))
               {
                  this._currentSelection = this._currentSelection + "\n";
                  _loc3_ = _loc4_.getParagraph();
               }
               this._currentSelection = this._currentSelection + _loc4_.text;
            }while(_loc4_ = _loc4_.getNextLeaf());
            
         }
         
         private function onMouseOverLink(param1:FlowElementMouseEvent) : void {
            var _loc2_:LinkElement = null;
            var _loc3_:Array = null;
            var _loc4_:String = null;
            var _loc5_:String = null;
            if(param1.flowElement is LinkElement)
            {
               _loc2_ = param1.flowElement as LinkElement;
               _loc3_ = _loc2_.href.replace("event:","").split(",");
               _loc4_ = _loc3_.shift();
               _loc5_ = _loc4_ + "," + Math.round(param1.originalEvent.stageX) + "," + Math.round(param1.originalEvent.stageY) + "," + _loc3_.join(",");
               dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OVER,_loc5_));
            }
         }
         
         private function onMouseOutLink(param1:FlowElementMouseEvent) : void {
            TooltipManager.hideAll();
            dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OUT));
         }
         
         private function onTextClick(param1:FlowElementMouseEvent) : void {
            TooltipManager.hideAll();
            var _loc2_:String = (param1.flowElement as LinkElement).href;
            if(_loc2_ != "")
            {
               dispatchEvent(new TextEvent(TextEvent.LINK,false,false,_loc2_.replace("event:","")));
            }
         }
         
         private var _magicbool:Boolean = true;
         
         private function onScroll(param1:Event) : void {
            this._magicbool = false;
            this._controller.verticalScrollPosition = this._sbScrollBar.value / this._sbScrollBar.max * this.maxScrollV * this._textFlow.lineHeight - this._controller.compositionHeight;
         }
         
         private function scrollTextFlow(param1:Event) : void {
            var _loc2_:ScrollEvent = null;
            if(param1 is ScrollEvent)
            {
               _loc2_ = param1 as ScrollEvent;
               if(this._magicbool)
               {
                  _loc2_.delta = _loc2_.delta / 3 * -1;
                  this._sbScrollBar.onWheel(param1,false);
               }
               else
               {
                  this._magicbool = true;
               }
            }
         }
         
         private function updateScrollBar(param1:Boolean=false) : void {
            this._sbScrollBar.visible = true;
            this._sbScrollBar.disabled = false;
            this._sbScrollBar.total = this.maxScrollV;
            this._sbScrollBar.max = this.maxScrollV - Math.floor(this._controller.compositionHeight / this._textFlow.lineHeight);
            if(param1)
            {
               this._controller.verticalScrollPosition = 0;
               this._sbScrollBar.value = 0;
            }
            else
            {
               this._sbScrollBar.value = this.scrollV;
            }
         }
         
         private function updateScrollBarPos() : void {
            if(this._nScrollPos >= 0)
            {
               this._sbScrollBar.x = this._controller.compositionWidth - this._sbScrollBar.width;
            }
            else
            {
               this._sbScrollBar.x = 0;
            }
         }
         
         public function get finalized() : Boolean {
            return this._finalized;
         }
         
         public function set finalized(param1:Boolean) : void {
            this._finalized = param1;
         }
         
         public function finalize() : void {
            this._sbScrollBar.finalize();
            this.updateScrollBarPos();
            this.updateScrollBar();
            HyperlinkFactory.createTextClickHandler(this);
            HyperlinkFactory.createRollOverHandler(this);
            this._finalized = true;
            var _loc1_:UiRootContainer = getUi();
            if(_loc1_ != null)
            {
               _loc1_.iAmFinalized(this);
            }
         }
         
         private function createParagraphe(param1:String) : ParagraphElement {
            this._textFlow.addEventListener(DamageEvent.DAMAGE,this.onDamage);
            var _loc2_:ParagraphElement = new ParagraphElement();
            _loc2_.format = this._TLFFormat;
            _loc2_.verticalAlign = VerticalAlign.MIDDLE;
            var _loc3_:Object = new RegExp(TAGS_PATTERN).exec(param1);
            while(_loc3_ != null)
            {
               if(_loc3_.index > 0)
               {
                  this.createSpan(_loc2_,param1.substring(0,_loc3_.index),false);
               }
               this.createSpan(_loc2_,_loc3_[0],true);
               param1 = param1.substring(_loc3_.index + _loc3_[0].length);
               _loc3_ = new RegExp(TAGS_PATTERN).exec(param1);
            }
            if(param1.length > 0)
            {
               this.createSpan(_loc2_,param1,false);
            }
            return _loc2_;
         }
         
         private function onDamage(param1:DamageEvent) : void {
            this._textFlow.removeEventListener(DamageEvent.DAMAGE,this.onDamage);
            this._isDamaged = true;
         }
         
         private function createLinkElement(param1:ParagraphElement, param2:Object) : void {
            var _loc7_:String = null;
            var _loc3_:LinkElement = new LinkElement();
            _loc3_.addEventListener(FlowElementMouseEvent.CLICK,this.onTextClick);
            var _loc4_:SpanElement = new SpanElement();
            var _loc5_:* = "";
            var _loc6_:Array = param2[3].split(" ");
            for each (_loc7_ in _loc6_)
            {
               if(_loc7_.search("href") != -1)
               {
                  _loc3_.href = this.getAttributeValue(_loc7_);
               }
               else
               {
                  if(_loc7_.search("style") != -1)
                  {
                     _loc5_ = this.getAttributeValue(_loc7_);
                  }
               }
            }
            _loc4_.fontWeight = FontWeight.BOLD;
            _loc4_.color = this._TLFFormat.color;
            _loc4_ = HtmlManager.formateSpan(_loc4_,_loc5_);
            _loc4_.text = param2[5].replace(BOLD_PATTERN,"").replace(UNDERLINE_PATTERN,"");
            _loc3_.addChild(_loc4_);
            param1.addChild(_loc3_);
         }
         
         private function getAttributeValue(param1:String) : String {
            var _loc3_:String = null;
            var _loc2_:Array = param1.split("=");
            _loc2_.shift();
            if(_loc2_.length > 1)
            {
               _loc3_ = _loc2_.join("=");
            }
            else
            {
               _loc3_ = _loc2_[0];
            }
            return _loc3_.replace(QUOTE_PATTERN,"");
         }
         
         private function createSpan(param1:ParagraphElement, param2:String, param3:Boolean, param4:String="") : void {
            var _loc6_:Smiley = null;
            var _loc7_:String = null;
            var _loc8_:* = 0;
            var _loc9_:RegExp = null;
            var _loc10_:Object = null;
            var _loc11_:String = null;
            var _loc12_:String = null;
            var _loc5_:* = 0;
            while(param2.length > 0)
            {
               _loc6_ = this._smiliesActivated?this.getSmileyFromText(param2):null;
               _loc7_ = param2.substring(0,_loc6_ != null?_loc6_.position:param2.length);
               if(_loc7_.length > 0 || _loc6_ == null)
               {
                  if(this._smiliesActivated)
                  {
                     _loc8_ = _loc7_.search(KAMA_PATTERN);
                     while(_loc8_ != -1)
                     {
                        _loc9_ = new RegExp(KAMA_PATTERN);
                        _loc10_ = _loc9_.exec(_loc7_);
                        _loc11_ = _loc7_.substring(0,_loc8_);
                        if(_loc11_ != "")
                        {
                           _loc12_ = StringUtil.trim(_loc10_[1]);
                           if(_loc12_.indexOf(".") == -1 && _loc12_.indexOf(",") == -1 && _loc12_.indexOf(" ") == -1)
                           {
                              _loc12_ = StringUtils.formateIntToString(parseInt(_loc12_));
                           }
                           param1.addChild(this.createSpanElement(_loc7_.substring(0,_loc8_ + 1) + _loc12_,param4));
                        }
                        param1.addChild(this.createImage(new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_kama"),"/k"));
                        _loc7_ = _loc7_.substr(_loc8_ + _loc10_[0].length);
                        _loc8_ = _loc7_.search(KAMA_PATTERN);
                     }
                  }
                  if(!param3)
                  {
                     param1.addChild(this.createSpanElement(_loc7_,param4));
                  }
                  else
                  {
                     this.createSpanElementsFromHtmlTags(param1,_loc7_,param4);
                  }
                  if(_loc6_ == null)
                  {
                     break;
                  }
               }
               if(_loc6_.position != -1)
               {
                  param1.addChild(this.createImage(this._smiliesUri + _loc6_.pictoId + ".png",_loc6_.currentTrigger));
                  param2 = param2.substring(_loc6_.position + _loc6_.currentTrigger.length);
               }
            }
         }
         
         private function createSpanElement(param1:String, param2:String) : SpanElement {
            var _loc3_:SpanElement = new SpanElement();
            var _loc4_:String = param1;
            _loc4_ = StringUtil.replace(_loc4_,"&amp;","&");
            _loc4_ = StringUtil.replace(_loc4_,"&lt;","<");
            _loc4_ = StringUtil.replace(_loc4_,"&gt;",">");
            _loc3_.text = _loc4_;
            _loc3_ = HtmlManager.formateSpan(_loc3_,param2);
            return _loc3_;
         }
         
         private function createSpanElementsFromHtmlTags(param1:ParagraphElement, param2:String, param3:String) : void {
            var _loc4_:Object = null;
            var _loc5_:String = null;
            var _loc6_:Array = null;
            var _loc7_:String = null;
            _loc4_ = new RegExp(TAGS_PATTERN).exec(param2);
            while(_loc4_ != null)
            {
               if(_loc4_.index > 0)
               {
                  param1.addChild(this.createSpanElement(param2.substring(0,_loc4_.index),param3));
               }
               switch(_loc4_[1])
               {
                  case "p":
                  case "span":
                     _loc6_ = _loc4_[3].split(" ");
                     for each (_loc7_ in _loc6_)
                     {
                        if(_loc7_.search("style") != -1)
                        {
                           _loc5_ = this.getAttributeValue(_loc7_);
                        }
                     }
                     this.createSpan(param1,_loc4_[5],true,_loc5_ == ""?param3:_loc5_);
                     break;
                  case "a":
                     this.createLinkElement(param1,_loc4_);
                     break;
                  case "i":
                     this.createSpanElementsFromHtmlTags(param1,_loc4_[0].replace(ITALIC_PATTERN,""),HtmlManager.addValueToInlineStyle(param3,"font-style","italic"));
                     break;
                  case "b":
                     this.createSpanElementsFromHtmlTags(param1,_loc4_[0].replace(BOLD_PATTERN,""),HtmlManager.addValueToInlineStyle(param3,"font-weight","bold"));
                     break;
                  case "u":
                     this.createSpanElementsFromHtmlTags(param1,_loc4_[0].replace(UNDERLINE_PATTERN,""),HtmlManager.addValueToInlineStyle(param3,"text-decoration","underline"));
                     break;
                  default:
                     trace("On fait rien: " + _loc4_[1] + " " + _loc4_[0]);
               }
               param2 = param2.substring(_loc4_.index + _loc4_[0].length);
               _loc4_ = new RegExp(TAGS_PATTERN).exec(param2);
            }
            if(param2.length > 0)
            {
               param1.addChild(this.createSpanElement(param2,param3));
            }
         }
         
         private var _bmpdtList:Dictionary;
         
         private function createImage(param1:*, param2:String) : InlineGraphicElement {
            var inlineGraphic:InlineGraphicElement = null;
            var imgTx:Texture = null;
            var bmpdt:BitmapData = null;
            var bmp:Bitmap = null;
            var loader:Loader = null;
            var flcomposer:IFlowComposer = null;
            var list:Dictionary = null;
            var ba:ByteArray = null;
            var pUri:* = param1;
            var pTrigger:String = param2;
            inlineGraphic = new InlineGraphicElement(pTrigger);
            inlineGraphic.alignmentBaseline = TextBaseline.DESCENT;
            if(pUri is Uri)
            {
               imgTx = new Texture();
               imgTx.uri = pUri;
               imgTx.finalize();
               inlineGraphic.source = imgTx;
            }
            else
            {
               if(pUri is String)
               {
                  if(this._bmpdtList[pUri] != null)
                  {
                     bmpdt = this._bmpdtList[pUri];
                     bmp = new Bitmap(bmpdt.clone(),"auto",true);
                     inlineGraphic.source = bmp;
                  }
                  else
                  {
                     loader = new Loader();
                     flcomposer = this._textFlow.flowComposer;
                     list = this._bmpdtList;
                     loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(param1:Event):void
                     {
                        var _loc2_:Bitmap = loader.content as Bitmap;
                        inlineGraphic.source = _loc2_;
                        list[pUri] = _loc2_.bitmapData;
                        _isDamaged = true;
                     });
                     ba = this.getFile(pUri);
                     if(ba)
                     {
                        loader.loadBytes(ba);
                     }
                  }
               }
            }
            return inlineGraphic;
         }
         
         private function getFile(param1:String) : ByteArray {
            var _loc3_:FileStream = null;
            var _loc4_:ByteArray = null;
            var _loc2_:File = new File(param1);
            if(_loc2_.exists)
            {
               _loc3_ = new FileStream();
               _loc3_.open(_loc2_,FileMode.READ);
               _loc4_ = new ByteArray();
               _loc3_.readBytes(_loc4_);
               _loc3_.close();
               return _loc4_;
            }
            return null;
         }
         
         public function getLastParagrapheElement() : ParagraphElement {
            return this._textFlow.getChildAt(this._textFlow.numChildren-1) as ParagraphElement;
         }
         
         public function insertParagraphes(param1:Array) : void {
            var _loc2_:ParagraphElement = null;
            for each (_loc2_ in param1)
            {
               _loc2_.fontSize = this._TLFFormat.fontSize;
               this._textFlow.addChild(_loc2_);
            }
            this._isDamaged = true;
            this.scrollV = this.maxScrollV;
            this.updateScrollBar();
         }
         
         private function getSmileyFromText(param1:String) : Smiley {
            var _loc2_:* = 0;
            var _loc3_:Smiley = null;
            var _loc4_:Smiley = null;
            var _loc5_:String = null;
            for each (_loc4_ in this._smilies)
            {
               for each (_loc5_ in _loc4_.triggers)
               {
                  if(_loc5_ != null)
                  {
                     _loc2_ = param1.toLowerCase().indexOf(_loc5_.toLowerCase());
                     if(_loc2_ != -1)
                     {
                        if(isValidSmiley(param1,_loc2_,_loc5_))
                        {
                           if(_loc3_ == null || !(_loc3_ == null) && _loc3_.position > _loc2_)
                           {
                              _loc4_.position = _loc2_;
                              _loc4_.currentTrigger = _loc5_;
                              _loc3_ = _loc4_;
                           }
                        }
                     }
                  }
               }
            }
            return _loc3_;
         }
      }
   }
   import __AS3__.vec.Vector;
   
   class Smiley extends Object
   {
      
      function Smiley(param1:String) {
         super();
         this.pictoId = param1;
         this.position = -1;
      }
      
      public var pictoId:String;
      
      public var triggers:Vector.<String>;
      
      public var position:int;
      
      public var currentTrigger:String;
   }
