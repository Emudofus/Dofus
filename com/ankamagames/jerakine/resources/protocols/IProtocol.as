package com.ankamagames.jerakine.resources.protocols
{
   import com.ankamagames.jerakine.pools.Poolable;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   
   public interface IProtocol extends Poolable
   {
      
      function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void;
      
      function cancel() : void;
   }
}
