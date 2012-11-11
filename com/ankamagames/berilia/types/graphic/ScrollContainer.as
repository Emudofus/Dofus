package com.ankamagames.berilia.types.graphic
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import flash.display.*;
    import flash.events.*;

    public class ScrollContainer extends GraphicContainer implements FinalizableUIComponent
    {
        private var _finalized:Boolean = false;
        private var _mask:Shape;
        private var _content:DisplayObjectContainer;
        private var d:Shape;
        private var _hScrollbar:ScrollBar;
        private var _vScrollbar:ScrollBar;
        private var _hScrollbarSpeed:Number = 1;
        private var _vScrollbarSpeed:Number = 1;
        private var _useHorizontalScroll:Boolean = true;
        private var _scrollBarCss:Uri;
        private var _scrollBarSize:uint = 16;

        public function ScrollContainer()
        {
            this.d = new Shape();
            mouseEnabled = true;
            this._mask = new Shape();
            this._mask.graphics.beginFill(16776960);
            this._mask.graphics.drawRect(0, 0, 1, 1);
            this._content = new Sprite();
            this._content.mask = this._mask;
            super.addChild(this._content);
            super.addChild(this._mask);
            return;
        }// end function

        public function set finalized(param1:Boolean) : void
        {
            this._finalized = param1;
            return;
        }// end function

        public function get finalized() : Boolean
        {
            return this._finalized;
        }// end function

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            this._mask.width = param1;
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            super.height = param1;
            this._mask.height = param1;
            return;
        }// end function

        public function set scrollbarCss(param1:Uri) : void
        {
            this._scrollBarCss = param1;
            return;
        }// end function

        public function get verticalScrollSpeed() : Number
        {
            if (this._vScrollbar)
            {
                return this._vScrollbar.scrollSpeed;
            }
            return this._vScrollbarSpeed;
        }// end function

        public function set verticalScrollSpeed(param1:Number) : void
        {
            if (this._vScrollbar)
            {
                this._vScrollbar.scrollSpeed = param1;
            }
            this._vScrollbarSpeed = param1;
            return;
        }// end function

        public function set verticalScrollbarValue(param1:int) : void
        {
            if (this._vScrollbar)
            {
                this._vScrollbar.value = param1;
                this.onVerticalScroll(null);
            }
            return;
        }// end function

        public function get verticalScrollbarValue() : int
        {
            if (this._vScrollbar)
            {
                return this._vScrollbar.value;
            }
            return -1;
        }// end function

        public function get useHorizontalScroll() : Boolean
        {
            return this._useHorizontalScroll;
        }// end function

        public function set useHorizontalScroll(param1:Boolean) : void
        {
            this._useHorizontalScroll = param1;
            return;
        }// end function

        public function get horizontalScrollSpeed() : Number
        {
            if (this._hScrollbar)
            {
                return this._hScrollbar.scrollSpeed;
            }
            return this._hScrollbarSpeed;
        }// end function

        public function set horizontalScrollSpeed(param1:Number) : void
        {
            if (this._hScrollbar)
            {
                this._hScrollbar.scrollSpeed = param1;
            }
            this._hScrollbarSpeed = param1;
            return;
        }// end function

        public function set horizontalScrollbarValue(param1:int) : void
        {
            if (this._hScrollbar)
            {
                this._hScrollbar.value = param1;
                this.onHorizontalScroll(null);
            }
            return;
        }// end function

        public function get horizontalScrollbarValue() : int
        {
            if (this._hScrollbar)
            {
                return this._hScrollbar.value;
            }
            return -1;
        }// end function

        override public function addChild(param1:DisplayObject) : DisplayObject
        {
            param1.addEventListener(Event.REMOVED, this.onChildRemoved);
            this.getStrata(0).addChild(param1);
            this.finalize();
            param1.addEventListener(UiRenderEvent.UIRenderComplete, this.onChildFinalized);
            return param1;
        }// end function

        override public function addContent(param1:GraphicContainer, param2:int = -1) : GraphicContainer
        {
            param1.addEventListener(Event.REMOVED, this.onChildRemoved);
            this.getStrata(0).addChild(param1);
            this.finalize();
            param1.addEventListener(UiRenderEvent.UIRenderComplete, this.onChildFinalized);
            return param1;
        }// end function

        public function finalize() : void
        {
            var _loc_1:* = width < Math.floor(this._content.width) && this._useHorizontalScroll;
            var _loc_2:* = height < Math.floor(this._content.height);
            if (_loc_1)
            {
                if (!this._hScrollbar)
                {
                    this._hScrollbar = new ScrollBar();
                    this._hScrollbar.vertical = false;
                    this._hScrollbar.addEventListener(Event.CHANGE, this.onHorizontalScroll);
                    this._hScrollbar.css = this._scrollBarCss;
                    this._hScrollbar.min = 0;
                    this._hScrollbar.height = this._scrollBarSize;
                    this._hScrollbar.y = height - this._hScrollbar.height;
                    this._hScrollbar.step = 1;
                    this._hScrollbar.scrollSpeed = this._hScrollbarSpeed;
                    super.addChild(this._hScrollbar);
                    this._hScrollbar.finalize();
                }
                else
                {
                    super.addChild(this._hScrollbar);
                }
                this._mask.height = height - this._scrollBarSize;
                this._hScrollbar.width = width - (_loc_2 ? (this._scrollBarSize) : (0));
                this._hScrollbar.max = this._content.width - width + (_loc_2 ? (this._scrollBarSize) : (0));
            }
            else if (this._hScrollbar && contains(this._hScrollbar))
            {
                this._content.x = 0;
                removeChild(this._hScrollbar);
                this._mask.height = height;
            }
            if (_loc_2)
            {
                if (!this._vScrollbar)
                {
                    this._vScrollbar = new ScrollBar();
                    this._vScrollbar.addEventListener(Event.CHANGE, this.onVerticalScroll);
                    this._vScrollbar.css = this._scrollBarCss;
                    this._vScrollbar.min = 0;
                    this._vScrollbar.width = this._scrollBarSize;
                    this._vScrollbar.x = width - this._vScrollbar.width;
                    this._vScrollbar.vertical = false;
                    this._vScrollbar.step = 1;
                    this._vScrollbar.scrollSpeed = this._vScrollbarSpeed;
                    super.addChild(this._vScrollbar);
                    this._vScrollbar.finalize();
                }
                else
                {
                    super.addChild(this._vScrollbar);
                }
                this._mask.width = width - this._scrollBarSize;
                this._vScrollbar.height = height - (_loc_1 ? (this._scrollBarSize) : (0));
                this._vScrollbar.max = this._content.height - height + (_loc_2 ? (this._scrollBarSize) : (0));
            }
            else if (this._vScrollbar && contains(this._vScrollbar))
            {
                this._content.y = 0;
                removeChild(this._vScrollbar);
                this._mask.width = width;
            }
            this._finalized = true;
            var _loc_3:* = new Shape();
            _loc_3.graphics.beginFill(0, 0);
            _loc_3.graphics.drawRect(0, 0, __width, __height);
            super.addChild(_loc_3);
            getUi().iAmFinalized(this);
            return;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            switch(true)
            {
                case param1 is MouseWheelMessage:
                {
                    if (this._vScrollbar && this._vScrollbar.parent != null)
                    {
                        this._vScrollbar.onWheel(MouseWheelMessage(param1).mouseEvent);
                    }
                    else if (this._hScrollbar && this._hScrollbar.parent != null)
                    {
                        this._hScrollbar.onWheel(MouseWheelMessage(param1).mouseEvent);
                    }
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        override public function getStrata(param1:uint) : Sprite
        {
            var _loc_2:* = 0;
            var _loc_3:* = 0;
            if (_aStrata[param1] != null)
            {
                return _aStrata[param1];
            }
            _aStrata[param1] = new Sprite();
            _aStrata[param1].name = "strata_" + param1;
            _aStrata[param1].mouseEnabled = mouseEnabled;
            _loc_2 = 0;
            _loc_3 = 0;
            while (_loc_3 < _aStrata.length)
            {
                
                if (_aStrata[_loc_3] != null)
                {
                    this._content.addChildAt(_aStrata[_loc_3], _loc_2++);
                }
                _loc_3 = _loc_3 + 1;
            }
            return _aStrata[param1];
        }// end function

        private function onVerticalScroll(event:Event) : void
        {
            this._content.y = -this._vScrollbar.value;
            return;
        }// end function

        private function onHorizontalScroll(event:Event) : void
        {
            this._content.x = -this._hScrollbar.value;
            return;
        }// end function

        private function onChildFinalized(event:Event) : void
        {
            event.target.removeEventListener(UiRenderEvent.UIRenderComplete, this.onChildFinalized);
            this.finalize();
            return;
        }// end function

        private function onChildRemoved(event:Event) : void
        {
            return;
        }// end function

    }
}
