package com.ankamagames.berilia.components
{
    import __AS3__.vec.*;
    import com.adobe.utils.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.events.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
    import flashx.textLayout.edit.*;
    import flashx.textLayout.elements.*;
    import flashx.textLayout.events.*;
    import flashx.textLayout.formats.*;

    public class ChatComponent extends GraphicContainer implements UIComponent, IRectangle, FinalizableUIComponent
    {
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
        private var _isDamaged:Boolean = false;
        private var _currentSelection:String = "";
        private var _magicbool:Boolean = true;
        private var _bmpdtList:Dictionary;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatComponent));
        public static var KAMA_PATTERN:RegExp = /(?:\s|^)([0-9.,\s]+\s?)\/k(?=\W|$)""(?:\s|^)([0-9.,\s]+\s?)\/k(?=\W|$)/gi;
        public static var TAGS_PATTERN:RegExp = /<([a-zA-Z]+)(>|(\s*([^>]*)+)>)(.*?)<\/\1>""<([a-zA-Z]+)(>|(\s*([^>]*)+)>)(.*?)<\/\1>/gi;
        public static var QUOTE_PATTERN:RegExp = /(''|"")""('|")/gi;
        public static var BOLD_PATTERN:RegExp = /<\/?b>""<\/?b>/gi;
        public static var UNDERLINE_PATTERN:RegExp = /<\/?u>""<\/?u>/gi;
        public static var ITALIC_PATTERN:RegExp = /<\/?i>""<\/?i>/gi;
        private static var IMAGE_SIZE:int = 20;
        public static var LINE_HEIGHT:int = 20;

        public function ChatComponent()
        {
            this._bmpdtList = new Dictionary();
            this._sbScrollBar = new ScrollBar();
            this._sbScrollBar.min = 1;
            this._sbScrollBar.max = 1;
            this._sbScrollBar.step = 1;
            this._sbScrollBar.scrollSpeed = 1 / 6;
            this._sbScrollBar.addEventListener(Event.CHANGE, this.onScroll);
            addChild(this._sbScrollBar);
            this._aStyleObj = new Array();
            this._cssApplied = false;
            this.createTextField();
            return;
        }// end function

        override public function remove() : void
        {
            super.remove();
            return;
        }// end function

        public function initSmileyTab(param1:String, param2:Object) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            this._smiliesUri = param1;
            this._smilies = new Vector.<Smiley>;
            for each (_loc_3 in param2)
            {
                
                if (_loc_3.triggers != null && _loc_3.triggers.length > 0)
                {
                    _loc_4 = new Smiley(_loc_3.gfxId);
                    _loc_4.triggers = new Vector.<String>(_loc_3.triggers.length);
                    _loc_6 = _loc_3.triggers.length;
                    _loc_5 = 0;
                    while (_loc_5 < _loc_6)
                    {
                        
                        _loc_7 = _loc_3.triggers[_loc_5];
                        _loc_7 = StringUtil.replace(_loc_7, "&", "&amp;");
                        _loc_7 = StringUtil.replace(_loc_7, "<", "&lt;");
                        _loc_7 = StringUtil.replace(_loc_7, ">", "&gt;");
                        _loc_4.triggers[_loc_5] = _loc_7;
                        _loc_5++;
                    }
                    this._smilies.push(_loc_4);
                }
            }
            return;
        }// end function

        public function clearText() : void
        {
            var _loc_1:* = null;
            while (this._textFlow.numChildren > 0)
            {
                
                this.removeFirstLine();
            }
            this._isDamaged = true;
            this.updateScrollBar(true);
            return;
        }// end function

        public function removeFirstLine() : void
        {
            if (this._textFlow.numChildren > 0)
            {
                this._textFlow.removeChildAt(0);
            }
            return;
        }// end function

        public function removeLines(param1:int) : void
        {
            var _loc_2:* = 0;
            _loc_2 = 0;
            while (_loc_2 < param1)
            {
                
                this.removeFirstLine();
                _loc_2++;
            }
            this._isDamaged = true;
            return;
        }// end function

        public function get smiliesActivated() : Boolean
        {
            return this._smiliesActivated;
        }// end function

        public function set smiliesActivated(param1:Boolean) : void
        {
            this._smiliesActivated = param1;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            param1 = param1 - this._sbScrollBar.width;
            super.width = param1;
            this._controller.setCompositionSize(param1, this._controller.compositionHeight);
            this._isDamaged = true;
            if (this._finalized)
            {
                this.updateScrollBarPos();
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            if (param1 != super.height || param1 != this._sbScrollBar.height - this._scrollTopMargin - this._scrollBottomMargin)
            {
                param1 = param1 + 2;
                super.height = param1;
                this._sbScrollBar.height = param1 - this._scrollTopMargin - this._scrollBottomMargin;
                this._controller.setCompositionSize(this._controller.compositionWidth, param1);
                this._isDamaged = true;
                if (this._finalized)
                {
                    this.updateScrollBar();
                }
            }
            return;
        }// end function

        public function set scrollPos(param1:int) : void
        {
            this._nScrollPos = param1;
            return;
        }// end function

        public function get scrollBottomMargin() : int
        {
            return this._scrollBottomMargin;
        }// end function

        public function set scrollBottomMargin(param1:int) : void
        {
            this._scrollBottomMargin = param1;
            this._sbScrollBar.height = this._controller.compositionHeight - this._scrollTopMargin - this._scrollBottomMargin;
            return;
        }// end function

        public function get scrollTopMargin() : int
        {
            return this._scrollTopMargin;
        }// end function

        public function set scrollTopMargin(param1:int) : void
        {
            this._scrollTopMargin = param1;
            this._sbScrollBar.y = this._scrollTopMargin;
            this._sbScrollBar.height = this._controller.compositionHeight - this._scrollTopMargin - this._scrollBottomMargin;
            return;
        }// end function

        public function appendText(param1:String, param2:String = null, param3:Boolean = true) : ParagraphElement
        {
            FpsManager.getInstance().startTracking("chat", 4972530);
            if (param2 && this._aStyleObj[param2])
            {
                this._TLFFormat = this._ssSheet.TLFTransform(this._aStyleObj[param2]);
            }
            param1 = HyperlinkFactory.decode(param1);
            var _loc_4:* = this.createParagraphe(param1);
            if (param3)
            {
                this._textFlow.addChild(_loc_4);
                this._isDamaged = true;
                if (this._finalized)
                {
                    this.updateScrollBar();
                }
            }
            FpsManager.getInstance().stopTracking("chat");
            return _loc_4;
        }// end function

        public function set css(param1:Uri) : void
        {
            this._cssApplied = false;
            this.applyCSS(param1);
            return;
        }// end function

        public function applyCSS(param1:Uri) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (param1 != this._sCssUrl)
            {
                this._sCssUrl = param1;
                CssManager.getInstance().askCss(param1.uri, new Callback(this.bindCss));
            }
            return;
        }// end function

        public function set cssClass(param1:String) : void
        {
            this._sCssClass = param1 == "" ? ("p") : (param1);
            this.bindCss();
            return;
        }// end function

        private function bindCss() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_1:* = this._ssSheet;
            this._ssSheet = CssManager.getInstance().getCss(this._sCssUrl.uri);
            for each (_loc_3 in this._ssSheet.styleNames)
            {
                
                if (!_loc_2 || _loc_3 == this._sCssClass || this._sCssClass != _loc_2 && _loc_3 == "p")
                {
                    _loc_2 = _loc_3;
                }
                if (this._ssSheet != _loc_1 || !this._aStyleObj[_loc_3])
                {
                    this._aStyleObj[_loc_3] = this._ssSheet.getStyle(_loc_3);
                }
            }
            this._TLFFormat = this._ssSheet.TLFTransform(this._aStyleObj[_loc_2]);
            return;
        }// end function

        public function setCssColor(param1:String, param2:String = null) : void
        {
            this.changeCssClassColor(param1, param2);
            return;
        }// end function

        public function setCssSize(param1:uint, param2:uint, param3:String = null) : void
        {
            this.changeCssClassSize(param1, param2, param3);
            return;
        }// end function

        private function changeCssClassSize(param1:uint, param2:uint, param3:String = null) : void
        {
            var _loc_4:* = undefined;
            if (param3)
            {
                this._aStyleObj[param3].fontSize = param1 + "px";
            }
            else
            {
                for each (_loc_4 in this._aStyleObj)
                {
                    
                    _loc_4.fontSize = param1 + "px";
                }
            }
            this.bindCss();
            this._textFlow.lineHeight = param2;
            return;
        }// end function

        private function changeCssClassColor(param1:String, param2:String = null) : void
        {
            var _loc_3:* = undefined;
            if (param2)
            {
                if (this._aStyleObj[param2] == null)
                {
                    this._aStyleObj[param2] = new Object();
                }
                this._aStyleObj[param2].color = param1;
                this._TLFFormat.concat(this._ssSheet.TLFTransform(this._aStyleObj[param2]));
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

        public function get scrollV() : int
        {
            return Math.round((this._controller.verticalScrollPosition + this._controller.compositionHeight) / this._textFlow.lineHeight);
        }// end function

        public function set scrollV(param1:int) : void
        {
            this._controller.verticalScrollPosition = param1 * this._textFlow.lineHeight - this._controller.compositionHeight;
            return;
        }// end function

        public function get maxScrollV() : int
        {
            this._textFlow.flowComposer.composeToPosition();
            return this._textFlow.flowComposer.numLines;
        }// end function

        public function get textHeight() : Number
        {
            var _loc_3:* = 0;
            var _loc_1:* = 0;
            var _loc_2:* = this._textFlow.numChildren;
            _loc_3 = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_1 = _loc_1 + this.getParagraphHeight(this._textFlow.getChildAt(_loc_3) as ParagraphElement);
                _loc_3++;
            }
            return _loc_1;
        }// end function

        private function getParagraphHeight(param1:ParagraphElement) : Number
        {
            var _loc_5:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = param1.getAbsoluteStart();
            var _loc_4:* = _loc_3 + param1.textLength;
            while (_loc_3 < _loc_4)
            {
                
                _loc_5 = param1.getTextFlow().flowComposer.findLineAtPosition(_loc_3);
                _loc_2 = _loc_2 + _loc_5.height;
                _loc_3 = _loc_3 + _loc_5.textLength;
            }
            return _loc_2;
        }// end function

        public function set scrollCss(param1:Uri) : void
        {
            this._sbScrollBar.css = param1;
            return;
        }// end function

        public function get scrollCss() : Uri
        {
            return this._sbScrollBar.css;
        }// end function

        private function createTextField() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = new TextLayoutFormat();
            _loc_1.fontWeight = FontWeight.BOLD;
            _loc_1.color = "#ff0000";
            _loc_1.textDecoration = TextDecoration.NONE;
            _loc_2 = new Configuration();
            _loc_2.defaultLinkNormalFormat = _loc_1;
            TextFlow.defaultConfiguration = _loc_2;
            this._textContainer = new ChatTextContainer();
            this._textContainer.x = this._sbScrollBar.width;
            addChild(this._textContainer);
            this._textFlow = new TextFlow(_loc_2);
            this._textFlow.paddingBottom = 2;
            this._textFlow.flowComposer = new StandardFlowComposer();
            this._controller = new ContainerController(this._textContainer, width, height);
            this._controller.horizontalScrollPolicy = ScrollPolicy.ON;
            this._controller.blockProgression = BlockProgression.TB;
            this._textFlow.interactionManager = new SelectionManager();
            this._textFlow.addEventListener(FlowElementMouseEvent.ROLL_OVER, this.onMouseOverLink);
            this._textFlow.addEventListener(FlowElementMouseEvent.ROLL_OUT, this.onMouseOutLink);
            this._textFlow.addEventListener(SelectionEvent.SELECTION_CHANGE, this.selectionChanged);
            this._textContainer.addEventListener(MouseEvent.ROLL_OUT, this.onRollOutChat);
            this._textFlow.addEventListener(TextLayoutEvent.SCROLL, this.scrollTextFlow);
            this._textFlow.flowComposer.addController(this._controller);
            this._textFlow.flowComposer.updateAllControllers();
            EnterFrameDispatcher.addEventListener(this.onEnterFrame, "updateChatControllers");
            return;
        }// end function

        private function onEnterFrame(event:Event) : void
        {
            if (this._isDamaged)
            {
                this._isDamaged = false;
                this._textFlow.flowComposer.updateAllControllers();
            }
            return;
        }// end function

        private function onRollOutChat(event:MouseEvent) : void
        {
            TooltipManager.hideAll();
            return;
        }// end function

        private function selectionChanged(event:SelectionEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = event.selectionState ? (ElementRange.createElementRange(event.selectionState.textFlow, event.selectionState.absoluteStart, event.selectionState.absoluteEnd)) : (null);
            this._currentSelection = "";
            var _loc_4:* = _loc_2.firstLeaf;
            do
            {
                
                if (_loc_3 != null && _loc_3 != _loc_4.getParagraph())
                {
                    this._currentSelection = this._currentSelection + "\n";
                    _loc_3 = _loc_4.getParagraph();
                }
                this._currentSelection = this._currentSelection + _loc_4.text;
                var _loc_5:* = _loc_4.getNextLeaf();
                _loc_4 = _loc_4.getNextLeaf();
            }while (_loc_5)
            return;
        }// end function

        private function onMouseOverLink(event:FlowElementMouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            if (event.flowElement is LinkElement)
            {
                _loc_2 = event.flowElement as LinkElement;
                _loc_3 = _loc_2.href.replace("event:", "").split(",");
                _loc_4 = _loc_3.shift();
                _loc_5 = _loc_4 + "," + Math.round(event.originalEvent.stageX) + "," + Math.round(event.originalEvent.stageY) + "," + _loc_3.join(",");
                dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OVER, _loc_5));
            }
            return;
        }// end function

        private function onMouseOutLink(event:FlowElementMouseEvent) : void
        {
            TooltipManager.hideAll();
            dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OUT));
            return;
        }// end function

        private function onTextClick(event:FlowElementMouseEvent) : void
        {
            TooltipManager.hideAll();
            var _loc_2:* = (event.flowElement as LinkElement).href;
            if (_loc_2 != "")
            {
                dispatchEvent(new TextEvent(TextEvent.LINK, false, false, _loc_2.replace("event:", "")));
            }
            return;
        }// end function

        private function onScroll(event:Event) : void
        {
            this._magicbool = false;
            this._controller.verticalScrollPosition = this._sbScrollBar.value / this._sbScrollBar.max * this.maxScrollV * this._textFlow.lineHeight - this._controller.compositionHeight;
            return;
        }// end function

        private function scrollTextFlow(event:Event) : void
        {
            var _loc_2:* = null;
            if (event is ScrollEvent)
            {
                _loc_2 = event as ScrollEvent;
                if (this._magicbool)
                {
                    _loc_2.delta = _loc_2.delta / 3 * -1;
                    this._sbScrollBar.onWheel(event, false);
                }
                else
                {
                    this._magicbool = true;
                }
            }
            return;
        }// end function

        private function updateScrollBar(param1:Boolean = false) : void
        {
            this._sbScrollBar.visible = true;
            this._sbScrollBar.disabled = false;
            this._sbScrollBar.total = this.maxScrollV;
            this._sbScrollBar.max = this.maxScrollV - Math.floor(this._controller.compositionHeight / this._textFlow.lineHeight);
            if (param1)
            {
                this._controller.verticalScrollPosition = 0;
                this._sbScrollBar.value = 0;
            }
            else
            {
                this._sbScrollBar.value = this.scrollV;
            }
            return;
        }// end function

        private function updateScrollBarPos() : void
        {
            if (this._nScrollPos >= 0)
            {
                this._sbScrollBar.x = this._controller.compositionWidth - this._sbScrollBar.width;
            }
            else
            {
                this._sbScrollBar.x = 0;
            }
            return;
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

        public function finalize() : void
        {
            this._sbScrollBar.finalize();
            this.updateScrollBarPos();
            this.updateScrollBar();
            HyperlinkFactory.createTextClickHandler(this);
            HyperlinkFactory.createRollOverHandler(this);
            this._finalized = true;
            var _loc_1:* = getUi();
            if (_loc_1 != null)
            {
                _loc_1.iAmFinalized(this);
            }
            return;
        }// end function

        private function createParagraphe(param1:String) : ParagraphElement
        {
            this._textFlow.addEventListener(DamageEvent.DAMAGE, this.onDamage);
            var _loc_2:* = new ParagraphElement();
            _loc_2.format = this._TLFFormat;
            _loc_2.verticalAlign = VerticalAlign.MIDDLE;
            var _loc_3:* = new RegExp(TAGS_PATTERN).exec(param1);
            while (_loc_3 != null)
            {
                
                if (_loc_3.index > 0)
                {
                    this.createSpan(_loc_2, param1.substring(0, _loc_3.index), false);
                }
                this.createSpan(_loc_2, _loc_3[0], true);
                param1 = param1.substring(_loc_3.index + _loc_3[0].length);
                _loc_3 = new RegExp(TAGS_PATTERN).exec(param1);
            }
            if (param1.length > 0)
            {
                this.createSpan(_loc_2, param1, false);
            }
            return _loc_2;
        }// end function

        private function onDamage(event:DamageEvent) : void
        {
            this._textFlow.removeEventListener(DamageEvent.DAMAGE, this.onDamage);
            this._isDamaged = true;
            return;
        }// end function

        private function createLinkElement(param1:ParagraphElement, param2:Object) : void
        {
            var _loc_7:* = null;
            var _loc_3:* = new LinkElement();
            _loc_3.addEventListener(FlowElementMouseEvent.CLICK, this.onTextClick);
            var _loc_4:* = new SpanElement();
            var _loc_5:* = "";
            var _loc_6:* = param2[3].split(" ");
            for each (_loc_7 in _loc_6)
            {
                
                if (_loc_7.search("href") != -1)
                {
                    _loc_3.href = this.getAttributeValue(_loc_7);
                    continue;
                }
                if (_loc_7.search("style") != -1)
                {
                    _loc_5 = this.getAttributeValue(_loc_7);
                }
            }
            _loc_4.fontWeight = FontWeight.BOLD;
            _loc_4.color = this._TLFFormat.color;
            _loc_4 = HtmlManager.formateSpan(_loc_4, _loc_5);
            _loc_4.text = param2[5].replace(BOLD_PATTERN, "").replace(UNDERLINE_PATTERN, "");
            _loc_3.addChild(_loc_4);
            param1.addChild(_loc_3);
            return;
        }// end function

        private function getAttributeValue(param1:String) : String
        {
            var _loc_3:* = null;
            var _loc_2:* = param1.split("=");
            _loc_2.shift();
            if (_loc_2.length > 1)
            {
                _loc_3 = _loc_2.join("=");
            }
            else
            {
                _loc_3 = _loc_2[0];
            }
            return _loc_3.replace(QUOTE_PATTERN, "");
        }// end function

        private function createSpan(param1:ParagraphElement, param2:String, param3:Boolean, param4:String = "") : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_5:* = 0;
            while (param2.length > 0)
            {
                
                _loc_6 = this._smiliesActivated ? (this.getSmileyFromText(param2)) : (null);
                _loc_7 = param2.substring(0, _loc_6 != null ? (_loc_6.position) : (param2.length));
                if (_loc_7.length > 0 || _loc_6 == null)
                {
                    if (this._smiliesActivated)
                    {
                        _loc_8 = _loc_7.search(KAMA_PATTERN);
                        while (_loc_8 != -1)
                        {
                            
                            _loc_9 = new RegExp(KAMA_PATTERN);
                            _loc_10 = _loc_9.exec(_loc_7);
                            _loc_11 = _loc_7.substring(0, _loc_8);
                            if (_loc_11 != "")
                            {
                                _loc_12 = StringUtil.trim(_loc_10[1]);
                                if (_loc_12.indexOf(".") == -1 && _loc_12.indexOf(",") == -1 && _loc_12.indexOf(" ") == -1)
                                {
                                    _loc_12 = StringUtils.formateIntToString(parseInt(_loc_12));
                                }
                                param1.addChild(this.createSpanElement(_loc_7.substring(0, (_loc_8 + 1)) + _loc_12, param4));
                            }
                            param1.addChild(this.createImage(new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "assets.swf|tx_kama"), "/k"));
                            _loc_7 = _loc_7.substr(_loc_8 + _loc_10[0].length);
                            _loc_8 = _loc_7.search(KAMA_PATTERN);
                        }
                    }
                    if (!param3)
                    {
                        param1.addChild(this.createSpanElement(_loc_7, param4));
                    }
                    else
                    {
                        this.createSpanElementsFromHtmlTags(param1, _loc_7, param4);
                    }
                    if (_loc_6 == null)
                    {
                        break;
                    }
                }
                if (_loc_6.position != -1)
                {
                    param1.addChild(this.createImage(this._smiliesUri + _loc_6.pictoId + ".png", _loc_6.currentTrigger));
                    param2 = param2.substring(_loc_6.position + _loc_6.currentTrigger.length);
                }
            }
            return;
        }// end function

        private function createSpanElement(param1:String, param2:String) : SpanElement
        {
            var _loc_3:* = new SpanElement();
            var _loc_4:* = param1;
            _loc_4 = StringUtil.replace(_loc_4, "&amp;", "&");
            _loc_4 = StringUtil.replace(_loc_4, "&lt;", "<");
            _loc_4 = StringUtil.replace(_loc_4, "&gt;", ">");
            _loc_3.text = _loc_4;
            _loc_3 = HtmlManager.formateSpan(_loc_3, param2);
            return _loc_3;
        }// end function

        private function createSpanElementsFromHtmlTags(param1:ParagraphElement, param2:String, param3:String) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            _loc_4 = new RegExp(TAGS_PATTERN).exec(param2);
            while (_loc_4 != null)
            {
                
                if (_loc_4.index > 0)
                {
                    param1.addChild(this.createSpanElement(param2.substring(0, _loc_4.index), param3));
                }
                switch(_loc_4[1])
                {
                    case "p":
                    case "span":
                    {
                        _loc_6 = _loc_4[3].split(" ");
                        for each (_loc_7 in _loc_6)
                        {
                            
                            if (_loc_7.search("style") != -1)
                            {
                                _loc_5 = this.getAttributeValue(_loc_7);
                            }
                        }
                        this.createSpan(param1, _loc_4[5], true, _loc_5 == "" ? (param3) : (_loc_5));
                        break;
                    }
                    case "a":
                    {
                        this.createLinkElement(param1, _loc_4);
                        break;
                    }
                    case "i":
                    {
                        this.createSpanElementsFromHtmlTags(param1, _loc_4[0].replace(ITALIC_PATTERN, ""), HtmlManager.addValueToInlineStyle(param3, "font-style", "italic"));
                        break;
                    }
                    case "b":
                    {
                        this.createSpanElementsFromHtmlTags(param1, _loc_4[0].replace(BOLD_PATTERN, ""), HtmlManager.addValueToInlineStyle(param3, "font-weight", "bold"));
                        break;
                    }
                    case "u":
                    {
                        this.createSpanElementsFromHtmlTags(param1, _loc_4[0].replace(UNDERLINE_PATTERN, ""), HtmlManager.addValueToInlineStyle(param3, "text-decoration", "underline"));
                        break;
                    }
                    default:
                    {
                        trace("On fait rien: " + _loc_4[1] + " " + _loc_4[0]);
                        break;
                        break;
                    }
                }
                param2 = param2.substring(_loc_4.index + _loc_4[0].length);
                _loc_4 = new RegExp(TAGS_PATTERN).exec(param2);
            }
            if (param2.length > 0)
            {
                param1.addChild(this.createSpanElement(param2, param3));
            }
            return;
        }// end function

        private function createImage(param1, param2:String) : InlineGraphicElement
        {
            var inlineGraphic:InlineGraphicElement;
            var imgTx:Texture;
            var bmpdt:BitmapData;
            var bmp:Bitmap;
            var loader:Loader;
            var flcomposer:IFlowComposer;
            var list:Dictionary;
            var ba:ByteArray;
            var pUri:* = param1;
            var pTrigger:* = param2;
            inlineGraphic = new InlineGraphicElement(pTrigger);
            inlineGraphic.alignmentBaseline = TextBaseline.DESCENT;
            if (pUri is Uri)
            {
                imgTx = new Texture();
                imgTx.uri = pUri;
                imgTx.finalize();
                inlineGraphic.source = imgTx;
            }
            else if (pUri is String)
            {
                if (this._bmpdtList[pUri] != null)
                {
                    bmpdt = this._bmpdtList[pUri];
                    bmp = new Bitmap(bmpdt.clone(), "auto", true);
                    inlineGraphic.source = bmp;
                }
                else
                {
                    loader = new Loader();
                    flcomposer = this._textFlow.flowComposer;
                    list = this._bmpdtList;
                    loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event) : void
            {
                var _loc_2:* = loader.content as Bitmap;
                inlineGraphic.source = _loc_2;
                list[pUri] = _loc_2.bitmapData;
                _isDamaged = true;
                return;
            }// end function
            );
                    ba = this.getFile(pUri);
                    if (ba)
                    {
                        loader.loadBytes(ba);
                    }
                }
            }
            return inlineGraphic;
        }// end function

        private function getFile(param1:String) : ByteArray
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = new File(param1);
            if (_loc_2.exists)
            {
                _loc_3 = new FileStream();
                _loc_3.open(_loc_2, FileMode.READ);
                _loc_4 = new ByteArray();
                _loc_3.readBytes(_loc_4);
                _loc_3.close();
                return _loc_4;
            }
            return null;
        }// end function

        public function getLastParagrapheElement() : ParagraphElement
        {
            return this._textFlow.getChildAt((this._textFlow.numChildren - 1)) as ParagraphElement;
        }// end function

        public function insertParagraphes(param1:Array) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in param1)
            {
                
                _loc_2.fontSize = this._TLFFormat.fontSize;
                this._textFlow.addChild(_loc_2);
            }
            this._isDamaged = true;
            this.scrollV = this.maxScrollV;
            this.updateScrollBar();
            return;
        }// end function

        private function getSmileyFromText(param1:String) : Smiley
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            for each (_loc_4 in this._smilies)
            {
                
                for each (_loc_5 in _loc_4.triggers)
                {
                    
                    if (_loc_5 == null)
                    {
                        continue;
                    }
                    _loc_2 = param1.toLowerCase().indexOf(_loc_5.toLowerCase());
                    if (_loc_2 != -1)
                    {
                        if (isValidSmiley(param1, _loc_2, _loc_5))
                        {
                            if (_loc_3 == null || _loc_3 != null && _loc_3.position > _loc_2)
                            {
                                _loc_4.position = _loc_2;
                                _loc_4.currentTrigger = _loc_5;
                                _loc_3 = _loc_4;
                            }
                        }
                    }
                }
            }
            return _loc_3;
        }// end function

        public static function supprSpace(param1:String) : String
        {
            var _loc_2:* = /_""_/g;
            return param1;
        }// end function

        public static function isValidSmiley(param1:String, param2:int, param3:String) : Boolean
        {
            if (param2 == 0 && param1.length == param3.length || param2 > 0 && param1.length == param2 + param3.length && param1.charAt((param2 - 1)) == " " || param2 == 0 && param1.length > param3.length && param1.charAt(param2 + param3.length) == " " || param2 > 0 && param2 + param3.length < param1.length && param1.charAt((param2 - 1)) == " " && param1.charAt(param2 + param3.length) == " ")
            {
                return true;
            }
            return false;
        }// end function

    }
}

import __AS3__.vec.*;

import com.adobe.utils.*;

import com.ankamagames.berilia.*;

import com.ankamagames.berilia.events.*;

import com.ankamagames.berilia.factories.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.data.*;

import com.ankamagames.berilia.types.graphic.*;

import com.ankamagames.jerakine.data.*;

import com.ankamagames.jerakine.interfaces.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.benchmark.monitoring.*;

import com.ankamagames.jerakine.utils.display.*;

import com.ankamagames.jerakine.utils.misc.*;

import flash.display.*;

import flash.events.*;

import flash.filesystem.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.compose.*;

import flashx.textLayout.container.*;

import flashx.textLayout.edit.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.events.*;

import flashx.textLayout.formats.*;

class Smiley extends Object
{
    public var pictoId:String;
    public var triggers:Vector.<String>;
    public var position:int;
    public var currentTrigger:String;

    function Smiley(param1:String) : void
    {
        this.pictoId = param1;
        this.position = -1;
        return;
    }// end function

}

