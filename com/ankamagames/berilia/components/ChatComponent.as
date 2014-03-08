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
   import __AS3__.vec.*;
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
      
      public static function supprSpace(val:String) : String {
         var regExp:RegExp = new RegExp("_","g");
         return val;
      }
      
      public static function isValidSmiley(sTxt:String, indexOfSmiley:int, triggerTxt:String) : Boolean {
         if((indexOfSmiley == 0) && (sTxt.length == triggerTxt.length) || (indexOfSmiley > 0) && (sTxt.length == indexOfSmiley + triggerTxt.length) && (sTxt.charAt(indexOfSmiley - 1) == " ") || (indexOfSmiley == 0) && (sTxt.length > triggerTxt.length) && (sTxt.charAt(indexOfSmiley + triggerTxt.length) == " ") || (indexOfSmiley > 0) && (indexOfSmiley + triggerTxt.length < sTxt.length) && (sTxt.charAt(indexOfSmiley - 1) == " ") && (sTxt.charAt(indexOfSmiley + triggerTxt.length) == " "))
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
      
      public function initSmileyTab(uri:String, data:Object) : void {
         var t:Object = null;
         var smiley:Smiley = null;
         var i:* = 0;
         var len:* = 0;
         var trigger:String = null;
         this._smiliesUri = uri;
         this._smilies = new Vector.<Smiley>();
         for each (t in data)
         {
            if((!(t.triggers == null)) && (t.triggers.length > 0))
            {
               smiley = new Smiley(t.gfxId);
               smiley.triggers = new Vector.<String>(t.triggers.length);
               len = t.triggers.length;
               i = 0;
               while(i < len)
               {
                  trigger = t.triggers[i];
                  trigger = StringUtil.replace(trigger,"&","&amp;");
                  trigger = StringUtil.replace(trigger,"<","&lt;");
                  trigger = StringUtil.replace(trigger,">","&gt;");
                  smiley.triggers[i] = trigger;
                  i++;
               }
               this._smilies.push(smiley);
            }
         }
      }
      
      public function clearText() : void {
         var p:ParagraphElement = null;
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
      
      public function removeLines(value:int) : void {
         var i:* = 0;
         i = 0;
         while(i < value)
         {
            this.removeFirstLine();
            i++;
         }
         this._isDamaged = true;
      }
      
      public function get smiliesActivated() : Boolean {
         return this._smiliesActivated;
      }
      
      public function set smiliesActivated(value:Boolean) : void {
         this._smiliesActivated = value;
      }
      
      override public function set width(val:Number) : void {
         var val:Number = val - this._sbScrollBar.width;
         super.width = val;
         this._controller.setCompositionSize(val,this._controller.compositionHeight);
         this._isDamaged = true;
         if(this._finalized)
         {
            this.updateScrollBarPos();
         }
      }
      
      override public function set height(val:Number) : void {
         if((!(val == super.height)) || (!(val == this._sbScrollBar.height - this._scrollTopMargin - this._scrollBottomMargin)))
         {
            val = val + 2;
            super.height = val;
            this._sbScrollBar.height = val - this._scrollTopMargin - this._scrollBottomMargin;
            this._controller.setCompositionSize(this._controller.compositionWidth,val);
            this._isDamaged = true;
            if(this._finalized)
            {
               this.updateScrollBar();
            }
         }
      }
      
      public function set scrollPos(nValue:int) : void {
         this._nScrollPos = nValue;
      }
      
      public function get scrollBottomMargin() : int {
         return this._scrollBottomMargin;
      }
      
      public function set scrollBottomMargin(value:int) : void {
         this._scrollBottomMargin = value;
         this._sbScrollBar.height = this._controller.compositionHeight - this._scrollTopMargin - this._scrollBottomMargin;
      }
      
      public function get scrollTopMargin() : int {
         return this._scrollTopMargin;
      }
      
      public function set scrollTopMargin(value:int) : void {
         this._scrollTopMargin = value;
         this._sbScrollBar.y = this._scrollTopMargin;
         this._sbScrollBar.height = this._controller.compositionHeight - this._scrollTopMargin - this._scrollBottomMargin;
      }
      
      public function appendText(sTxt:String, style:String=null, addToChat:Boolean=true) : ParagraphElement {
         FpsManager.getInstance().startTracking("chat",4972530);
         if((style) && (this._aStyleObj[style]))
         {
            this._TLFFormat = this._ssSheet.TLFTransform(this._aStyleObj[style]);
         }
         var sTxt:String = HyperlinkFactory.decode(sTxt);
         var p:ParagraphElement = this.createParagraphe(sTxt);
         if(addToChat)
         {
            this._textFlow.addChild(p);
            this._isDamaged = true;
            if(this._finalized)
            {
               this.updateScrollBar();
            }
         }
         FpsManager.getInstance().stopTracking("chat");
         return p;
      }
      
      public function set css(sFile:Uri) : void {
         this._cssApplied = false;
         this.applyCSS(sFile);
      }
      
      public function applyCSS(sFile:Uri) : void {
         if(sFile == null)
         {
            return;
         }
         if(sFile != this._sCssUrl)
         {
            this._sCssUrl = sFile;
            CssManager.getInstance().askCss(sFile.uri,new Callback(this.bindCss));
         }
      }
      
      public function set cssClass(c:String) : void {
         this._sCssClass = c == ""?"p":c;
         this.bindCss();
      }
      
      private function bindCss() : void {
         var styleToDisplay:String = null;
         var sProperty:String = null;
         var oldCss:ExtendedStyleSheet = this._ssSheet;
         this._ssSheet = CssManager.getInstance().getCss(this._sCssUrl.uri);
         for each (sProperty in this._ssSheet.styleNames)
         {
            if((!styleToDisplay) || (sProperty == this._sCssClass) || (!(this._sCssClass == styleToDisplay)) && (sProperty == "p"))
            {
               styleToDisplay = sProperty;
            }
            if((!(this._ssSheet == oldCss)) || (!this._aStyleObj[sProperty]))
            {
               this._aStyleObj[sProperty] = this._ssSheet.getStyle(sProperty);
            }
         }
         this._TLFFormat = this._ssSheet.TLFTransform(this._aStyleObj[styleToDisplay]);
      }
      
      public function setCssColor(color:String, style:String=null) : void {
         this.changeCssClassColor(color,style);
      }
      
      public function setCssSize(size:uint, lineHeight:uint, style:String=null) : void {
         this.changeCssClassSize(size,lineHeight,style);
      }
      
      private function changeCssClassSize(size:uint, lineHeight:uint, style:String=null) : void {
         var i:* = undefined;
         if(style)
         {
            this._aStyleObj[style].fontSize = size + "px";
         }
         else
         {
            for each (i in this._aStyleObj)
            {
               i.fontSize = size + "px";
            }
         }
         this.bindCss();
         this._textFlow.lineHeight = lineHeight;
      }
      
      private function changeCssClassColor(color:String, style:String=null) : void {
         var i:* = undefined;
         if(style)
         {
            if(this._aStyleObj[style] == null)
            {
               this._aStyleObj[style] = new Object();
            }
            this._aStyleObj[style].color = color;
            this._TLFFormat.concat(this._ssSheet.TLFTransform(this._aStyleObj[style]));
         }
         else
         {
            for each (i in this._aStyleObj)
            {
               i.color = color;
            }
         }
      }
      
      public function get scrollV() : int {
         return Math.round((this._controller.verticalScrollPosition + this._controller.compositionHeight) / this._textFlow.lineHeight);
      }
      
      public function set scrollV(val:int) : void {
         this._controller.verticalScrollPosition = val * this._textFlow.lineHeight - this._controller.compositionHeight;
      }
      
      public function get maxScrollV() : int {
         this._textFlow.flowComposer.composeToPosition();
         return this._textFlow.flowComposer.numLines;
      }
      
      public function get textHeight() : Number {
         var i:* = 0;
         var height:Number = 0;
         var len:int = this._textFlow.numChildren;
         i = 0;
         while(i < len)
         {
            height = height + this.getParagraphHeight(this._textFlow.getChildAt(i) as ParagraphElement);
            i++;
         }
         return height;
      }
      
      private function getParagraphHeight(p:ParagraphElement) : Number {
         var line:TextFlowLine = null;
         var height:Number = 0;
         var pos:int = p.getAbsoluteStart();
         var endPos:int = pos + p.textLength;
         while(pos < endPos)
         {
            line = p.getTextFlow().flowComposer.findLineAtPosition(pos);
            height = height + line.height;
            pos = pos + line.textLength;
         }
         return height;
      }
      
      public function set scrollCss(sUrl:Uri) : void {
         this._sbScrollBar.css = sUrl;
      }
      
      public function get scrollCss() : Uri {
         return this._sbScrollBar.css;
      }
      
      private function createTextField() : void {
         var ca:TextLayoutFormat = new TextLayoutFormat();
         ca.fontWeight = FontWeight.BOLD;
         ca.color = "#ff0000";
         ca.textDecoration = TextDecoration.NONE;
         var conf:Configuration = new Configuration();
         conf.defaultLinkNormalFormat = ca;
         TextFlow.defaultConfiguration = conf;
         this._textContainer = new ChatTextContainer();
         this._textContainer.x = this._sbScrollBar.width;
         addChild(this._textContainer);
         this._textFlow = new TextFlow(conf);
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
      
      private function onEnterFrame(pEvt:Event) : void {
         if(this._isDamaged)
         {
            this._isDamaged = false;
            this._textFlow.flowComposer.updateAllControllers();
         }
      }
      
      private function onRollOutChat(pEvt:MouseEvent) : void {
         TooltipManager.hideAll();
      }
      
      private var _currentSelection:String = "";
      
      private function selectionChanged(pEvt:SelectionEvent) : void {
         var prevPara:ParagraphElement = null;
         var range:ElementRange = pEvt.selectionState?ElementRange.createElementRange(pEvt.selectionState.textFlow,pEvt.selectionState.absoluteStart,pEvt.selectionState.absoluteEnd):null;
         this._currentSelection = "";
         var leaf:FlowLeafElement = range.firstLeaf;
         do
         {
               if((!(prevPara == null)) && (!(prevPara == leaf.getParagraph())))
               {
                  this._currentSelection = this._currentSelection + "\n";
                  prevPara = leaf.getParagraph();
               }
               this._currentSelection = this._currentSelection + leaf.text;
            }while(leaf = leaf.getNextLeaf());
            
         }
         
         private function onMouseOverLink(pEvt:FlowElementMouseEvent) : void {
            var link:LinkElement = null;
            var params:Array = null;
            var type:String = null;
            var data:String = null;
            if(pEvt.flowElement is LinkElement)
            {
               link = pEvt.flowElement as LinkElement;
               params = link.href.replace("event:","").split(",");
               type = params.shift();
               data = type + "," + Math.round(pEvt.originalEvent.stageX) + "," + Math.round(pEvt.originalEvent.stageY) + "," + params.join(",");
               dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OVER,data));
            }
         }
         
         private function onMouseOutLink(pEvt:FlowElementMouseEvent) : void {
            TooltipManager.hideAll();
            dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OUT));
         }
         
         private function onTextClick(pEvt:FlowElementMouseEvent) : void {
            TooltipManager.hideAll();
            var text:String = (pEvt.flowElement as LinkElement).href;
            if(text != "")
            {
               dispatchEvent(new TextEvent(TextEvent.LINK,false,false,text.replace("event:","")));
            }
         }
         
         private var _magicbool:Boolean = true;
         
         private function onScroll(pEvt:Event) : void {
            this._magicbool = false;
            this._controller.verticalScrollPosition = this._sbScrollBar.value / this._sbScrollBar.max * this.maxScrollV * this._textFlow.lineHeight - this._controller.compositionHeight;
         }
         
         private function scrollTextFlow(pEvt:Event) : void {
            var evt:ScrollEvent = null;
            if(pEvt is ScrollEvent)
            {
               evt = pEvt as ScrollEvent;
               if(this._magicbool)
               {
                  evt.delta = evt.delta / 3 * -1;
                  this._sbScrollBar.onWheel(pEvt,false);
               }
               else
               {
                  this._magicbool = true;
               }
            }
         }
         
         private function updateScrollBar(reset:Boolean=false) : void {
            this._sbScrollBar.visible = true;
            this._sbScrollBar.disabled = false;
            this._sbScrollBar.total = this.maxScrollV;
            this._sbScrollBar.max = this.maxScrollV - Math.floor(this._controller.compositionHeight / this._textFlow.lineHeight);
            if(reset)
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
         
         public function set finalized(b:Boolean) : void {
            this._finalized = b;
         }
         
         public function finalize() : void {
            this._sbScrollBar.finalize();
            this.updateScrollBarPos();
            this.updateScrollBar();
            HyperlinkFactory.createTextClickHandler(this);
            HyperlinkFactory.createRollOverHandler(this);
            this._finalized = true;
            var uiRoot:UiRootContainer = getUi();
            if(uiRoot != null)
            {
               uiRoot.iAmFinalized(this);
            }
         }
         
         private function createParagraphe(text:String) : ParagraphElement {
            this._textFlow.addEventListener(DamageEvent.DAMAGE,this.onDamage);
            var p:ParagraphElement = new ParagraphElement();
            p.format = this._TLFFormat;
            p.verticalAlign = VerticalAlign.MIDDLE;
            var result:Object = new RegExp(TAGS_PATTERN).exec(text);
            while(result != null)
            {
               if(result.index > 0)
               {
                  this.createSpan(p,text.substring(0,result.index),false);
               }
               this.createSpan(p,result[0],true);
               text = text.substring(result.index + result[0].length);
               result = new RegExp(TAGS_PATTERN).exec(text);
            }
            if(text.length > 0)
            {
               this.createSpan(p,text,false);
            }
            return p;
         }
         
         private function onDamage(pEvt:DamageEvent) : void {
            this._textFlow.removeEventListener(DamageEvent.DAMAGE,this.onDamage);
            this._isDamaged = true;
         }
         
         private function createLinkElement(p:ParagraphElement, oText:Object) : void {
            var att:String = null;
            var link:LinkElement = new LinkElement();
            link.addEventListener(FlowElementMouseEvent.CLICK,this.onTextClick);
            var span:SpanElement = new SpanElement();
            var style:String = "";
            var attributes:Array = oText[3].split(" ");
            for each (att in attributes)
            {
               if(att.search("href") != -1)
               {
                  link.href = this.getAttributeValue(att);
               }
               else
               {
                  if(att.search("style") != -1)
                  {
                     style = this.getAttributeValue(att);
                  }
               }
            }
            span.fontWeight = FontWeight.BOLD;
            span.color = this._TLFFormat.color;
            span = HtmlManager.formateSpan(span,style);
            span.text = oText[5].replace(BOLD_PATTERN,"").replace(UNDERLINE_PATTERN,"");
            link.addChild(span);
            p.addChild(link);
         }
         
         private function getAttributeValue(inText:String) : String {
            var realvalue:String = null;
            var tmp:Array = inText.split("=");
            tmp.shift();
            if(tmp.length > 1)
            {
               realvalue = tmp.join("=");
            }
            else
            {
               realvalue = tmp[0];
            }
            return realvalue.replace(QUOTE_PATTERN,"");
         }
         
         private function createSpan(p:ParagraphElement, sText:String, handleHtmlTags:Boolean, pStyle:String="") : void {
            var smiley:Smiley = null;
            var textToShow:String = null;
            var kamaIndex:* = 0;
            var reg:RegExp = null;
            var data:Object = null;
            var sub:String = null;
            var intValue:String = null;
            var cursor:int = 0;
            while(sText.length > 0)
            {
               smiley = this._smiliesActivated?this.getSmileyFromText(sText):null;
               textToShow = sText.substring(0,!(smiley == null)?smiley.position:sText.length);
               if((textToShow.length > 0) || (smiley == null))
               {
                  if(this._smiliesActivated)
                  {
                     kamaIndex = textToShow.search(KAMA_PATTERN);
                     while(kamaIndex != -1)
                     {
                        reg = new RegExp(KAMA_PATTERN);
                        data = reg.exec(textToShow);
                        sub = textToShow.substring(0,kamaIndex);
                        if(sub != "")
                        {
                           intValue = StringUtil.trim(data[1]);
                           if((intValue.indexOf(".") == -1) && (intValue.indexOf(",") == -1) && (intValue.indexOf(" ") == -1))
                           {
                              intValue = StringUtils.formateIntToString(parseInt(intValue));
                           }
                           p.addChild(this.createSpanElement(textToShow.substring(0,kamaIndex + 1) + intValue,pStyle));
                        }
                        p.addChild(this.createImage(new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_kama"),"/k"));
                        textToShow = textToShow.substr(kamaIndex + data[0].length);
                        kamaIndex = textToShow.search(KAMA_PATTERN);
                     }
                  }
                  if(!handleHtmlTags)
                  {
                     p.addChild(this.createSpanElement(textToShow,pStyle));
                  }
                  else
                  {
                     this.createSpanElementsFromHtmlTags(p,textToShow,pStyle);
                  }
                  if(smiley == null)
                  {
                     break;
                  }
               }
               if(smiley.position != -1)
               {
                  p.addChild(this.createImage(this._smiliesUri + smiley.pictoId + ".png",smiley.currentTrigger));
                  sText = sText.substring(smiley.position + smiley.currentTrigger.length);
               }
            }
         }
         
         private function createSpanElement(pText:String, pStyle:String) : SpanElement {
            var span:SpanElement = new SpanElement();
            var txt:String = pText;
            txt = StringUtil.replace(txt,"&amp;","&");
            txt = StringUtil.replace(txt,"&lt;","<");
            txt = StringUtil.replace(txt,"&gt;",">");
            span.text = txt;
            span = HtmlManager.formateSpan(span,pStyle);
            return span;
         }
         
         private function createSpanElementsFromHtmlTags(p:ParagraphElement, pText:String, pStyle:String) : void {
            var result:Object = null;
            var style:String = null;
            var attributes:Array = null;
            var att:String = null;
            result = new RegExp(TAGS_PATTERN).exec(pText);
            while(result != null)
            {
               if(result.index > 0)
               {
                  p.addChild(this.createSpanElement(pText.substring(0,result.index),pStyle));
               }
               switch(result[1])
               {
                  case "p":
                  case "span":
                     attributes = result[3].split(" ");
                     for each (att in attributes)
                     {
                        if(att.search("style") != -1)
                        {
                           style = this.getAttributeValue(att);
                        }
                     }
                     this.createSpan(p,result[5],true,style == ""?pStyle:style);
                     break;
                  case "a":
                     this.createLinkElement(p,result);
                     break;
                  case "i":
                     this.createSpanElementsFromHtmlTags(p,result[0].replace(ITALIC_PATTERN,""),HtmlManager.addValueToInlineStyle(pStyle,"font-style","italic"));
                     break;
                  case "b":
                     this.createSpanElementsFromHtmlTags(p,result[0].replace(BOLD_PATTERN,""),HtmlManager.addValueToInlineStyle(pStyle,"font-weight","bold"));
                     break;
                  case "u":
                     this.createSpanElementsFromHtmlTags(p,result[0].replace(UNDERLINE_PATTERN,""),HtmlManager.addValueToInlineStyle(pStyle,"text-decoration","underline"));
                     break;
               }
               pText = pText.substring(result.index + result[0].length);
               result = new RegExp(TAGS_PATTERN).exec(pText);
            }
            if(pText.length > 0)
            {
               p.addChild(this.createSpanElement(pText,pStyle));
            }
         }
         
         private var _bmpdtList:Dictionary;
         
         private function createImage(pUri:*, pTrigger:String) : InlineGraphicElement {
            var inlineGraphic:InlineGraphicElement = null;
            var imgTx:Texture = null;
            var bmpdt:BitmapData = null;
            var bmp:Bitmap = null;
            var loader:Loader = null;
            var flcomposer:IFlowComposer = null;
            var list:Dictionary = null;
            var ba:ByteArray = null;
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
                     loader.contentLoaderInfo.addEventListener(Event.COMPLETE,function(pEvt:Event):void
                     {
                        var bmp:Bitmap = loader.content as Bitmap;
                        inlineGraphic.source = bmp;
                        list[pUri] = bmp.bitmapData;
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
         
         private function getFile(uri:String) : ByteArray {
            var fs:FileStream = null;
            var ba:ByteArray = null;
            var f:File = new File(uri);
            if(f.exists)
            {
               fs = new FileStream();
               fs.open(f,FileMode.READ);
               ba = new ByteArray();
               fs.readBytes(ba);
               fs.close();
               return ba;
            }
            return null;
         }
         
         public function getLastParagrapheElement() : ParagraphElement {
            return this._textFlow.getChildAt(this._textFlow.numChildren - 1) as ParagraphElement;
         }
         
         public function insertParagraphes(data:Array) : void {
            var p:ParagraphElement = null;
            for each (p in data)
            {
               p.fontSize = this._TLFFormat.fontSize;
               this._textFlow.addChild(p);
            }
            this._isDamaged = true;
            this.scrollV = this.maxScrollV;
            this.updateScrollBar();
         }
         
         private function getSmileyFromText(sTxt:String) : Smiley {
            var indexOfSmiley:* = 0;
            var currentSmiley:Smiley = null;
            var smiley:Smiley = null;
            var trigger:String = null;
            for each (smiley in this._smilies)
            {
               for each (trigger in smiley.triggers)
               {
                  if(trigger != null)
                  {
                     indexOfSmiley = sTxt.toLowerCase().indexOf(trigger.toLowerCase());
                     if(indexOfSmiley != -1)
                     {
                        if(isValidSmiley(sTxt,indexOfSmiley,trigger))
                        {
                           if((currentSmiley == null) || (!(currentSmiley == null)) && (currentSmiley.position > indexOfSmiley))
                           {
                              smiley.position = indexOfSmiley;
                              smiley.currentTrigger = trigger;
                              currentSmiley = smiley;
                           }
                        }
                     }
                  }
               }
            }
            return currentSmiley;
         }
      }
   }
   import __AS3__.vec.Vector;
   
   class Smiley extends Object
   {
      
      function Smiley(pId:String) {
         super();
         this.pictoId = pId;
         this.position = -1;
      }
      
      public var pictoId:String;
      
      public var triggers:Vector.<String>;
      
      public var position:int;
      
      public var currentTrigger:String;
   }
