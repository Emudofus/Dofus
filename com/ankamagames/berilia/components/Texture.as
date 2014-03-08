package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.geom.Rectangle;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import com.ankamagames.jerakine.utils.display.MovieClipUtils;
   import flash.display.MovieClip;
   import flash.display.FrameLabel;
   import flash.display.DisplayObjectContainer;
   import flash.geom.ColorTransform;
   import com.ankamagames.berilia.Berilia;
   import flash.events.Event;
   import com.ankamagames.berilia.components.messages.TextureReadyMessage;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import com.ankamagames.jerakine.resources.adapters.impl.AdvancedSwfAdapter;
   import com.ankamagames.berilia.utils.UriCacheFactory;
   import com.ankamagames.jerakine.newCache.ICache;
   import flash.display.Shape;
   import com.ankamagames.jerakine.types.ASwf;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.jerakine.types.DynamicSecureObject;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.types.event.TextureLoadFailedEvent;
   import com.ankamagames.berilia.components.messages.TextureLoadFailMessage;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class Texture extends GraphicContainer implements FinalizableUIComponent, IRectangle
   {
      
      public function Texture() {
         this._log = Log.getLogger(getQualifiedClassName(Texture));
         super();
         mouseEnabled = false;
         mouseChildren = false;
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private var _log:Logger;
      
      private var _finalized:Boolean;
      
      private var _uri:Uri;
      
      private var _realUri:Uri;
      
      var _child:DisplayObject;
      
      private var _startedWidth:Number;
      
      private var _startedHeight:Number;
      
      private var _forcedHeight:Number;
      
      private var _forcedWidth:Number;
      
      private var _keepRatio:Boolean;
      
      private var _dispatchMessages:Boolean;
      
      private var _autoGrid:Boolean;
      
      private var _forceReload:Boolean = false;
      
      private var _gotoFrame;
      
      private var _loader:IResourceLoader;
      
      private var _startBounds:Rectangle;
      
      private var _disableAnimation:Boolean = false;
      
      private var _useCache:Boolean = true;
      
      private var _roundCornerRadius:uint = 0;
      
      private var _playOnce:Boolean = false;
      
      private var _bitmap:Bitmap;
      
      private var _showLoadingError:Boolean = true;
      
      public var defaultBitmapData:BitmapData;
      
      public function get finalized() : Boolean {
         return this._finalized;
      }
      
      public function set finalized(param1:Boolean) : void {
         this._finalized = param1;
      }
      
      public function get uri() : Uri {
         return this._uri;
      }
      
      public function set uri(param1:Uri) : void {
         if(!(param1 == this._uri) || (this._forceReload))
         {
            this._uri = param1;
            if(this._finalized)
            {
               this.reload();
            }
            return;
         }
      }
      
      public function get useCache() : Boolean {
         return this._useCache;
      }
      
      public function set useCache(param1:Boolean) : void {
         this._useCache = param1;
      }
      
      public function set showLoadingError(param1:Boolean) : void {
         this._showLoadingError = param1;
      }
      
      public function set disableAnimation(param1:Boolean) : void {
         this._disableAnimation = param1;
         if(this._finalized)
         {
            MovieClipUtils.stopMovieClip(this);
         }
      }
      
      override public function get height() : Number {
         return !isNaN(this._forcedHeight)?this._forcedHeight:this._child?this._child.height:0;
      }
      
      override public function set height(param1:Number) : void {
         if(this._forcedHeight == param1)
         {
            return;
         }
         this._forcedHeight = param1;
         if(this._finalized)
         {
            this.organize();
         }
      }
      
      override public function get width() : Number {
         return !isNaN(this._forcedWidth)?this._forcedWidth:this._child?this._child.width:0;
      }
      
      override public function set width(param1:Number) : void {
         if(this._forcedWidth == param1)
         {
            return;
         }
         this._forcedWidth = param1;
         if(this._finalized)
         {
            this.organize();
         }
      }
      
      public function get keepRatio() : Boolean {
         return this._keepRatio;
      }
      
      public function set keepRatio(param1:Boolean) : void {
         this._keepRatio = param1;
         if(this._finalized)
         {
            this.organize();
         }
      }
      
      override public function get scale9Grid() : Rectangle {
         if(this._child)
         {
            return this._child.scale9Grid;
         }
         return null;
      }
      
      override public function set scale9Grid(param1:Rectangle) : void {
         if(this._child)
         {
            this._child.scale9Grid = param1;
         }
      }
      
      public function vFlip() : void {
         var _loc1_:Number = x;
         var _loc2_:Number = y;
         scaleX = -1;
         x = _loc1_ + this.width;
      }
      
      public function hFlip() : void {
         var _loc1_:Number = x;
         var _loc2_:Number = y;
         scaleY = -1;
         y = _loc2_ + this.height;
      }
      
      public function get autoGrid() : Boolean {
         return this._autoGrid;
      }
      
      public function set autoGrid(param1:Boolean) : void {
         if(param1)
         {
            this._autoGrid = true;
         }
         else
         {
            this._autoGrid = false;
            if(this._child)
            {
               this._child.scale9Grid = null;
            }
         }
         if(this._finalized)
         {
            this.organize();
         }
      }
      
      public function set gotoAndStop(param1:*) : void {
         var mv:MovieClip = null;
         var value:* = param1;
         mv = this._child as MovieClip;
         if(mv != null)
         {
            try
            {
               mv.gotoAndStop(value);
            }
            catch(error:ArgumentError)
            {
               mv.stop();
            }
         }
         this._gotoFrame = value;
      }
      
      public function get gotoAndStop() : * {
         if((this._child) && this._child is MovieClip)
         {
            return (this._child as MovieClip).currentFrame.toString();
         }
         return this._gotoFrame;
      }
      
      private function hasLabel(param1:MovieClip, param2:String) : Boolean {
         var _loc4_:FrameLabel = null;
         var _loc3_:Array = param1.currentLabels;
         for each (_loc4_ in _loc3_)
         {
            if(param2 == _loc4_.name)
            {
               return true;
            }
         }
         return false;
      }
      
      public function set gotoAndPlay(param1:*) : void {
         if((this._child) && this._child is MovieClip)
         {
            if(param1)
            {
               (this._child as MovieClip).gotoAndPlay(param1);
            }
            else
            {
               (this._child as MovieClip).gotoAndPlay(1);
            }
         }
      }
      
      public function get totalFrames() : uint {
         if((this._child) && this._child is MovieClip)
         {
            return (this._child as MovieClip).totalFrames;
         }
         return 1;
      }
      
      public function get currentFrame() : uint {
         if((this._child) && this._child is MovieClip)
         {
            return (this._child as MovieClip).currentFrame;
         }
         return 1;
      }
      
      public function get dispatchMessages() : Boolean {
         return this._dispatchMessages;
      }
      
      public function set dispatchMessages(param1:Boolean) : void {
         this._dispatchMessages = param1;
      }
      
      public function get forceReload() : Boolean {
         return this._forceReload;
      }
      
      public function set forceReload(param1:Boolean) : void {
         this._forceReload = param1;
      }
      
      public function get loading() : Boolean {
         return !(this._loader == null);
      }
      
      public function get child() : DisplayObject {
         return this._child;
      }
      
      public function loadBitmapData(param1:BitmapData) : void {
         this._bitmap = new Bitmap(param1,"auto",true);
         this._bitmap.smoothing = true;
         if(this._finalized)
         {
            this.reload();
         }
      }
      
      public function get bitmapData() : BitmapData {
         if(this._bitmap != null)
         {
            return this._bitmap.bitmapData.clone();
         }
         return null;
      }
      
      public function stopAllAnimation() : void {
         var _loc1_:DisplayObjectContainer = this._child as DisplayObjectContainer;
         if(_loc1_)
         {
            MovieClipUtils.stopMovieClip(_loc1_);
         }
      }
      
      public function getChildDuration() : uint {
         var _loc3_:uint = 0;
         var _loc4_:DisplayObject = null;
         var _loc5_:MovieClip = null;
         var _loc1_:uint = 0;
         var _loc2_:DisplayObjectContainer = this._child as DisplayObjectContainer;
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.numChildren)
            {
               _loc4_ = DisplayObjectContainer(this._child).getChildAt(_loc3_);
               if((_loc4_ is MovieClip) && (MovieClip(_loc4_).totalFrames) && MovieClip(_loc4_).totalFrames > _loc1_)
               {
                  _loc1_ = MovieClip(_loc4_).totalFrames;
               }
               _loc3_++;
            }
         }
         else
         {
            if(this._child is MovieClip)
            {
               _loc5_ = this._child as MovieClip;
               _loc1_ = _loc5_.totalFrames;
            }
         }
         return _loc1_;
      }
      
      public function gotoAndPayChild(param1:uint) : void {
         var _loc3_:uint = 0;
         var _loc4_:DisplayObject = null;
         var _loc5_:MovieClip = null;
         var _loc2_:DisplayObjectContainer = this._child as DisplayObjectContainer;
         if(_loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.numChildren)
            {
               _loc4_ = DisplayObjectContainer(this._child).getChildAt(_loc3_);
               if(_loc4_ is MovieClip)
               {
                  (_loc4_ as MovieClip).gotoAndPlay(param1);
               }
               _loc3_++;
            }
         }
         else
         {
            if(this._child is MovieClip)
            {
               _loc5_ = this._child as MovieClip;
               _loc5_.gotoAndPlay(param1);
            }
         }
      }
      
      public function colorTransform(param1:ColorTransform, param2:int=0) : void {
         var _loc3_:DisplayObjectContainer = null;
         var _loc4_:* = 0;
         var _loc5_:DisplayObject = null;
         if(param2 == 0)
         {
            transform.colorTransform = param1;
         }
         else
         {
            if(this._child is DisplayObjectContainer)
            {
               _loc3_ = this._child as DisplayObjectContainer;
               _loc4_ = 0;
               while(_loc4_ < param2)
               {
                  if(_loc3_.numChildren > 0)
                  {
                     _loc5_ = _loc3_.getChildAt(0);
                     if(_loc5_ is DisplayObjectContainer)
                     {
                        _loc3_ = _loc5_ as DisplayObjectContainer;
                        _loc4_++;
                        continue;
                     }
                     break;
                  }
                  break;
               }
               _loc3_.transform.colorTransform = param1;
            }
            else
            {
               transform.colorTransform = param1;
            }
         }
      }
      
      public function get roundCornerRadius() : uint {
         return this._roundCornerRadius;
      }
      
      public function set roundCornerRadius(param1:uint) : void {
         this._roundCornerRadius = param1;
         this.initMask();
      }
      
      public function get playOnce() : Boolean {
         return this._playOnce;
      }
      
      public function set playOnce(param1:Boolean) : void {
         if((this._child) && this._child is MovieClip)
         {
            MovieClip(this._child).addFrameScript(MovieClip(this._child).totalFrames-1,param1?this.stopAllAnimation:null);
         }
         this._playOnce = param1;
      }
      
      public function finalize() : void {
         this.reload();
      }
      
      override public function free() : void {
         super.free();
         this._finalized = false;
         this._uri = null;
         this._child = null;
         this._startedWidth = 0;
         this._startedHeight = 0;
         this._forcedHeight = 0;
         this._forcedWidth = 0;
         this._keepRatio = false;
         this._dispatchMessages = false;
         this._autoGrid = false;
         this._forceReload = false;
         this._gotoFrame = null;
         this._loader = null;
         this._startBounds = null;
         this._playOnce = false;
      }
      
      override public function getChildByName(param1:String) : DisplayObject {
         if((this._child) && this._child is DisplayObjectContainer)
         {
            return DisplayObjectContainer(this._child).getChildByName(param1);
         }
         return null;
      }
      
      public function nextFrame() : void {
         var _loc2_:* = 0;
         var _loc1_:MovieClip = this._child as MovieClip;
         if(_loc1_)
         {
            if(_loc1_.currentFrame == _loc1_.totalFrames)
            {
               _loc1_.gotoAndStop(1);
            }
            else
            {
               _loc1_.gotoAndStop(_loc1_.currentFrame + 1);
            }
         }
      }
      
      private function reload() : void {
         var _loc1_:Uri = null;
         var _loc2_:Class = null;
         if(!(this._bitmap == null) && !(this._child == this._bitmap))
         {
            if((this._child) && (this._child.parent))
            {
               this.stopAllAnimation();
               this._child.parent.removeChild(this._child);
               this._child = null;
            }
            this._child = addChild(this._bitmap);
            this._startBounds = this._child.getBounds(this);
            this._startedWidth = this._child.width;
            this._startedHeight = this._child.height;
            this.organize();
            if(this._disableAnimation)
            {
               MovieClipUtils.stopMovieClip(this);
            }
            if((this._dispatchMessages) && (Berilia.getInstance()) && (Berilia.getInstance().handler))
            {
               dispatchEvent(new Event(Event.COMPLETE));
               Berilia.getInstance().handler.process(new TextureReadyMessage(this));
            }
         }
         else
         {
            if(this._uri)
            {
               if(!this._loader)
               {
                  this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
                  this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded,false,0,true);
                  this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onFailed,false,0,true);
               }
               else
               {
                  this._loader.cancel();
               }
               if(this._uri.subPath)
               {
                  if(this._uri.protocol == "mod" || this._uri.protocol == "theme" || this._uri.protocol == "pak" || this._uri.protocol == "d2p" || this._uri.protocol == "pak2" || this._uri.protocol == "d2pOld")
                  {
                     _loc1_ = new Uri(this._uri.normalizedUri);
                  }
                  else
                  {
                     if((AirScanner.hasAir()) && !(this._uri.protocol == "httpc"))
                     {
                        _loc1_ = new Uri(this._uri.path);
                     }
                     else
                     {
                        _loc1_ = this._uri;
                     }
                  }
                  _loc1_.loaderContext = this._uri.loaderContext;
                  this._realUri = _loc1_;
                  if(!(this._uri.protocol == "pak" || this._uri.protocol == "d2p" || this._uri.protocol == "pak2" || this._uri.protocol == "dp2Old"))
                  {
                     _loc2_ = AdvancedSwfAdapter;
                  }
               }
               else
               {
                  _loc1_ = this._uri;
               }
               if((this._uri.protocol == "httpc") && (this.defaultBitmapData) && !this._loader.isInCache(this.uri))
               {
                  this.loadBitmapData(this.defaultBitmapData);
               }
               if(hasEventListener(Event.INIT))
               {
                  dispatchEvent(new Event(Event.INIT));
               }
               this._loader.load(_loc1_,this._useCache?UriCacheFactory.getCacheFromUri(_loc1_):null,_loc2_);
            }
            else
            {
               if(this._child)
               {
                  while(numChildren)
                  {
                     removeChildAt(0);
                  }
                  this._child = null;
               }
               this._finalized = true;
               if(getUi())
               {
                  getUi().iAmFinalized(this);
               }
            }
         }
      }
      
      private function organize() : void {
         var rec:Rectangle = null;
         var ratio:Number = NaN;
         if(!this._child)
         {
            return;
         }
         var rerender:Boolean = false;
         if((this._gotoFrame) && this._child is MovieClip)
         {
            this.gotoAndStop = this._gotoFrame;
         }
         else
         {
            this.gotoAndStop = "0";
         }
         this.playOnce = this._playOnce;
         if(this._autoGrid)
         {
            rec = new Rectangle(this._startedWidth / 3,int(this._startedHeight / 3),this._startedWidth / 3,int(this._startedHeight / 3));
            try
            {
               this._child.scale9Grid = rec;
            }
            catch(e:Error)
            {
               _log.error("Erreur de scale9grid avec " + _uri + ", rect : " + rec);
            }
         }
         if(this._keepRatio)
         {
            ratio = 1;
            if((isNaN(this._forcedWidth)) && (isNaN(this._forcedHeight)))
            {
               this._log.warn("Cannot keep the ratio with no forced dimension.");
            }
            else
            {
               if(isNaN(this._forcedWidth))
               {
                  ratio = this._forcedHeight / this._child.height;
               }
               else
               {
                  if(isNaN(this._forcedHeight))
                  {
                     ratio = this._forcedWidth / this._child.width;
                  }
                  else
                  {
                     if(this._forcedHeight > this._forcedWidth)
                     {
                        ratio = this._child.width / this._forcedWidth;
                     }
                     else
                     {
                        if(this._forcedHeight < this._forcedWidth)
                        {
                           ratio = this._child.height / this._forcedHeight;
                        }
                     }
                  }
               }
               this._child.scaleX = this._child.scaleY = ratio;
            }
         }
         else
         {
            if(!isNaN(this._forcedHeight) && !(this._forcedHeight == 0) && !(this._forcedHeight == this._child.height))
            {
               this._child.height = this._forcedHeight;
            }
            else
            {
               rerender = true;
            }
            if(!isNaN(this._forcedWidth))
            {
               this._child.width = this._forcedWidth;
            }
            else
            {
               rerender = true;
            }
         }
         if(!this._finalized)
         {
            this._finalized = true;
            if(getUi())
            {
               getUi().iAmFinalized(this);
            }
         }
         else
         {
            if((rerender) || true)
            {
               if(getUi())
               {
                  getUi().iAmFinalized(this);
               }
            }
         }
      }
      
      private function initMask() : void {
         if((mask) && mask.parent == this)
         {
            removeChild(mask);
         }
         if(this._roundCornerRadius == 0)
         {
            mask = null;
            return;
         }
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(7798784);
         _loc1_.graphics.drawRoundRectComplex(0,0,this.width,this.height,this._roundCornerRadius,this._roundCornerRadius,this._roundCornerRadius,this._roundCornerRadius);
         addChild(_loc1_);
         mask = _loc1_;
      }
      
      private var rle_uri_path;
      
      private function onLoaded(param1:ResourceLoadedEvent) : void {
         var aswf:ASwf = null;
         var error:ResourceErrorEvent = null;
         var rle:ResourceLoadedEvent = param1;
         if(__removed)
         {
            return;
         }
         if(this._bitmap != null)
         {
            if(this._bitmap.parent == this)
            {
               removeChild(this._bitmap);
            }
            this._bitmap = null;
         }
         var pattern:RegExp = new RegExp("\\/(_[0-9]*_\\/)","i");
         if(this._uri == null || !(this._uri.path == rle.uri.path) && !(this._uri.normalizedUri == rle.uri.path))
         {
            this.rle_uri_path = rle.uri.path;
            return;
         }
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onFailed);
         this._loader = null;
         if((this._child) && (this._child.parent))
         {
            this.stopAllAnimation();
            this._child.parent.removeChild(this._child);
            this._child = null;
         }
         if(rle.resourceType == ResourceType.RESOURCE_SWF)
         {
            if(!rle.resource)
            {
               this._log.warn("Empty SWF : " + rle.uri + " in " + getUi().name);
               return;
            }
            this._child = addChild(rle.resource);
            if(this._child is MovieClip)
            {
               (this._child as MovieClip).stop();
            }
         }
         else
         {
            if(rle.resourceType == ResourceType.RESOURCE_BITMAP)
            {
               this._child = addChild(new Bitmap(rle.resource,"auto",true));
            }
            else
            {
               if(rle.resourceType == ResourceType.RESOURCE_ASWF)
               {
                  aswf = ASwf(rle.resource);
                  if(this._uri.subPath)
                  {
                     try
                     {
                        this._child = addChild(new aswf.applicationDomain.getDefinition(this._uri.subPath) as Class() as DisplayObject);
                     }
                     catch(e:Error)
                     {
                        error = new ResourceErrorEvent(ResourceErrorEvent.ERROR);
                        error.errorCode = ResourceErrorCode.SUB_RESOURCE_NOT_FOUND;
                        error.uri = _uri;
                        error.errorMsg = "Sub ressource \'" + _uri.subPath + "\' not found";
                        onFailed(error);
                        return;
                     }
                  }
                  else
                  {
                     this._child = addChild(aswf.content);
                     if(this._child is MovieClip)
                     {
                        (this._child as MovieClip).stop();
                     }
                  }
               }
               else
               {
                  throw new IllegalOperationError("A Texture component can\'t display a non-displayable resource.");
               }
            }
         }
         if(this._child != null)
         {
            this._startBounds = this._child.getBounds(this);
            this._startedWidth = this._child.width;
            this._startedHeight = this._child.height;
         }
         this.organize();
         if(this._disableAnimation)
         {
            MovieClipUtils.stopMovieClip(this);
         }
         if(hasEventListener(Event.COMPLETE))
         {
            dispatchEvent(new Event(Event.COMPLETE));
         }
         if((this._dispatchMessages) && (Berilia.getInstance()) && (Berilia.getInstance().handler))
         {
            Berilia.getInstance().handler.process(new TextureReadyMessage(this));
         }
         this.initMask();
      }
      
      private function onFailed(param1:ResourceErrorEvent) : void {
         var _loc3_:Shape = null;
         if(__removed)
         {
            return;
         }
         var _loc2_:DynamicSecureObject = new DynamicSecureObject();
         _loc2_.cancel = false;
         if(KernelEventsManager.getInstance().isRegisteredEvent(BeriliaHookList.TextureLoadFailed.name))
         {
            this._finalized = true;
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.TextureLoadFailed,SecureCenter.secure(this,getUi()?getUi().uiModule.trusted:false),_loc2_);
         }
         else
         {
            this._log.error("UI " + (getUi()?getUi().name:"unknow") + ", texture resource not found: " + (param1?param1.errorMsg:"No ressource specified.") + ", requested uri : " + param1.uri);
         }
         dispatchEvent(new TextureLoadFailedEvent(this,_loc2_));
         Berilia.getInstance().handler.process(new TextureLoadFailMessage(this));
         if(!_loc2_.cancel && param1.uri == this._uri)
         {
            this._loader = null;
            if(param1.uri == this._uri)
            {
               if(this._child)
               {
                  while(numChildren)
                  {
                     removeChildAt(0);
                  }
                  this._child = null;
                  this._bitmap = null;
               }
               if(this._showLoadingError)
               {
                  _loc3_ = new Shape();
                  _loc3_.graphics.beginFill(16711935);
                  _loc3_.graphics.drawRect(0,0,!isNaN(this._forcedWidth) && !(this._forcedWidth == 0)?this._forcedWidth:10,!isNaN(this._forcedHeight) && !(this._forcedHeight == 0)?this._forcedHeight:10);
                  _loc3_.graphics.endFill();
                  this._child = addChild(_loc3_);
               }
            }
         }
         this._finalized = true;
         if(getUi())
         {
            getUi().iAmFinalized(this);
         }
      }
      
      override public function remove() : void {
         if(!__removed)
         {
            __removed = true;
            if(this._child)
            {
               this._child.width = this._startedWidth;
               this._child.height = this._startedHeight;
               this._child.scaleX = 1;
               this._child.scaleY = 1;
               if(this._child is MovieClip)
               {
                  MovieClipUtils.stopMovieClip(this._child as MovieClip);
               }
               if(this._child.parent)
               {
                  this._child.parent.removeChild(this._child);
               }
            }
            if((parent) && (parent.contains(this)))
            {
               parent.removeChild(this);
            }
         }
         super.remove();
      }
   }
}
