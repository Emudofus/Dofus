package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.types.graphic.TimeoutHTMLLoader;
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
   import flash.ui.Keyboard;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.utils.clearTimeout;
   import flash.net.URLRequest;
   import flash.utils.setTimeout;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.messages.BrowserDomReady;
   import flash.display.InteractiveObject;
   import flash.net.navigateToURL;
   import com.ankamagames.berilia.components.messages.BrowserSessionTimeout;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.events.TimerEvent;
   import flash.display.NativeWindow;
   
   public class WebBrowser extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function WebBrowser() {
         this._resizeTimer = new Timer(200);
         this._linkList = [];
         this._inputList = [];
         this._manualExternalLink = new Dictionary();
         super();
         if(!AirScanner.hasAir())
         {
            throw new Error("Can\'t create a WebBrowser object without AIR support");
         }
         else
         {
            this._resizeTimer.addEventListener(TimerEvent.TIMER,this.onResizeEnd);
            _loc1_ = StageShareManager.stage.nativeWindow;
            _loc1_.addEventListener(Event.RESIZE,this.onResize);
            this._vScrollBar = new ScrollBar();
            this._vScrollBar.min = 1;
            this._vScrollBar.max = 1;
            this._vScrollBar.width = 16;
            this._vScrollBar.addEventListener(Event.CHANGE,this.onScroll);
            return;
         }
      }
      
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
      
      private var _manualExternalLink:Dictionary;
      
      public function get cacheLife() : Number {
         return this._cacheLife;
      }
      
      public function set cacheLife(param1:Number) : void {
         this._cacheLife = Math.max(1,param1);
         if(this._htmlLoader)
         {
            this._htmlLoader.life = param1;
         }
      }
      
      public function get cacheId() : String {
         return this._cacheId;
      }
      
      public function set cacheId(param1:String) : void {
         this._cacheId = param1;
      }
      
      public function set scrollCss(param1:Uri) : void {
         this._vScrollBar.css = param1;
      }
      
      public function get scrollCss() : Uri {
         return this._vScrollBar.css;
      }
      
      public function set displayScrollBar(param1:Boolean) : void {
         this._vScrollBar.width = param1?16:0;
         this.onResizeEnd(null);
      }
      
      public function get displayScrollBar() : Boolean {
         return this._displayScrollBar;
      }
      
      public function set scrollTopOffset(param1:int) : void {
         this._scrollTopOffset = param1;
         this._vScrollBar.y = param1;
         if(height)
         {
            this._vScrollBar.height = height - this._scrollTopOffset;
         }
      }
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      override public function set width(param1:Number) : void {
         super.width = param1;
         if(this._htmlLoader)
         {
            this._htmlLoader.width = param1 - this._vScrollBar.width;
            this._vScrollBar.x = this._htmlLoader.x + this._htmlLoader.width;
         }
      }
      
      override public function set height(param1:Number) : void {
         super.height = param1;
         if(this._htmlLoader)
         {
            this._htmlLoader.height = param1;
         }
         this.scrollTopOffset = this._scrollTopOffset;
      }
      
      public function get fromCache() : Boolean {
         return this._htmlLoader.fromCache;
      }
      
      public function get location() : String {
         return this._htmlLoader.location;
      }
      
      public function finalize() : void {
         addChild(this._vScrollBar);
         this._vScrollBar.finalize();
         if(!this._htmlLoader)
         {
            this._htmlLoader = TimeoutHTMLLoader.getLoader(this.cacheId);
            if(this._htmlLoader.fromCache)
            {
               this.onDomReady(null);
            }
            this._htmlLoader.life = this.cacheLife;
            this._htmlLoader.addEventListener(Event["HTML_RENDER"],this.onDomReady);
            this._htmlLoader.addEventListener(Event["HTML_BOUNDS_CHANGE"],this.onBoundsChange);
            this._htmlLoader.addEventListener(TimeoutHTMLLoader.TIMEOUT,this.onSessionTimeout);
            this._htmlLoader.addEventListener(Event["LOCATION_CHANGE"],this.onLocationChange);
         }
         this.width = width;
         this.height = height;
         this.updateScrollbar();
         if(this._htmlLoader.fromCache)
         {
            this._vScrollBar.value = this._htmlLoader.scrollV;
         }
         addChild(this._htmlLoader);
         this.onResizeEnd(null);
         this._finalized = true;
      }
      
      public function setBlankLink(param1:String, param2:Boolean) : void {
         if(param2)
         {
            this._manualExternalLink[param1] = new RegExp(param1);
         }
         else
         {
            delete this._manualExternalLink[[param1]];
         }
         this.modifyDOM(this._htmlLoader.window.document);
      }
      
      override public function process(param1:Message) : Boolean {
         var _loc2_:DisplayObject = null;
         if(param1 is MouseWheelMessage)
         {
            _loc2_ = MouseWheelMessage(param1).target;
            while((!(_loc2_ == this._htmlLoader)) && (_loc2_) && (_loc2_.parent))
            {
               _loc2_ = _loc2_.parent;
            }
            if(_loc2_ == this._htmlLoader)
            {
               this._vScrollBar.value = this._htmlLoader.scrollV;
            }
         }
         if((param1 is KeyboardKeyDownMessage || param1 is KeyboardKeyUpMessage) && !(KeyboardMessage(param1).keyboardEvent.keyCode == Keyboard.ESCAPE))
         {
            _loc2_ = FocusHandler.getInstance().getFocus();
            while((!(_loc2_ == this._htmlLoader)) && (_loc2_) && (_loc2_.parent))
            {
               _loc2_ = _loc2_.parent;
            }
            return _loc2_ == this._htmlLoader;
         }
         return false;
      }
      
      override public function remove() : void {
         this.removeHtmlEvent();
         this._htmlLoader.removeEventListener(Event["HTML_RENDER"],this.onDomReady);
         this._htmlLoader.removeEventListener(Event["HTML_BOUNDS_CHANGE"],this.onBoundsChange);
         StageShareManager.stage.removeEventListener(Event.RESIZE,this.onResize);
         if(contains(this._htmlLoader))
         {
            removeChild(this._htmlLoader);
         }
         if(this._timeoutId)
         {
            clearTimeout(this._timeoutId);
         }
         super.remove();
      }
      
      public function hasContent() : Boolean {
         var _loc1_:Object = this._htmlLoader.window.document.getElementsByTagName("body");
         if(!_loc1_[0] || _loc1_[0].firstChild == null)
         {
            return false;
         }
         if((_loc1_[0].getElementsByTagName("h1")) && _loc1_[0].getElementsByTagName("h1").length > 0)
         {
            return true;
         }
         return false;
      }
      
      public function load(param1:URLRequest) : void {
         if(getUi().uiModule.trusted)
         {
            this._htmlLoader.load(param1);
            return;
         }
         throw new SecurityError("Only trusted module can use WebBroswer");
      }
      
      public function javascriptSetVar(param1:String, param2:*) : void {
         try
         {
            this._htmlLoader.window.document.body[param1] = param2;
         }
         catch(e:Error)
         {
         }
      }
      
      public function javascriptCall(param1:String, ... rest) : void {
         var _loc3_:Function = null;
         try
         {
            _loc3_ = this._htmlLoader.window[param1];
            _loc3_.apply(null,rest);
         }
         catch(e:Error)
         {
         }
      }
      
      private function removeHtmlEvent() : void {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         for each (_loc1_ in this._linkList)
         {
            try
            {
               _loc1_.removeEventListener("click",this.onLinkClick);
            }
            catch(e:Error)
            {
               continue;
            }
         }
         for each (_loc2_ in this._inputList)
         {
            try
            {
               _loc2_.removeEventListener("focus",this.onInputFocus);
               _loc2_.removeEventListener("blur",this.onInputBlur);
            }
            catch(e:Error)
            {
               continue;
            }
         }
      }
      
      private function onResize(param1:Event) : void {
         this._resizeTimer.reset();
         this._resizeTimer.start();
      }
      
      private function onResizeEnd(param1:Event) : void {
         this._resizeTimer.stop();
         var _loc2_:Number = StageShareManager.windowScale;
         if(this._htmlLoader)
         {
            this._htmlLoader.width = width * _loc2_ - this._vScrollBar.width;
            this._htmlLoader.height = height * _loc2_;
            this._htmlLoader.scaleX = 1 / _loc2_;
            this._htmlLoader.scaleY = 1 / _loc2_;
         }
      }
      
      private var _timeoutId:uint;
      
      private var _domInit:Boolean;
      
      private function onDomReady(param1:Event) : void {
         if(!this._htmlLoader.window.document.body)
         {
            this._domInit = false;
            if(!this._timeoutId)
            {
               this._timeoutId = setTimeout(this.onDomReady,100,null);
            }
            return;
         }
         if(this._timeoutId)
         {
            clearTimeout(this._timeoutId);
            this._timeoutId = 0;
         }
         this.modifyDOM(this._htmlLoader.window.document);
         if(this._domInit)
         {
            return;
         }
         this._domInit = true;
         this.updateScrollbar();
         this.onResizeEnd(null);
         Berilia.getInstance().handler.process(new BrowserDomReady(InteractiveObject(this)));
      }
      
      private function isManualExternalLink(param1:String) : Boolean {
         var _loc2_:RegExp = null;
         for each (_loc2_ in this._manualExternalLink)
         {
            if(param1.match(_loc2_).length)
            {
               return true;
            }
         }
         return false;
      }
      
      private function modifyDOM(param1:Object) : void {
         var i:uint = 0;
         var a:Object = null;
         var target:Object = param1;
         try
         {
            a = target.getElementsByTagName("a");
            i = 0;
            while(i < a.length)
            {
               if(a[i].target == "_blank" || (this.isManualExternalLink(a[i].href)))
               {
                  a[i].addEventListener("click",this.onLinkClick,false);
                  if(this._linkList.indexOf(a[i]) == -1)
                  {
                     this._linkList.push(a[i]);
                  }
               }
               i++;
            }
         }
         catch(e:Error)
         {
            _log.error("Erreur lors de l\'ajout des lien blank");
         }
      }
      
      private function onLinkClick(param1:*) : void {
         var _loc2_:Object = param1.target;
         if(_loc2_.tagName == "IMG")
         {
            _loc2_ = _loc2_.parentElement;
         }
         if(_loc2_.target == "_blank" || (this.isManualExternalLink(_loc2_.href)))
         {
            param1.preventDefault();
            navigateToURL(new URLRequest(_loc2_.href));
         }
      }
      
      private function onInputFocus(param1:*) : void {
         this._inputFocus = true;
      }
      
      private function onInputBlur(param1:*) : void {
         this._inputFocus = false;
      }
      
      private function onScroll(param1:Event) : void {
         this._htmlLoader.scrollV = this._vScrollBar.value;
      }
      
      private function onBoundsChange(param1:Event) : void {
         this.updateScrollbar();
      }
      
      private function updateScrollbar() : void {
         if(this._vScrollBar.max != this._htmlLoader.contentHeight - this._htmlLoader.height)
         {
            this._vScrollBar.min = 0;
            this._vScrollBar.max = this._htmlLoader.contentHeight - this._htmlLoader.height;
         }
      }
      
      private function onSessionTimeout(param1:Event) : void {
         Berilia.getInstance().handler.process(new BrowserSessionTimeout(InteractiveObject(this)));
      }
      
      private function onLocationChange(param1:Event) : void {
         _log.trace("Load " + this._htmlLoader.location);
         this.removeHtmlEvent();
         this._inputFocus = false;
         this._domInit = false;
      }
   }
}
