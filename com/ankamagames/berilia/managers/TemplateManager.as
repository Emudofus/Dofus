package com.ankamagames.berilia.managers
{
   import flash.events.EventDispatcher;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.newCache.impl.Cache;
   import com.ankamagames.jerakine.newCache.garbage.LruGarbageCollector;
   import com.ankamagames.berilia.types.template.XmlTemplate;
   import com.ankamagames.berilia.types.event.TemplateLoadedEvent;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class TemplateManager extends EventDispatcher
   {
      
      public function TemplateManager() {
         super();
         if(_self != null)
         {
            throw new BeriliaError("TemplateManager is a singleton and should not be instanciated directly.");
         }
         else
         {
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.objectLoaded);
            this._loader.addEventListener(ResourceErrorEvent.ERROR,this.objectLoadedFailed);
            this.init();
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TemplateManager));
      
      private static var _self:TemplateManager;
      
      public static function getInstance() : TemplateManager {
         if(_self == null)
         {
            _self = new TemplateManager();
         }
         return _self;
      }
      
      private var _aTemplates:Array;
      
      private var _loader:IResourceLoader;
      
      private var _cache:Cache;
      
      public function init() : void {
         this._aTemplates = new Array();
         this._cache = Cache.create(30,new LruGarbageCollector(),getQualifiedClassName(this));
      }
      
      public function getTemplate(param1:String) : XmlTemplate {
         var _loc2_:Array = param1.split("/");
         var _loc3_:String = _loc2_[_loc2_.length-1];
         if(-1 == _loc3_.indexOf(".xml"))
         {
            _loc3_ = _loc3_ + ".xml";
         }
         return this._aTemplates[_loc3_];
      }
      
      public function isRegistered(param1:String) : Boolean {
         var _loc2_:Array = param1.split("/");
         var _loc3_:String = _loc2_[_loc2_.length-1];
         return !(this._aTemplates[_loc3_] == null);
      }
      
      public function isLoaded(param1:String) : Boolean {
         var _loc2_:Array = param1.split("/");
         var _loc3_:String = _loc2_[_loc2_.length-1];
         return this._aTemplates[_loc3_] is XmlTemplate;
      }
      
      public function areLoaded(param1:Array) : Boolean {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            if(!this.isLoaded(param1[_loc2_]))
            {
               return false;
            }
            _loc2_++;
         }
         return !(param1.length == 0);
      }
      
      public function register(param1:String) : void {
         var _loc2_:Array = param1.split("/");
         var _loc3_:String = _loc2_[_loc2_.length-1];
         if(this.isRegistered(_loc3_))
         {
            if(this.isLoaded(_loc3_))
            {
               dispatchEvent(new TemplateLoadedEvent(param1));
            }
            return;
         }
         this._aTemplates[_loc3_] = false;
         this._loader.load(new Uri(param1));
      }
      
      public function objectLoaded(param1:ResourceLoadedEvent) : void {
         this._aTemplates[param1.uri.fileName] = new XmlTemplate(param1.resource,param1.uri.fileName);
         dispatchEvent(new TemplateLoadedEvent(param1.uri.uri));
      }
      
      public function objectLoadedFailed(param1:ResourceErrorEvent) : void {
         _log.debug("objectLoadedFailed : " + param1.uri + " : " + param1.errorMsg);
      }
   }
}
