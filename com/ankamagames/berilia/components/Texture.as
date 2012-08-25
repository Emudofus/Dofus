package com.ankamagames.berilia.components
{
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.components.messages.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.berilia.types.event.*;
    import com.ankamagames.berilia.types.graphic.*;
    import com.ankamagames.berilia.utils.*;
    import com.ankamagames.jerakine.interfaces.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.resources.*;
    import com.ankamagames.jerakine.resources.adapters.impl.*;
    import com.ankamagames.jerakine.resources.events.*;
    import com.ankamagames.jerakine.resources.loaders.*;
    import com.ankamagames.jerakine.types.*;
    import com.ankamagames.jerakine.utils.display.*;
    import com.ankamagames.jerakine.utils.system.*;
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;

    public class Texture extends GraphicContainer implements FinalizableUIComponent, IRectangle
    {
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
        private var _gotoFrame:Object;
        private var _loader:IResourceLoader;
        private var _startBounds:Rectangle;
        private var _disableAnimation:Boolean = false;
        private var _useCache:Boolean = true;
        private var _bitmap:Bitmap;
        private var _showLoadingError:Boolean = true;
        private var _return2:Boolean;
        private var rle_uri_path:Object;
        public static var MEMORY_LOG:Dictionary = new Dictionary(true);

        public function Texture()
        {
            this._log = Log.getLogger(getQualifiedClassName(Texture));
            mouseEnabled = false;
            mouseChildren = false;
            MEMORY_LOG[this] = 1;
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

        public function get uri() : Uri
        {
            return this._uri;
        }// end function

        public function set uri(param1:Uri) : void
        {
            if (param1 != this._uri || this._forceReload)
            {
                this._uri = param1;
            }
            else
            {
                return;
            }
            if (this._finalized)
            {
                this.reload();
            }
            return;
        }// end function

        public function get useCache() : Boolean
        {
            return this._useCache;
        }// end function

        public function set useCache(param1:Boolean) : void
        {
            this._useCache = param1;
            return;
        }// end function

        public function set showLoadingError(param1:Boolean) : void
        {
            this._showLoadingError = param1;
            return;
        }// end function

        public function set disableAnimation(param1:Boolean) : void
        {
            this._disableAnimation = param1;
            if (this._finalized)
            {
                MovieClipUtils.stopMovieClip(this);
            }
            return;
        }// end function

        override public function get height() : Number
        {
            return !isNaN(this._forcedHeight) ? (this._forcedHeight) : (this._child ? (this._child.height) : (0));
        }// end function

        override public function set height(param1:Number) : void
        {
            if (this._forcedHeight == param1)
            {
                return;
            }
            this._forcedHeight = param1;
            if (this._finalized)
            {
                this.organize();
            }
            return;
        }// end function

        override public function get width() : Number
        {
            return !isNaN(this._forcedWidth) ? (this._forcedWidth) : (this._child ? (this._child.width) : (0));
        }// end function

        override public function set width(param1:Number) : void
        {
            if (this._forcedWidth == param1)
            {
                return;
            }
            this._forcedWidth = param1;
            if (this._finalized)
            {
                this.organize();
            }
            return;
        }// end function

        public function get keepRatio() : Boolean
        {
            return this._keepRatio;
        }// end function

        public function set keepRatio(param1:Boolean) : void
        {
            this._keepRatio = param1;
            if (this._finalized)
            {
                this.organize();
            }
            return;
        }// end function

        override public function get scale9Grid() : Rectangle
        {
            if (this._child)
            {
                return this._child.scale9Grid;
            }
            return null;
        }// end function

        override public function set scale9Grid(param1:Rectangle) : void
        {
            if (this._child)
            {
                this._child.scale9Grid = param1;
            }
            return;
        }// end function

        public function vFlip() : void
        {
            var _loc_1:* = x;
            var _loc_2:* = y;
            scaleX = -1;
            x = _loc_1 + this.width;
            return;
        }// end function

        public function hFlip() : void
        {
            var _loc_1:* = x;
            var _loc_2:* = y;
            scaleY = -1;
            y = _loc_2 + this.height;
            return;
        }// end function

        public function get autoGrid() : Boolean
        {
            return this._autoGrid;
        }// end function

        public function set autoGrid(param1:Boolean) : void
        {
            if (param1)
            {
                this._autoGrid = true;
            }
            else
            {
                this._autoGrid = false;
                if (this._child)
                {
                    this._child.scale9Grid = null;
                }
            }
            if (this._finalized)
            {
                this.organize();
            }
            return;
        }// end function

        public function set gotoAndStop(param1) : void
        {
            if (this._child && this._child is MovieClip)
            {
                if (param1)
                {
                    (this._child as MovieClip).gotoAndStop(param1);
                }
                else
                {
                    (this._child as MovieClip).gotoAndStop(1);
                }
            }
            this._gotoFrame = param1;
            return;
        }// end function

        public function get gotoAndStop()
        {
            if (this._child && this._child is MovieClip)
            {
                return (this._child as MovieClip).currentFrame.toString();
            }
            return this._gotoFrame;
        }// end function

        public function set gotoAndPlay(param1) : void
        {
            if (this._child && this._child is MovieClip)
            {
                if (param1)
                {
                    (this._child as MovieClip).gotoAndPlay(param1);
                }
                else
                {
                    (this._child as MovieClip).gotoAndPlay(1);
                }
            }
            return;
        }// end function

        public function get totalFrames() : uint
        {
            if (this._child && this._child is MovieClip)
            {
                return (this._child as MovieClip).totalFrames;
            }
            return 1;
        }// end function

        public function get currentFrame() : uint
        {
            if (this._child && this._child is MovieClip)
            {
                return (this._child as MovieClip).currentFrame;
            }
            return 1;
        }// end function

        public function get dispatchMessages() : Boolean
        {
            return this._dispatchMessages;
        }// end function

        public function set dispatchMessages(param1:Boolean) : void
        {
            this._dispatchMessages = param1;
            return;
        }// end function

        public function get forceReload() : Boolean
        {
            return this._forceReload;
        }// end function

        public function set forceReload(param1:Boolean) : void
        {
            this._forceReload = param1;
            return;
        }// end function

        public function get loading() : Boolean
        {
            return this._loader != null;
        }// end function

        public function get child() : DisplayObject
        {
            return this._child;
        }// end function

        public function loadBitmapData(param1:BitmapData) : void
        {
            this._bitmap = new Bitmap(param1, "auto", true);
            this._bitmap.smoothing = true;
            if (this._finalized)
            {
                this.reload();
            }
            return;
        }// end function

        public function get bitmapData() : BitmapData
        {
            if (this._bitmap != null)
            {
                return this._bitmap.bitmapData.clone();
            }
            var _loc_1:* = new BitmapData(this.width, this.height);
            _loc_1.draw(this);
            return _loc_1.clone();
        }// end function

        public function stopAllAnimation() : void
        {
            var _loc_1:* = this._child as DisplayObjectContainer;
            if (_loc_1)
            {
                MovieClipUtils.stopMovieClip(_loc_1);
            }
            return;
        }// end function

        public function colorTransform(param1:ColorTransform, param2:int = 0) : void
        {
            var _loc_3:DisplayObjectContainer = null;
            var _loc_4:int = 0;
            var _loc_5:DisplayObject = null;
            if (param2 == 0)
            {
                transform.colorTransform = param1;
            }
            else if (this._child is DisplayObjectContainer)
            {
                _loc_3 = this._child as DisplayObjectContainer;
                _loc_4 = 0;
                while (_loc_4 < param2)
                {
                    
                    if (_loc_3.numChildren > 0)
                    {
                        _loc_5 = _loc_3.getChildAt(0);
                        if (_loc_5 is DisplayObjectContainer)
                        {
                            _loc_3 = _loc_5 as DisplayObjectContainer;
                        }
                        else
                        {
                            break;
                        }
                    }
                    else
                    {
                        break;
                    }
                    _loc_4++;
                }
                _loc_3.transform.colorTransform = param1;
            }
            else
            {
                transform.colorTransform = param1;
            }
            return;
        }// end function

        public function finalize() : void
        {
            this.reload();
            return;
        }// end function

        override public function free() : void
        {
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
            return;
        }// end function

        public function nextFrame() : void
        {
            var _loc_2:int = 0;
            var _loc_1:* = this._child as MovieClip;
            if (_loc_1)
            {
                if (_loc_1.currentFrame == _loc_1.totalFrames)
                {
                    _loc_1.gotoAndStop(1);
                }
                else
                {
                    _loc_1.gotoAndStop((_loc_1.currentFrame + 1));
                }
            }
            return;
        }// end function

        private function reload() : void
        {
            var _loc_1:Uri = null;
            var _loc_2:Class = null;
            if (this._bitmap != null)
            {
                if (this._child && this._child.parent)
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
                if (this._disableAnimation)
                {
                    MovieClipUtils.stopMovieClip(this);
                }
                if (this._dispatchMessages && Berilia.getInstance() && Berilia.getInstance().handler)
                {
                    dispatchEvent(new Event(Event.COMPLETE));
                    Berilia.getInstance().handler.process(new TextureReadyMessage(this));
                }
            }
            else if (this._uri)
            {
                if (!this._loader)
                {
                    this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SINGLE_LOADER);
                    this._loader.addEventListener(ResourceLoadedEvent.LOADED, this.onLoaded, false, 0, true);
                    this._loader.addEventListener(ResourceErrorEvent.ERROR, this.onFailed, false, 0, true);
                }
                else
                {
                    this._loader.cancel();
                }
                if (this._uri.subPath)
                {
                    if (this._uri.protocol == "mod" || this._uri.protocol == "pak" || this._uri.protocol == "d2p" || this._uri.protocol == "pak2" || this._uri.protocol == "d2pOld")
                    {
                        _loc_1 = new Uri(this._uri.normalizedUri);
                    }
                    else if (AirScanner.hasAir())
                    {
                        _loc_1 = new Uri(this._uri.path);
                    }
                    else
                    {
                        _loc_1 = this._uri;
                    }
                    _loc_1.loaderContext = this._uri.loaderContext;
                    this._realUri = _loc_1;
                    if (!(this._uri.protocol == "pak" || this._uri.protocol == "d2p" || this._uri.protocol == "pak2" || this._uri.protocol == "dp2Old"))
                    {
                        _loc_2 = AdvancedSwfAdapter;
                    }
                }
                else
                {
                    _loc_1 = this._uri;
                }
                this._loader.load(_loc_1, this._useCache ? (UriCacheFactory.getCacheFromUri(_loc_1)) : (null), _loc_2);
            }
            else
            {
                if (this._child)
                {
                    while (numChildren)
                    {
                        
                        removeChildAt(0);
                    }
                    this._child = null;
                }
                this._finalized = true;
                if (getUi())
                {
                    getUi().iAmFinalized(this);
                }
            }
            return;
        }// end function

        private function organize() : void
        {
            var rec:Rectangle;
            var ratio:Number;
            if (!this._child)
            {
                return;
            }
            var rerender:Boolean;
            if (this._gotoFrame && this._child is MovieClip)
            {
                this.gotoAndStop = this._gotoFrame;
            }
            else
            {
                this.gotoAndStop = "0";
            }
            if (this._autoGrid)
            {
                rec = new Rectangle(this._startedWidth / 3, int(this._startedHeight / 3), this._startedWidth / 3, int(this._startedHeight / 3));
                try
                {
                    this._child.scale9Grid = rec;
                }
                catch (e:Error)
                {
                    _log.error("Erreur de scale9grid avec " + _uri + ", rect : " + rec);
                }
            }
            if (this._keepRatio)
            {
                ratio;
                if (isNaN(this._forcedWidth) && isNaN(this._forcedHeight))
                {
                    this._log.warn("Cannot keep the ratio with no forced dimension.");
                }
                else
                {
                    if (isNaN(this._forcedWidth))
                    {
                        ratio = this._forcedHeight / this._child.height;
                    }
                    else if (isNaN(this._forcedHeight))
                    {
                        ratio = this._forcedWidth / this._child.width;
                    }
                    else if (this._forcedHeight > this._forcedWidth)
                    {
                        ratio = this._child.width / this._forcedWidth;
                    }
                    else if (this._forcedHeight < this._forcedWidth)
                    {
                        ratio = this._child.height / this._forcedHeight;
                    }
                    var _loc_2:* = ratio;
                    this._child.scaleY = ratio;
                    this._child.scaleX = _loc_2;
                }
            }
            else
            {
                if (!isNaN(this._forcedHeight) && this._forcedHeight != 0 && this._forcedHeight != this._child.height)
                {
                    this._child.height = this._forcedHeight;
                }
                else
                {
                    rerender;
                }
                if (!isNaN(this._forcedWidth))
                {
                    this._child.width = this._forcedWidth;
                }
                else
                {
                    rerender;
                }
            }
            if (!this._finalized)
            {
                this._finalized = true;
                if (getUi())
                {
                    getUi().iAmFinalized(this);
                }
            }
            else if (rerender || true)
            {
                if (getUi())
                {
                    getUi().iAmFinalized(this);
                }
            }
            return;
        }// end function

        private function onLoaded(event:ResourceLoadedEvent) : void
        {
            var aswf:ASwf;
            var error:ResourceErrorEvent;
            var rle:* = event;
            this._return2 = false;
            if (__removed)
            {
                return;
            }
            this._loader = null;
            if (!this._uri || this._uri.path != rle.uri.path && this._uri.normalizedUri != rle.uri.path)
            {
                this._return2 = true;
                this.rle_uri_path = rle.uri.path;
                return;
            }
            if (this._child && this._child.parent)
            {
                this.stopAllAnimation();
                this._child.parent.removeChild(this._child);
                this._child = null;
            }
            if (rle.resourceType == ResourceType.RESOURCE_SWF)
            {
                if (!rle.resource)
                {
                    this._log.warn("Empty SWF : " + rle.uri + " in " + getUi().name);
                    return;
                }
                this._child = addChild(rle.resource);
                if (this._child is MovieClip)
                {
                    (this._child as MovieClip).stop();
                }
            }
            else if (rle.resourceType == ResourceType.RESOURCE_BITMAP)
            {
                this._child = addChild(new Bitmap(rle.resource, "auto", true));
            }
            else if (rle.resourceType == ResourceType.RESOURCE_ASWF)
            {
                if (this._uri.subPath)
                {
                    aswf = ASwf(rle.resource);
                    try
                    {
                        this._child = addChild(new (aswf.applicationDomain.getDefinition(this._uri.subPath) as Class)() as DisplayObject);
                    }
                    catch (e:Error)
                    {
                        error = new ResourceErrorEvent(ResourceErrorEvent.ERROR);
                        error.errorCode = ResourceErrorCode.SUB_RESOURCE_NOT_FOUND;
                        error.uri = _uri;
                        error.errorMsg = "Sub ressource \'" + _uri.subPath + "\' not found";
                        onFailed(error);
                        return;
                    }
                }
            }
            else
            {
                throw new IllegalOperationError("A Texture component can\'t display a non-displayable resource.");
            }
            this._startBounds = this._child.getBounds(this);
            this._startedWidth = this._child.width;
            this._startedHeight = this._child.height;
            this.organize();
            if (this._disableAnimation)
            {
                MovieClipUtils.stopMovieClip(this);
            }
            if (this._dispatchMessages && Berilia.getInstance() && Berilia.getInstance().handler)
            {
                dispatchEvent(new Event(Event.COMPLETE));
                Berilia.getInstance().handler.process(new TextureReadyMessage(this));
            }
            return;
        }// end function

        private function onFailed(event:ResourceErrorEvent) : void
        {
            var _loc_3:Shape = null;
            if (__removed)
            {
                return;
            }
            var _loc_2:* = new DynamicSecureObject();
            _loc_2.cancel = false;
            if (KernelEventsManager.getInstance().isRegisteredEvent(BeriliaHookList.TextureLoadFailed.name))
            {
                this._finalized = true;
                KernelEventsManager.getInstance().processCallback(BeriliaHookList.TextureLoadFailed, SecureCenter.secure(this, getUi().uiModule.trusted), _loc_2);
            }
            else
            {
                this._log.error("UI " + (getUi() ? (getUi().name) : ("unknow")) + ", texture resource not found: " + (event ? (event.errorMsg) : ("No ressource specified.")) + ", requested uri : " + event.uri);
            }
            dispatchEvent(new TextureLoadFailedEvent(this, _loc_2));
            if (!_loc_2.cancel && event.uri == this._uri)
            {
                this._loader = null;
                if (event.uri == this._uri)
                {
                    if (this._child)
                    {
                        while (numChildren)
                        {
                            
                            removeChildAt(0);
                        }
                        this._child = null;
                    }
                    if (this._showLoadingError)
                    {
                        _loc_3 = new Shape();
                        _loc_3.graphics.beginFill(16711935);
                        _loc_3.graphics.drawRect(0, 0, !isNaN(this._forcedWidth) && this._forcedWidth != 0 ? (this._forcedWidth) : (10), !isNaN(this._forcedHeight) && this._forcedHeight != 0 ? (this._forcedHeight) : (10));
                        _loc_3.graphics.endFill();
                        this._child = addChild(_loc_3);
                    }
                }
            }
            this._finalized = true;
            if (getUi())
            {
                getUi().iAmFinalized(this);
            }
            return;
        }// end function

        override public function remove() : void
        {
            if (!__removed)
            {
                __removed = true;
                if (this._child)
                {
                    this._child.width = this._startedWidth;
                    this._child.height = this._startedHeight;
                    this._child.scaleX = 1;
                    this._child.scaleY = 1;
                    if (this._child is MovieClip)
                    {
                        MovieClipUtils.stopMovieClip(this._child as MovieClip);
                    }
                    if (this._child.parent)
                    {
                        this._child.parent.removeChild(this._child);
                    }
                }
                if (parent && parent.contains(this))
                {
                    parent.removeChild(this);
                }
            }
            super.remove();
            return;
        }// end function

    }
}
