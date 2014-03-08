package com.ankamagames.tiphon.engine
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.newCache.impl.InfiniteCache;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import flash.utils.Timer;
   import com.ankamagames.tiphon.types.GraphicLibrary;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.tiphon.types.AnimLibrary;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.tiphon.events.SwlEvent;
   import flash.events.Event;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import __AS3__.vec.*;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class LibrariesManager extends EventDispatcher
   {
      
      public function LibrariesManager(param1:String, param2:uint) {
         this._waitingResources = new Vector.<Uri>();
         this._libCurrentlyUsed = new Dictionary(true);
         super();
         this.name = param1;
         this._aResources = new Dictionary();
         this._aResourceLoadFail = new Dictionary();
         this._aResourceStates = new Array();
         this._aWaiting = new Array();
         this._aWaitingResourceUri = new Dictionary();
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoadResource);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadFailedResource);
         this._type = param2;
         numLM++;
      }
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(LibrariesManager));
      
      public static const TYPE_BONE:uint = 0;
      
      public static const TYPE_SKIN:uint = 1;
      
      private static var _cache:InfiniteCache = new InfiniteCache();
      
      private static var _uri:Uri;
      
      private static var numLM:int = 0;
      
      private var _aResources:Dictionary;
      
      private var _aResourceLoadFail:Dictionary;
      
      private var _aResourcesUri:Array;
      
      private var _aResourceStates:Array;
      
      private var _aWaiting:Array;
      
      private var _aWaitingResourceUri:Dictionary;
      
      private var _loader:IResourceLoader;
      
      private var _waitingResources:Vector.<Uri>;
      
      private var _type:uint;
      
      private var _GarbageCollectorTimer:Timer;
      
      private var _currentCacheSize:int = 0;
      
      private var _libCurrentlyUsed:Dictionary;
      
      public var name:String;
      
      public function addResource(param1:uint, param2:Uri) : void {
         var _loc3_:GraphicLibrary = null;
         if(param2 == null)
         {
            param2 = new Uri(TiphonConstants.SWF_SKULL_PATH + "666.swl");
         }
         if(!this._aResources[param1])
         {
            if(this._type == TYPE_BONE)
            {
               _loc3_ = new AnimLibrary(param1,true);
            }
            else
            {
               _loc3_ = new GraphicLibrary(param1,false);
            }
            this._aResources[param1] = _loc3_;
         }
         else
         {
            _loc3_ = this._aResources[param1];
         }
         if(!_loc3_.hasSwl(param2))
         {
            if(param2.tag == null)
            {
               param2.tag = new Object();
            }
            param2.tag.id = param1;
            _loc3_.updateSwfState(param2);
            this._waitingResources.push(param2);
         }
      }
      
      public function askResource(param1:uint, param2:String=null, param3:Callback=null, param4:Callback=null) : void {
         var _loc5_:GraphicLibrary = null;
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:* = false;
         var _loc9_:Callback = null;
         var _loc10_:* = false;
         var _loc11_:uint = 0;
         if(!this.hasResource(param1,param2))
         {
            return;
         }
         _loc5_ = this._aResources[param1];
         if(_loc5_.hasClassAvaible(param2))
         {
            if(param3 != null)
            {
               param3.exec();
            }
         }
         else
         {
            if(!this._aWaiting[param1])
            {
               this._aWaiting[param1] = new Object();
               this._aWaiting[param1]["ok"] = new Array();
               this._aWaiting[param1]["ko"] = new Array();
            }
            if(this._type == TYPE_BONE && (BoneIndexManager.getInstance().hasCustomBone(param1)))
            {
               _loc6_ = BoneIndexManager.getInstance().getBoneFile(param1,param2).uri;
            }
            _loc7_ = this._aWaiting[param1]["ok"];
            _loc8_ = true;
            for each (_loc9_ in _loc7_)
            {
               if(_loc9_.method == param3.method && param3.args.length == _loc9_.args.length)
               {
                  _loc10_ = true;
                  while(_loc11_ < _loc9_.args.length)
                  {
                     if(_loc9_.args[_loc11_] != param3.args[_loc11_])
                     {
                        _loc10_ = false;
                        break;
                     }
                     _loc11_++;
                  }
                  if((_loc10_) && (!_loc6_ || this._aWaitingResourceUri[_loc9_] == _loc6_))
                  {
                     _loc8_ = false;
                     break;
                  }
               }
            }
            if(_loc8_)
            {
               if(_loc6_)
               {
                  this._aWaitingResourceUri[param3] = _loc6_;
               }
               this._aWaiting[param1]["ok"].push(param3);
            }
            if(param4)
            {
               this._aWaiting[param1]["ko"].push(param4);
            }
            while(this._waitingResources.length)
            {
               this._loader.load(this._waitingResources.shift(),_cache);
            }
         }
      }
      
      public function removeResource(param1:uint) : void {
         if(this._aWaiting[param1])
         {
            delete this._aWaiting[[param1]];
         }
         delete this._aResources[[param1]];
      }
      
      public function isLoaded(param1:uint, param2:String=null) : Boolean {
         if(this._aResources[param1] == false)
         {
            return false;
         }
         var _loc3_:GraphicLibrary = this._aResources[param1];
         if(param2)
         {
            return !(_loc3_ == null) && (_loc3_.hasClassAvaible(param2));
         }
         return (_loc3_) && !(_loc3_.getSwl() == null);
      }
      
      public function hasError(param1:uint) : Boolean {
         return this._aResourceLoadFail[param1];
      }
      
      public function hasResource(param1:uint, param2:String=null) : Boolean {
         var _loc3_:GraphicLibrary = this._aResources[param1];
         return (_loc3_) && (_loc3_.hasClass(param2));
      }
      
      public function getResourceById(param1:uint, param2:String=null, param3:Boolean=false) : Swl {
         var _loc5_:Swl = null;
         var _loc4_:GraphicLibrary = this._aResources[param1];
         if((_loc4_.isSingleFile) && !param3)
         {
            _loc5_ = _loc4_.getSwl(null);
         }
         _loc5_ = _loc4_.getSwl(param2,param3);
         if(_loc5_ == null && (param3))
         {
            _loc4_.addEventListener(SwlEvent.SWL_LOADED,this.onSwfLoaded);
         }
         return _loc5_;
      }
      
      private function onSwfLoaded(param1:Event) : void {
         param1.currentTarget.removeEventListener(SwlEvent.SWL_LOADED,this.onSwfLoaded);
         dispatchEvent(param1);
      }
      
      public function hasAnim(param1:int, param2:String, param3:int=-1) : Boolean {
         var _loc5_:* = false;
         var _loc6_:String = null;
         var _loc4_:GraphicLibrary = this._aResources[param1];
         if((_loc4_) && (_loc4_.isSingleFile))
         {
            _loc5_ = false;
            if(!_loc4_.getSwl())
            {
               _log.info("On test si une librairie contient une anim sans l\'avoir en mémoire. (bones: " + param1 + ", anim:" + param2 + ")");
               return false;
            }
            for each (_loc6_ in _loc4_.getSwl().getDefinitions())
            {
               if(_loc6_.indexOf(param2 + (param3 != -1?"_" + param3:"")) == 0)
               {
                  _loc5_ = true;
               }
            }
            return _loc5_;
         }
         return BoneIndexManager.getInstance().hasAnim(param1,param2,param3);
      }
      
      private function onLoadResource(param1:ResourceLoadedEvent) : void {
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:Callback = null;
         var _loc6_:Vector.<Callback> = null;
         var _loc2_:int = param1.uri.tag.id == null?param1.uri.tag:param1.uri.tag.id;
         _log.info("Loaded " + param1.uri);
         GraphicLibrary(this._aResources[_loc2_]).addSwl(param1.resource,param1.uri.uri);
         if((this._aWaiting[_loc2_]) && (this._aWaiting[_loc2_]["ok"]))
         {
            _loc3_ = this._aWaiting[_loc2_]["ok"].length;
            _loc6_ = new Vector.<Callback>(0);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = Callback(this._aWaiting[_loc2_]["ok"][_loc4_]);
               if((_loc5_) && (!this._aWaitingResourceUri[_loc5_] || this._aWaitingResourceUri[_loc5_] == param1.uri.uri))
               {
                  _loc5_.exec();
                  _loc6_.push(_loc5_);
               }
               _loc4_++;
            }
            for each (_loc5_ in _loc6_)
            {
               this._aWaiting[_loc2_]["ok"].splice(this._aWaiting[_loc2_]["ok"].indexOf(_loc5_),1);
               delete this._aWaitingResourceUri[[_loc5_]];
            }
            if(this._aWaiting[_loc2_]["ok"].length == 0)
            {
               delete this._aWaiting[[_loc2_]];
            }
         }
      }
      
      private function onLoadFailedResource(param1:ResourceErrorEvent) : void {
         var _loc3_:Array = null;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc2_:int = isNaN(param1.uri.tag)?param1.uri.tag.id:param1.uri.tag;
         _log.error("Unable to load " + param1.uri + " (" + param1.errorMsg + ")");
         delete this._aResources[[_loc2_]];
         this._aResourceLoadFail[_loc2_] = true;
         this.addResource(_loc2_,_uri);
         if(this._aWaiting[_loc2_])
         {
            _loc3_ = this._aWaiting[_loc2_]["ko"];
            if(_loc3_)
            {
               _loc4_ = _loc3_.length;
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  (_loc3_[_loc5_] as Callback).exec();
                  _loc5_++;
               }
               delete this._aWaiting[[_loc2_]];
            }
         }
      }
   }
}
