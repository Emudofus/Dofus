package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.berilia.types.graphic.TimeoutHTMLLoader;
   import flash.utils.Timer;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.events.Event;
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardMessage;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseWheelMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyDownMessage;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import flash.display.NativeWindow;
   import flash.events.TimerEvent;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.utils.clearTimeout;
   import flash.net.URLRequest;
   import com.ankamagames.jerakine.utils.misc.CopyObject;
   import flash.utils.setTimeout;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.messages.BrowserDomReady;
   import flash.display.InteractiveObject;
   import flash.net.navigateToURL;
   import com.ankamagames.berilia.components.messages.BrowserSessionTimeout;
   
   public class WebBrowser extends GraphicContainer implements FinalizableUIComponent
   {
      
      public function WebBrowser()
      {
         var _loc1_:NativeWindow = null;
         this._linkList = [];
         this._manualExternalLink = new Dictionary();
         super();
         this._vScrollBar = new ScrollBar();
         if(AirScanner.hasAir())
         {
            this._resizeTimer = new Timer(200);
            this._resizeTimer.addEventListener(TimerEvent.TIMER,this.onResizeEnd);
            _loc1_ = StageShareManager.stage.nativeWindow;
            _loc1_.addEventListener(Event.RESIZE,this.onResize);
            this._vScrollBar.min = 1;
            this._vScrollBar.max = 1;
            this._vScrollBar.width = 16;
            this._vScrollBar.addEventListener(Event.CHANGE,this.onScroll);
         }
         else
         {
            this._vScrollBar.width = 0;
            _log.error("Can\'t create a WebBrowser object without AIR support");
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WebBrowser));
      
      private var _htmlLoader:TimeoutHTMLLoader;
      
      private var _vScrollBar:ScrollBar;
      
      private var _finalized:Boolean;
      
      private var _resizeTimer:Timer;
      
      private var _scrollTopOffset:int = 0;
      
      private var _cacheId:String;
      
      private var _cacheLife:Number = 15;
      
      private var _lifeTimer:Timer;
      
      private var _linkList:Array;
      
      private var _inputFocus:Boolean;
      
      private var _manualExternalLink:Dictionary;
      
      private var _transparentBackground:Boolean;
      
      private var _htmlRendered:Boolean = false;
      
      private var _timeoutId:uint;
      
      private var _domInit:Boolean;
      
      public function get cacheLife() : Number
      {
         return this._cacheLife;
      }
      
      public function set cacheLife(param1:Number) : void
      {
         this._cacheLife = Math.max(1,param1);
         if(this._htmlLoader)
         {
            this._htmlLoader.life = param1;
         }
      }
      
      public function get cacheId() : String
      {
         return this._cacheId;
      }
      
      public function set cacheId(param1:String) : void
      {
         this._cacheId = param1;
      }
      
      public function set scrollCss(param1:Uri) : void
      {
         this._vScrollBar.css = param1;
      }
      
      public function get scrollCss() : Uri
      {
         return this._vScrollBar.css;
      }
      
      public function set displayScrollBar(param1:Boolean) : void
      {
         this._vScrollBar.width = param1?16:0;
         this.onResizeEnd(null);
      }
      
      public function get displayScrollBar() : Boolean
      {
         return !(this._vScrollBar.width == 0);
      }
      
      public function set scrollTopOffset(param1:int) : void
      {
         this._scrollTopOffset = param1;
         this._vScrollBar.y = param1;
         if(height)
         {
            this._vScrollBar.height = height - this._scrollTopOffset;
         }
      }
      
      public function get finalized() : Boolean
      {
         return this._finalized;
      }
      
      public function set finalized(param1:Boolean) : void
      {
         this._finalized = param1;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         if(this._htmlLoader)
         {
            this._htmlLoader.width = param1 - this._vScrollBar.width;
            this._vScrollBar.x = this._htmlLoader.x + this._htmlLoader.width;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         if(this._htmlLoader)
         {
            this._htmlLoader.height = param1;
         }
         this.scrollTopOffset = this._scrollTopOffset;
      }
      
      public function get fromCache() : Boolean
      {
         return this._htmlLoader.fromCache;
      }
      
      public function get location() : String
      {
         return this._htmlLoader.location;
      }
      
      public function clearLocation() : void
      {
         var _loc1_:String = XmlConfig.getInstance().getEntry("colors.grid.bg").replace("0x","#");
         this._htmlLoader.loadString("<html><body bgcolor=\"" + _loc1_ + "\"></body></html>");
      }
      
      public function set transparentBackground(param1:Boolean) : void
      {
         this._transparentBackground = param1;
         if(this._htmlLoader)
         {
            this._htmlLoader.paintsDefaultBackground = !this._transparentBackground;
         }
      }
      
      public function finalize() : void
      {
         if(!AirScanner.hasAir())
         {
            this._finalized = true;
            return;
         }
         addChild(this._vScrollBar);
         this._vScrollBar.finalize();
         if(!this._htmlLoader)
         {
            this._htmlLoader = TimeoutHTMLLoader.getLoader(this.cacheId);
            if(this._htmlLoader.fromCache)
            {
               this.onDomReady(null);
            }
            else
            {
               this.clearLocation();
            }
            this._htmlLoader.life = this.cacheLife;
            this._htmlLoader.addEventListener(Event["HTML_RENDER"],this.onDomReady);
            this._htmlLoader.addEventListener(Event["HTML_BOUNDS_CHANGE"],this.onBoundsChange);
            this._htmlLoader.addEventListener(TimeoutHTMLLoader.TIMEOUT,this.onSessionTimeout);
            this._htmlLoader.addEventListener(Event["LOCATION_CHANGE"],this.onLocationChange);
            this._htmlLoader.paintsDefaultBackground = !this._transparentBackground;
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
      
      public function setBlankLink(param1:String, param2:Boolean) : void
      {
         if(param2)
         {
            this._manualExternalLink[param1] = new RegExp(param1);
         }
         else
         {
            delete this._manualExternalLink[param1];
            true;
         }
         this.modifyDOM(this._htmlLoader.window.document);
      }
      
      override public function process(param1:Message) : Boolean
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:KeyboardMessage = null;
         var _loc4_:* = false;
         var _loc5_:String = null;
         var _loc6_:Bind = null;
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
         if(param1 is KeyboardKeyDownMessage || param1 is KeyboardKeyUpMessage)
         {
            _loc3_ = param1 as KeyboardMessage;
            _loc5_ = BindsManager.getInstance().getShortcutString(_loc3_.keyboardEvent.keyCode,this.getCharCode(_loc3_));
            _loc6_ = BindsManager.getInstance().getBind(new Bind(_loc5_,"",_loc3_.keyboardEvent.altKey,_loc3_.keyboardEvent.ctrlKey,_loc3_.keyboardEvent.shiftKey));
            if((_loc6_) && (_loc6_.targetedShortcut == "closeUi" || _loc6_.targetedShortcut == "toggleFullscreen"))
            {
               _loc4_ = true;
            }
            if(!_loc4_)
            {
               _loc2_ = FocusHandler.getInstance().getFocus();
               while((!(_loc2_ == this._htmlLoader)) && (_loc2_) && (_loc2_.parent))
               {
                  _loc2_ = _loc2_.parent;
               }
               return _loc2_ == this._htmlLoader;
            }
         }
         return false;
      }
      
      override public function remove() : void
      {
         var _loc1_:NativeWindow = null;
         if(this._resizeTimer)
         {
            this._resizeTimer.removeEventListener(TimerEvent.TIMER,this.onResizeEnd);
         }
         this.removeHtmlEvent();
         StageShareManager.stage.removeEventListener(Event.RESIZE,this.onResize);
         if(this._htmlLoader)
         {
            this._htmlLoader.removeEventListener(Event["HTML_RENDER"],this.onDomReady);
            this._htmlLoader.removeEventListener(Event["HTML_BOUNDS_CHANGE"],this.onBoundsChange);
            this._htmlLoader.removeEventListener(TimeoutHTMLLoader.TIMEOUT,this.onSessionTimeout);
            this._htmlLoader.removeEventListener(Event["LOCATION_CHANGE"],this.onLocationChange);
            if(contains(this._htmlLoader))
            {
               removeChild(this._htmlLoader);
            }
         }
         if(AirScanner.hasAir())
         {
            _loc1_ = StageShareManager.stage.nativeWindow;
            _loc1_.removeEventListener(Event.RESIZE,this.onResize);
            this._vScrollBar.removeEventListener(Event.CHANGE,this.onScroll);
         }
         if(this._timeoutId)
         {
            clearTimeout(this._timeoutId);
         }
         super.remove();
      }
      
      public function hasContent() : Boolean
      {
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
      
      public function get content() : Object
      {
         if(!this._domInit)
         {
            return null;
         }
         if((this._htmlLoader) && (this._htmlLoader.window) && (this._htmlLoader.window.document))
         {
            return this._htmlLoader.window.document;
         }
         return null;
      }
      
      public function load(param1:URLRequest) : void
      {
         var _loc2_:URLRequest = null;
         if(getUi().uiModule.trusted)
         {
            _loc2_ = new URLRequest();
            CopyObject.copyObject(param1,null,_loc2_);
            this._htmlLoader.load(_loc2_);
            return;
         }
         throw new SecurityError("Only trusted module can use WebBroswer");
      }
      
      public function javascriptSetVar(param1:String, param2:*) : void
      {
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         var _loc5_:Object = null;
         var _loc6_:* = 0;
         try
         {
            _loc3_ = param1.split(".");
            _loc4_ = _loc3_.length;
            _loc5_ = this._htmlLoader.window;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               if(_loc6_ < _loc4_ - 1)
               {
                  _loc5_ = _loc5_[_loc3_[_loc6_]];
               }
               else
               {
                  _loc5_[_loc3_[_loc6_]] = param2;
               }
               _loc6_++;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function javascriptCall(param1:String, ... rest) : void
      {
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         var _loc5_:Object = null;
         var _loc6_:* = 0;
         try
         {
            _loc3_ = param1.split(".");
            _loc4_ = _loc3_.length;
            _loc5_ = this._htmlLoader.window;
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc5_ = _loc5_[_loc3_[_loc6_]];
               _loc6_++;
            }
            (_loc5_ as Function).apply(null,rest);
         }
         catch(e:Error)
         {
         }
      }
      
      private function removeHtmlEvent() : void
      {
         var _loc1_:Object = null;
         while(this._linkList.length)
         {
            _loc1_ = this._linkList.pop();
            try
            {
               if(_loc1_)
               {
                  _loc1_.removeEventListener("click",this.onLinkClick);
               }
            }
            catch(e:Error)
            {
               continue;
            }
         }
      }
      
      private function getCharCode(param1:KeyboardMessage) : int
      {
         var _loc2_:* = 0;
         if((param1.keyboardEvent.shiftKey) && param1.keyboardEvent.keyCode == 52)
         {
            _loc2_ = 39;
         }
         else if((param1.keyboardEvent.shiftKey) && param1.keyboardEvent.keyCode == 54)
         {
            _loc2_ = 45;
         }
         else
         {
            _loc2_ = param1.keyboardEvent.charCode;
         }
         
         return _loc2_;
      }
      
      private function onResize(param1:Event) : void
      {
         if(this._resizeTimer)
         {
            this._resizeTimer.reset();
            this._resizeTimer.start();
         }
      }
      
      private function onResizeEnd(param1:Event) : void
      {
         if(this._resizeTimer)
         {
            this._resizeTimer.stop();
         }
         var _loc2_:Number = StageShareManager.windowScale;
         if(this._htmlLoader)
         {
            this._htmlLoader.width = width * _loc2_ - this._vScrollBar.width;
            this._htmlLoader.height = height * _loc2_;
            this._htmlLoader.scaleX = 1 / _loc2_;
            this._htmlLoader.scaleY = 1 / _loc2_;
         }
      }
      
      private function onDomReady(param1:Event = null) : void
      {
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
      
      private function isManualExternalLink(param1:String) : Boolean
      {
         var _loc2_:RegExp = null;
         for each(_loc2_ in this._manualExternalLink)
         {
            if(param1.match(_loc2_).length)
            {
               return true;
            }
         }
         return false;
      }
      
      private function modifyDOM(param1:Object) : void
      {
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
      
      private function onLinkClick(param1:*) : void
      {
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
      
      private function onInputFocus(param1:*) : void
      {
         this._inputFocus = true;
      }
      
      private function onInputBlur(param1:*) : void
      {
         this._inputFocus = false;
      }
      
      private function onScroll(param1:Event) : void
      {
         this._htmlLoader.scrollV = this._vScrollBar.value;
      }
      
      private function onBoundsChange(param1:Event) : void
      {
         this.updateScrollbar();
      }
      
      private function updateScrollbar() : void
      {
         var _loc1_:int = this._htmlLoader.contentHeight - this._htmlLoader.height;
         if(!(this._vScrollBar.max == _loc1_) && _loc1_ > 0)
         {
            this._vScrollBar.min = 0;
            this._vScrollBar.max = _loc1_;
         }
      }
      
      private function onSessionTimeout(param1:Event) : void
      {
         Berilia.getInstance().handler.process(new BrowserSessionTimeout(InteractiveObject(this)));
      }
      
      private function onLocationChange(param1:Event) : void
      {
         _log.trace("Load " + this._htmlLoader.location);
         this.removeHtmlEvent();
         this._inputFocus = false;
         this._domInit = false;
         this._htmlRendered = false;
      }
   }
}
