package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.jerakine.handlers.*;
    import com.ankamagames.jerakine.handlers.messages.keyboard.*;
    import com.ankamagames.jerakine.handlers.messages.mouse.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.ui.*;
    import flash.utils.*;

    public class WebBrowser extends GraphicContainer implements FinalizableUIComponent
    {
        private var _finalized:Boolean;
        private var _htmlLoader:TimeoutHTMLLoader;
        private var _resizeTimer:Timer;
        private var _vScrollBar:ScrollBar;
        private var _scrollTopOffset:int = 0;
        private var _cacheId:String;
        private var _cacheLife:Number = 15;
        private var _lifeTimer:Timer;
        private var _linkList:Array;
        private var _inputList:Array;
        private var _inputFocus:Boolean;
        private var _displayScrollBar:Boolean = true;
        private var _timeoutId:uint;
        private var _domInit:Boolean;

        public function WebBrowser()
        {
            this._resizeTimer = new Timer(200);
            this._linkList = [];
            this._inputList = [];
            if (!AirScanner.hasAir())
            {
                throw new Error("Can\'t create a WebBrowser object without AIR support");
            }
            this._resizeTimer.addEventListener(TimerEvent.TIMER, this.onResizeEnd);
            StageShareManager.stage.addEventListener(Event.RESIZE, this.onResize);
            this._vScrollBar = new ScrollBar();
            this._vScrollBar.min = 1;
            this._vScrollBar.max = 1;
            this._vScrollBar.width = 16;
            this._vScrollBar.addEventListener(Event.CHANGE, this.onScroll);
            return;
        }// end function

        public function get cacheLife() : Number
        {
            return this._cacheLife;
        }// end function

        public function set cacheLife(param1:Number) : void
        {
            this._cacheLife = Math.max(1, param1);
            if (this._htmlLoader)
            {
                this._htmlLoader.life = param1;
            }
            return;
        }// end function

        public function get cacheId() : String
        {
            return this._cacheId;
        }// end function

        public function set cacheId(param1:String) : void
        {
            this._cacheId = param1;
            return;
        }// end function

        public function set scrollCss(param1:Uri) : void
        {
            this._vScrollBar.css = param1;
            return;
        }// end function

        public function get scrollCss() : Uri
        {
            return this._vScrollBar.css;
        }// end function

        public function set displayScrollBar(param1:Boolean) : void
        {
            this._vScrollBar.width = param1 ? (16) : (0);
            this.onResizeEnd(null);
            return;
        }// end function

        public function get displayScrollBar() : Boolean
        {
            return this._displayScrollBar;
        }// end function

        public function set scrollTopOffset(param1:int) : void
        {
            this._scrollTopOffset = param1;
            this._vScrollBar.y = param1;
            if (height)
            {
                this._vScrollBar.height = height - this._scrollTopOffset;
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

        override public function set width(param1:Number) : void
        {
            super.width = param1;
            if (this._htmlLoader)
            {
                this._htmlLoader.width = param1 - this._vScrollBar.width;
                this._vScrollBar.x = this._htmlLoader.x + this._htmlLoader.width;
            }
            return;
        }// end function

        override public function set height(param1:Number) : void
        {
            super.height = param1;
            if (this._htmlLoader)
            {
                this._htmlLoader.height = param1;
            }
            this.scrollTopOffset = this._scrollTopOffset;
            return;
        }// end function

        public function get fromCache() : Boolean
        {
            return this._htmlLoader.fromCache;
        }// end function

        public function get location() : String
        {
            return this._htmlLoader.location;
        }// end function

        public function finalize() : void
        {
            addChild(this._vScrollBar);
            this._vScrollBar.finalize();
            if (!this._htmlLoader)
            {
                this._htmlLoader = TimeoutHTMLLoader.getLoader(this.cacheId);
                if (this._htmlLoader.fromCache)
                {
                    this.onDomReady(null);
                }
                this._htmlLoader.life = this.cacheLife;
                this._htmlLoader.addEventListener(Event["HTML_RENDER"], this.onDomReady);
                this._htmlLoader.addEventListener(Event["HTML_BOUNDS_CHANGE"], this.onBoundsChange);
                this._htmlLoader.addEventListener(TimeoutHTMLLoader.TIMEOUT, this.onSessionTimeout);
                this._htmlLoader.addEventListener(Event["LOCATION_CHANGE"], this.onLocationChange);
            }
            this.width = width;
            this.height = height;
            this.updateScrollbar();
            if (this._htmlLoader.fromCache)
            {
                this._vScrollBar.value = this._htmlLoader.scrollV;
            }
            addChild(this._htmlLoader);
            this.onResizeEnd(null);
            this._finalized = true;
            return;
        }// end function

        override public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            if (param1 is MouseWheelMessage)
            {
                _loc_2 = MouseWheelMessage(param1).target;
                while (_loc_2 != this._htmlLoader && _loc_2 && _loc_2.parent)
                {
                    
                    _loc_2 = _loc_2.parent;
                }
                if (_loc_2 == this._htmlLoader)
                {
                    this._vScrollBar.value = this._htmlLoader.scrollV;
                }
            }
            if ((param1 is KeyboardKeyDownMessage || param1 is KeyboardKeyUpMessage) && KeyboardMessage(param1).keyboardEvent.keyCode != Keyboard.ESCAPE)
            {
                _loc_2 = FocusHandler.getInstance().getFocus();
                while (_loc_2 != this._htmlLoader && _loc_2 && _loc_2.parent)
                {
                    
                    _loc_2 = _loc_2.parent;
                }
                return _loc_2 == this._htmlLoader;
            }
            return false;
        }// end function

        override public function remove() : void
        {
            if (this._cacheId)
            {
                this.removeHtmlEvent();
                this._htmlLoader.removeEventListener(Event["HTML_RENDER"], this.onDomReady);
                this._htmlLoader.removeEventListener(Event["HTML_BOUNDS_CHANGE"], this.onBoundsChange);
                StageShareManager.stage.removeEventListener(Event.RESIZE, this.onResize);
                if (contains(this._htmlLoader))
                {
                    removeChild(this._htmlLoader);
                }
            }
            if (this._timeoutId)
            {
                clearTimeout(this._timeoutId);
            }
            super.remove();
            return;
        }// end function

        public function hasContent() : Boolean
        {
            var _loc_1:* = this._htmlLoader.window.document.getElementsByTagName("body");
            if (!_loc_1[0] || _loc_1[0].firstChild == null)
            {
                return false;
            }
            if (_loc_1[0].getElementsByTagName("h1") && _loc_1[0].getElementsByTagName("h1").length > 0)
            {
                return true;
            }
            return false;
        }// end function

        public function load(param1:URLRequest) : void
        {
            if (getUi().uiModule.trusted)
            {
                this._htmlLoader.load(param1);
            }
            else
            {
                throw new SecurityError("Only trusted module can use WebBroswer");
            }
            return;
        }// end function

        public function javascriptSetVar(param1:String, param2) : void
        {
            var varName:* = param1;
            var value:* = param2;
            try
            {
                this._htmlLoader.window.document.body[varName] = value;
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        public function javascriptCall(param1:String, ... args) : void
        {
            args = new activation;
            var f:Function;
            var fctName:* = param1;
            var params:* = args;
            try
            {
                f = this._htmlLoader.window[];
                apply(null, );
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private function removeHtmlEvent() : void
        {
            var link:Object;
            var input:Object;
            var _loc_2:* = 0;
            var _loc_3:* = this._linkList;
            do
            {
                
                link = _loc_3[_loc_2];
                try
                {
                    link.removeEventListener("click", this.onLinkClick);
                }
                catch (e:Error)
                {
                }
            }while (_loc_3 in _loc_2)
            var _loc_2:* = 0;
            var _loc_3:* = this._inputList;
            do
            {
                
                input = _loc_3[_loc_2];
                try
                {
                    input.removeEventListener("focus", this.onInputFocus);
                    input.removeEventListener("blur", this.onInputBlur);
                }
                catch (e:Error)
                {
                }
            }while (_loc_3 in _loc_2)
            return;
        }// end function

        private function onResize(event:Event) : void
        {
            this._resizeTimer.reset();
            this._resizeTimer.start();
            return;
        }// end function

        private function onResizeEnd(event:Event) : void
        {
            this._resizeTimer.stop();
            var _loc_2:* = Math.min(StageShareManager.stage.stageWidth / StageShareManager.startWidth, StageShareManager.stage.stageHeight / StageShareManager.startHeight);
            if (this._htmlLoader)
            {
                this._htmlLoader.width = width * _loc_2 - this._vScrollBar.width;
                this._htmlLoader.height = height * _loc_2;
                this._htmlLoader.scaleX = 1 / _loc_2;
                this._htmlLoader.scaleY = 1 / _loc_2;
            }
            return;
        }// end function

        private function onDomReady(event:Event) : void
        {
            if (!this._htmlLoader.window.document.body)
            {
                this._domInit = false;
                if (!this._timeoutId)
                {
                    this._timeoutId = setTimeout(this.onDomReady, 100, null);
                }
                return;
            }
            if (this._timeoutId)
            {
                clearTimeout(this._timeoutId);
                this._timeoutId = 0;
            }
            this.modifyDOM(this._htmlLoader.window.document);
            if (this._domInit)
            {
                return;
            }
            this._domInit = true;
            this.updateScrollbar();
            this.onResizeEnd(null);
            Berilia.getInstance().handler.process(new BrowserDomReady(InteractiveObject(this)));
            return;
        }// end function

        private function modifyDOM(param1:Object) : void
        {
            var i:uint;
            var a:Object;
            var target:* = param1;
            try
            {
                a = target.getElementsByTagName("a");
                i;
                while (i < a.length)
                {
                    
                    if (a[i].target == "_blank")
                    {
                        a[i].addEventListener("click", this.onLinkClick, false);
                        if (this._linkList.indexOf(a[i]) == -1)
                        {
                            this._linkList.push(a[i]);
                        }
                    }
                    i = (i + 1);
                }
            }
            catch (e:Error)
            {
                _log.error("Erreur lors de l\'ajout des lien blank");
            }
            return;
        }// end function

        private function onLinkClick(param1) : void
        {
            var _loc_2:* = param1.target;
            if (_loc_2.tagName == "IMG")
            {
                _loc_2 = _loc_2.parentElement;
            }
            if (_loc_2.target == "_blank")
            {
                param1.preventDefault();
                navigateToURL(new URLRequest(_loc_2.href));
            }
            return;
        }// end function

        private function onInputFocus(param1) : void
        {
            this._inputFocus = true;
            return;
        }// end function

        private function onInputBlur(param1) : void
        {
            this._inputFocus = false;
            return;
        }// end function

        private function onScroll(event:Event) : void
        {
            this._htmlLoader.scrollV = this._vScrollBar.value;
            return;
        }// end function

        private function onBoundsChange(event:Event) : void
        {
            this.updateScrollbar();
            return;
        }// end function

        private function updateScrollbar() : void
        {
            if (this._vScrollBar.max != this._htmlLoader.contentHeight - this._htmlLoader.height)
            {
                this._vScrollBar.min = 0;
                this._vScrollBar.max = this._htmlLoader.contentHeight - this._htmlLoader.height;
            }
            return;
        }// end function

        private function onSessionTimeout(event:Event) : void
        {
            Berilia.getInstance().handler.process(new BrowserSessionTimeout(InteractiveObject(this)));
            return;
        }// end function

        private function onLocationChange(event:Event) : void
        {
            _log.trace("Load " + this._htmlLoader.location);
            this.removeHtmlEvent();
            this._inputFocus = false;
            this._domInit = false;
            return;
        }// end function

    }
}
