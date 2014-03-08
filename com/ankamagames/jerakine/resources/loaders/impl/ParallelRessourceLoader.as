package com.ankamagames.jerakine.resources.loaders.impl
{
   import com.ankamagames.jerakine.resources.loaders.AbstractRessourceLoader;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.newCache.ICache;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.resources.protocols.ProtocolFactory;
   import com.ankamagames.jerakine.resources.events.ResourceProgressEvent;
   
   public class ParallelRessourceLoader extends AbstractRessourceLoader implements IResourceLoader, IResourceObserver
   {
      
      public function ParallelRessourceLoader(param1:uint) {
         super();
         this._maxParallel = param1;
         this._loadDictionnary = new Dictionary(true);
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      private var _maxParallel:uint;
      
      private var _uris:Array;
      
      private var _currentlyLoading:uint;
      
      private var _loadDictionnary:Dictionary;
      
      public function load(param1:*, param2:ICache=null, param3:Class=null, param4:Boolean=false) : void {
         var _loc5_:Array = null;
         var _loc7_:Uri = null;
         if(param1 is Uri)
         {
            _loc5_ = [param1];
         }
         else
         {
            if(param1 is Array)
            {
               _loc5_ = param1;
            }
            else
            {
               throw new ArgumentError("URIs must be an array or an Uri instance.");
            }
         }
         var _loc6_:* = false;
         if(this._uris != null)
         {
            for each (_loc7_ in _loc5_)
            {
               this._uris.push(
                  {
                     "uri":_loc7_,
                     "forcedAdapter":param3,
                     "singleFile":param4
                  });
            }
            if(this._currentlyLoading == 0)
            {
               _loc6_ = true;
            }
         }
         else
         {
            this._uris = new Array();
            for each (_loc7_ in _loc5_)
            {
               this._uris.push(
                  {
                     "uri":_loc7_,
                     "forcedAdapter":param3,
                     "singleFile":param4
                  });
            }
            _loc6_ = true;
         }
         _cache = param2;
         _completed = false;
         _filesTotal = _filesTotal + this._uris.length;
         if(_loc6_)
         {
            this.loadNextUris();
         }
      }
      
      override public function cancel() : void {
         var _loc1_:IProtocol = null;
         super.cancel();
         for each (_loc1_ in this._loadDictionnary)
         {
            if(_loc1_)
            {
               _loc1_.free();
               _loc1_.cancel();
               _loc1_ = null;
            }
         }
         this._loadDictionnary = new Dictionary(true);
         this._currentlyLoading = 0;
         this._uris = [];
      }
      
      private function loadNextUris() : void {
         var _loc3_:Object = null;
         var _loc4_:IProtocol = null;
         if(this._uris.length == 0)
         {
            this._uris = null;
            return;
         }
         this._currentlyLoading = Math.min(this._maxParallel,this._uris.length);
         var _loc1_:uint = this._currentlyLoading;
         var _loc2_:uint = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._uris.shift();
            if(!checkCache(_loc3_.uri))
            {
               _loc4_ = ProtocolFactory.getProtocol(_loc3_.uri);
               this._loadDictionnary[_loc3_.uri] = _loc4_;
               _loc4_.load(_loc3_.uri,this,hasEventListener(ResourceProgressEvent.PROGRESS),_cache,_loc3_.forcedAdapter,_loc3_.singleFile);
            }
            else
            {
               this.decrementLoads();
            }
            _loc2_++;
         }
      }
      
      private function decrementLoads() : void {
         this._currentlyLoading--;
         if(this._currentlyLoading == 0)
         {
            this.loadNextUris();
         }
      }
      
      override public function onLoaded(param1:Uri, param2:uint, param3:*) : void {
         super.onLoaded(param1,param2,param3);
         delete this._loadDictionnary[[param1]];
         this.decrementLoads();
      }
      
      override public function onFailed(param1:Uri, param2:String, param3:uint) : void {
         super.onFailed(param1,param2,param3);
         delete this._loadDictionnary[[param1]];
         this.decrementLoads();
      }
   }
}
