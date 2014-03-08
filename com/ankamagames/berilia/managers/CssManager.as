package com.ankamagames.berilia.managers
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import flash.text.StyleSheet;
   import com.ankamagames.berilia.types.event.CssEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   
   public class CssManager extends Object
   {
      
      public function CssManager() {
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         else
         {
            this._aCss = new Array();
            this._aWaiting = new Array();
            this._aMultiWaiting = new Array();
            this._aLoadingFile = new Array();
            this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
            this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.complete);
            this._loader.addEventListener(ResourceErrorEvent.ERROR,this.error);
            return;
         }
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CssManager));
      
      private static const CSS_ARRAY_KEY:String = "cssFilesContents";
      
      private static var _self:CssManager;
      
      private static var _useCache:Boolean = true;
      
      public static function getInstance() : CssManager {
         if(!_self)
         {
            _self = new CssManager();
         }
         return _self;
      }
      
      public static function set useCache(param1:Boolean) : void {
         _useCache = param1;
         if(!param1)
         {
            clear();
         }
      }
      
      public static function get useCache() : Boolean {
         return _useCache;
      }
      
      public static function clear() : void {
         StoreDataManager.getInstance().clear(BeriliaConstants.DATASTORE_UI_CSS);
      }
      
      private var _aCss:Array;
      
      private var _aWaiting:Array;
      
      private var _aMultiWaiting:Array;
      
      private var _loader:IResourceLoader;
      
      private var _aLoadingFile:Array;
      
      public function getLoadedCss() : Array {
         return this._aCss;
      }
      
      public function load(param1:*) : void {
         var _loc2_:Uri = null;
         var _loc4_:uint = 0;
         var _loc3_:Array = new Array();
         if(param1 is String)
         {
            _loc2_ = new Uri(param1);
            if(!this.exists(_loc2_.uri) && !this.inQueue(_loc2_.uri))
            {
               _loc3_.push(_loc2_);
               this._aLoadingFile[_loc2_.uri] = true;
            }
         }
         else
         {
            if(param1 is Array)
            {
               _loc4_ = 0;
               while(_loc4_ < (param1 as Array).length)
               {
                  _loc2_ = new Uri(param1[_loc4_]);
                  if(!this.exists(_loc2_.uri) && !this.inQueue(_loc2_.uri))
                  {
                     this._aLoadingFile[_loc2_.uri] = true;
                     _loc3_.push(_loc2_);
                  }
                  _loc4_++;
               }
            }
         }
         if(_loc3_.length)
         {
            this._loader.load(_loc3_);
         }
      }
      
      public function exists(param1:String) : Boolean {
         var _loc2_:Uri = new Uri(param1);
         return !(this._aCss[_loc2_.uri] == null);
      }
      
      public function inQueue(param1:String) : Boolean {
         return this._aLoadingFile[param1];
      }
      
      public function askCss(param1:String, param2:Callback) : void {
         var _loc3_:Uri = null;
         var _loc4_:Array = null;
         if(this.exists(param1))
         {
            param2.exec();
         }
         else
         {
            _loc3_ = new Uri(param1);
            if(!this._aWaiting[_loc3_.uri])
            {
               this._aWaiting[_loc3_.uri] = new Array();
            }
            this._aWaiting[_loc3_.uri].push(param2);
            if(param1.indexOf(",") != -1)
            {
               _loc4_ = param1.split(",");
               this._aMultiWaiting[_loc3_.uri] = _loc4_;
               this.load(_loc4_);
            }
            else
            {
               this.load(param1);
            }
         }
      }
      
      public function preloadCss(param1:String) : void {
         if(!this.exists(param1))
         {
            this.load(param1);
         }
      }
      
      public function getCss(param1:String) : ExtendedStyleSheet {
         var _loc2_:Uri = new Uri(param1);
         return this._aCss[_loc2_.uri];
      }
      
      public function merge(param1:Array) : ExtendedStyleSheet {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      protected function init() : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: ExecutionException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      private function parseCss(param1:String, param2:String) : void {
         var _loc3_:Uri = new Uri(param1);
         var _loc4_:StyleSheet = new ExtendedStyleSheet(_loc3_.uri);
         this._aCss[_loc3_.uri] = _loc4_;
         _loc4_.addEventListener(CssEvent.CSS_PARSED,this.onCssParsed);
         _loc4_.parseCSS(param2);
      }
      
      private function updateWaitingMultiUrl(param1:String) : void {
         var _loc2_:* = false;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         for (_loc3_ in this._aMultiWaiting)
         {
            if(this._aMultiWaiting[_loc3_])
            {
               _loc2_ = true;
               _loc4_ = 0;
               while(_loc4_ < this._aMultiWaiting[_loc3_].length)
               {
                  if(this._aMultiWaiting[_loc3_][_loc4_] == param1)
                  {
                     this._aMultiWaiting[_loc3_][_loc4_] = true;
                  }
                  _loc2_ = (_loc2_) && this._aMultiWaiting[_loc3_][_loc4_] === true;
                  _loc4_++;
               }
               if(_loc2_)
               {
                  delete this._aMultiWaiting[[_loc3_]];
                  _loc5_ = _loc3_.split(",");
                  _loc6_ = new Array();
                  _loc7_ = 0;
                  while(_loc7_ < _loc5_.length)
                  {
                     _loc6_.push(this.getCss(_loc5_[_loc7_]));
                     _loc7_++;
                  }
                  this.merge(_loc6_);
                  this.dispatchWaitingCallbabk(_loc3_);
               }
            }
         }
      }
      
      private function dispatchWaitingCallbabk(param1:String) : void {
         var _loc2_:uint = 0;
         if(this._aWaiting[param1])
         {
            _loc2_ = 0;
            while(_loc2_ < this._aWaiting[param1].length)
            {
               Callback(this._aWaiting[param1][_loc2_]).exec();
               _loc2_++;
            }
            delete this._aWaiting[[param1]];
         }
      }
      
      protected function complete(param1:ResourceLoadedEvent) : void {
         var _loc2_:Array = null;
         if(_useCache)
         {
            _loc2_ = StoreDataManager.getInstance().getSetData(BeriliaConstants.DATASTORE_UI_CSS,CSS_ARRAY_KEY,new Array());
            _loc2_[param1.uri.uri] = param1.resource;
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_CSS,CSS_ARRAY_KEY,_loc2_);
         }
         this._aLoadingFile[param1.uri.uri] = false;
         this.parseCss(param1.uri.uri,param1.resource);
      }
      
      protected function error(param1:ResourceErrorEvent) : void {
         ErrorManager.addError("Impossible de trouver la feuille de style (url: " + param1.uri + ")");
         this._aLoadingFile[param1.uri.uri] = false;
         delete this._aWaiting[[param1.uri.uri]];
      }
      
      private function onCssParsed(param1:CssEvent) : void {
         param1.stylesheet.removeEventListener(CssEvent.CSS_PARSED,this.onCssParsed);
         var _loc2_:Uri = new Uri(param1.stylesheet.url);
         this.dispatchWaitingCallbabk(_loc2_.uri);
         this.updateWaitingMultiUrl(_loc2_.uri);
      }
   }
}
