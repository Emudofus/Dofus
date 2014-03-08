package com.ankamagames.jerakine.resources.loaders.impl
{
   import com.ankamagames.jerakine.resources.loaders.AbstractRessourceLoader;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.newCache.ICache;
   import flash.errors.IllegalOperationError;
   import com.ankamagames.jerakine.resources.protocols.ProtocolFactory;
   import com.ankamagames.jerakine.resources.events.ResourceProgressEvent;
   
   public class SingleRessourceLoader extends AbstractRessourceLoader implements IResourceLoader, IResourceObserver
   {
      
      public function SingleRessourceLoader() {
         super();
      }
      
      private var _uri:Uri;
      
      private var _protocol:IProtocol;
      
      public function load(param1:*, param2:ICache=null, param3:Class=null, param4:Boolean=false) : void {
         if(this._uri != null)
         {
            throw new IllegalOperationError("A single ressource loader can\'t handle more than one load at a time.");
         }
         else
         {
            if(param1 == null)
            {
               throw new ArgumentError("Can\'t load a null uri.");
            }
            else
            {
               if(!(param1 is Uri))
               {
                  throw new ArgumentError("Can\'t load an array of URIs when using a LOADER_SINGLE loader.");
               }
               else
               {
                  this._uri = param1;
                  _cache = param2;
                  _completed = false;
                  _filesTotal = 1;
                  if(!checkCache(this._uri))
                  {
                     this._protocol = ProtocolFactory.getProtocol(this._uri);
                     this._protocol.load(this._uri,this,hasEventListener(ResourceProgressEvent.PROGRESS),_cache,param3,param4);
                  }
                  return;
               }
            }
         }
      }
      
      override public function cancel() : void {
         super.cancel();
         if(this._protocol)
         {
            this._protocol.cancel();
            this._protocol = null;
         }
         this._uri = null;
      }
      
      override public function onLoaded(param1:Uri, param2:uint, param3:*) : void {
         super.onLoaded(param1,param2,param3);
         this._protocol = null;
      }
      
      override public function onFailed(param1:Uri, param2:String, param3:uint) : void {
         super.onFailed(param1,param2,param3);
         this._protocol = null;
      }
   }
}
