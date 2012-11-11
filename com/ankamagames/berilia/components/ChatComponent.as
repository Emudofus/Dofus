package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.factories.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.types.tooltip.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.benchmark.monitoring.*;
    import com.ankamagames.jerakine.utils.misc.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.engine.*;
    import flash.utils.*;
    import flashx.textLayout.compose.*;
    import flashx.textLayout.container.*;
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
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatComponent));
        public static var KAMA_PATTERN:RegExp = /[0-9]{1,}\s?k""[0-9]{1,}\s?k/gi;
        public static var TAGS_PATTERN:RegExp = /<([a-zA-Z]+)(>|(\s*([^>]*)+)>)(.*?)<\/\1>""<([a-zA-Z]+)(>|(\s*([^>]*)+)>)(.*?)<\/\1>/gi;
        public static var QUOTE_PATTERN:RegExp = /(''|"")""('|")/gi;
        public static var BOLD_PATTERN:RegExp = /<\/?b>""<\/?b>/gi;
        private static const SMILIES:Array = [":)", ":("];

        public function ChatComponent()
        {
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

        public function clearText() : void
        {
            var _loc_1:* = null;
            while (this._textFlow.numChildren > 0)
            {
                
                _loc_1 = this._textFlow.getChildAt(0) as ParagraphElement;
                this._textFlow.removeChild(_loc_1);
                _loc_1 = null;
            }
            this._textFlow.flowComposer.updateAllControllers();
            return;
        }// end function

        public function removeLine() : void
        {
            var _loc_1:* = this._textFlow.getChildAt(0) as ParagraphElement;
            this._textFlow.removeChild(_loc_1);
            _loc_1 = null;
            return;
        }// end function

        override public function set width(param1:Number) : void
        {
            param1 = param1 - this._sbScrollBar.width;
            super.width = param1;
            this._controller.setCompositionSize(param1, this._controller.compositionHeight);
            this._textFlow.flowComposer.updateAllControllers();
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
                super.height = param1;
                this._sbScrollBar.height = param1 - this._scrollTopMargin - this._scrollBottomMargin;
                this._controller.setCompositionSize(this._controller.compositionWidth, param1);
                this._textFlow.flowComposer.updateAllControllers();
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
            this._sbScrollBar.height = height - this._scrollTopMargin - this._scrollBottomMargin;
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
            this._sbScrollBar.height = height - this._scrollTopMargin - this._scrollBottomMargin;
            return;
        }// end function

        public function appendText(param1:String, param2:String = null) : void
        {
            _log.debug("Chat children: " + this._textFlow.numChildren);
            _log.debug("Size: " + this._controller.compositionWidth + " - " + this._controller.compositionHeight);
            FpsManager.getInstance().startTracking("chat", 4972530);
            Chrono.start("appendText");
            if (param2 && this._aStyleObj[param2])
            {
                this._TLFFormat = this._ssSheet.TLFTransform(this._aStyleObj[param2]);
            }
            param1 = HyperlinkFactory.decode(param1);
            Chrono.start("createParagraphe");
            this.createParagraphe(param1);
            Chrono.stop();
            Chrono.start("updatecontrollers");
            this._textFlow.flowComposer.updateAllControllers();
            Chrono.stop();
            if (this._finalized)
            {
                Chrono.start("updateScrollbar");
                this.updateScrollBar();
                Chrono.stop();
            }
            Chrono.stop();
            FpsManager.getInstance().stopTracking("chat");
            return;
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

        public function setCssSize(param1:uint, param2:String = null) : void
        {
            this.changeCssClassSize(param1, param2);
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

        private function changeCssClassColor(param1:String, param2:String = null) : void
        {
            var _loc_3:* = undefined;
            if (param2)
            {
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
            return this._controller.verticalScrollPosition;
        }// end function

        public function set scrollV(param1:int) : void
        {
            this._controller.verticalScrollPosition = this.textHeight;
            return;
        }// end function

        public function get maxScrollV() : int
        {
            return this.textHeight;
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
            var _loc_1:* = new TextLayoutFormat();
            _loc_1.fontWeight = FontWeight.BOLD;
            _loc_1.color = "#ff0000";
            _loc_1.textDecoration = TextDecoration.NONE;
            var _loc_2:* = TextFlow.defaultConfiguration;
            _loc_2.defaultLinkNormalFormat = _loc_1;
            this._textContainer = new Sprite();
            this._textContainer.x = this._sbScrollBar.width;
            addChild(this._textContainer);
            this._textFlow = new TextFlow(_loc_2);
            this._controller = new ContainerController(this._textContainer, width, height);
            this._controller.horizontalScrollPolicy = ScrollPolicy.OFF;
            this._textFlow.addEventListener(FlowElementMouseEvent.ROLL_OVER, this.onMouseOver);
            this._textFlow.addEventListener(FlowElementMouseEvent.ROLL_OUT, this.onMouseOut);
            this._textFlow.flowComposer.addController(this._controller);
            this._textFlow.flowComposer.updateAllControllers();
            return;
        }// end function

        private function onMouseOver(event:FlowElementMouseEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (event.flowElement is LinkElement)
            {
                _loc_2 = event.flowElement as LinkElement;
                _loc_3 = new TooltipRectangle(event.originalEvent.stageX, event.originalEvent.stageY, 0, 0);
            }
            return;
        }// end function

        private function onMouseOut(event:FlowElementMouseEvent) : void
        {
            TooltipManager.hideAll();
            return;
        }// end function

        private function onTextClick(event:FlowElementMouseEvent) : void
        {
            TooltipManager.hideAll();
            var _loc_2:* = (event.flowElement as LinkElement).href;
            if (_loc_2 != "")
            {
                Berilia.getInstance().handler.process(new TextClickMessage(this, _loc_2));
            }
            return;
        }// end function

        private function onScroll(event:Event) : void
        {
            this._controller.verticalScrollPosition = this._sbScrollBar.value / this._sbScrollBar.max * this.maxScrollV;
            return;
        }// end function

        private function updateScrollBar(param1:Boolean = false) : void
        {
            this._sbScrollBar.visible = true;
            this._sbScrollBar.disabled = false;
            this._sbScrollBar.total = this._textFlow.flowComposer.numLines;
            this._sbScrollBar.max = this.maxScrollV;
            if (param1)
            {
                this._controller.verticalScrollPosition = 0;
                this._sbScrollBar.value = 0;
            }
            else
            {
                this._sbScrollBar.value = this._controller.verticalScrollPosition;
            }
            return;
        }// end function

        private function updateScrollBarPos() : void
        {
            if (this._nScrollPos >= 0)
            {
                this._sbScrollBar.x = width - this._sbScrollBar.width;
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
            this._finalized = true;
            return;
        }// end function

        private function createParagraphe(param1:String) : void
        {
            var _loc_2:* = new ParagraphElement();
            _loc_2.format = this._TLFFormat;
            this._textFlow.addChild(_loc_2);
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
            return;
        }// end function

        private function createLinkElement(param1:ParagraphElement, param2:Object) : void
        {
            var _loc_7:* = null;
            var _loc_3:* = new LinkElement();
            _loc_3.addEventListener(MouseEvent.CLICK, this.onTextClick);
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
            _loc_4.text = param2[5].replace(BOLD_PATTERN, "");
            _loc_3.addChild(_loc_4);
            param1.addChild(_loc_3);
            return;
        }// end function

        private function getAttributeValue(param1:String) : String
        {
            var _loc_2:* = param1.split("=")[1];
            return _loc_2.replace(QUOTE_PATTERN, "");
        }// end function

        private function createSpan(param1:ParagraphElement, param2:String, param3:Boolean, param4:String = "") : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_5:* = 0;
            while (param2.length > 0)
            {
                
                _loc_6 = this.getSmileyFromText(param2);
                _loc_7 = param2.substring(0, _loc_6 != null ? (_loc_6.position) : (param2.length));
                if (_loc_7.length > 0 || _loc_6 == null)
                {
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
                }
            }
            return;
        }// end function

        private function createSpanElement(param1:String, param2:String) : SpanElement
        {
            var _loc_3:* = new SpanElement();
            _loc_3.text = param1;
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
                    case "b":
                    {
                        this.createSpanElementsFromHtmlTags(param1, _loc_4[0].replace(BOLD_PATTERN, ""), param3);
                        break;
                    }
                    default:
                    {
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

        private function createImage(param1:Uri) : InlineGraphicElement
        {
            var _loc_2:* = new Texture();
            _loc_2.uri = param1;
            _loc_2.finalize();
            var _loc_3:* = new InlineGraphicElement();
            _loc_3.alignmentBaseline = TextBaseline.DESCENT;
            _loc_3.source = _loc_2;
            _loc_3.width = 20;
            _loc_3.height = 20;
            return _loc_3;
        }// end function

        private function getSmileyFromText(param1:String) : Smiley
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            var _loc_4:* = null;
            for each (_loc_4 in SMILIES)
            {
                
                _loc_2 = param1.indexOf(_loc_4);
                if (_loc_2 != -1)
                {
                    _loc_3 = SMILIES.indexOf(_loc_4);
                    break;
                }
            }
            if (_loc_2 != -1)
            {
                return new Smiley((_loc_3 + 1), _loc_2);
            }
            return null;
        }// end function

    }
}

import com.ankamagames.berilia.*;

import com.ankamagames.berilia.components.messages.*;

import com.ankamagames.berilia.factories.*;

import com.ankamagames.berilia.managers.*;

import com.ankamagames.berilia.types.data.*;

import com.ankamagames.berilia.types.graphic.*;

import com.ankamagames.berilia.types.tooltip.*;

import com.ankamagames.jerakine.interfaces.*;

import com.ankamagames.jerakine.logger.*;

import com.ankamagames.jerakine.types.*;

import com.ankamagames.jerakine.utils.benchmark.monitoring.*;

import com.ankamagames.jerakine.utils.misc.*;

import flash.display.*;

import flash.events.*;

import flash.text.engine.*;

import flash.utils.*;

import flashx.textLayout.compose.*;

import flashx.textLayout.container.*;

import flashx.textLayout.elements.*;

import flashx.textLayout.events.*;

import flashx.textLayout.formats.*;

class Smiley extends Object
{
    public var pictoId:int;
    public var position:int;

    function Smiley(param1:int, param2:int) : void
    {
        this.pictoId = param1;
        this.position = param2;
        return;
    }// end function

}

