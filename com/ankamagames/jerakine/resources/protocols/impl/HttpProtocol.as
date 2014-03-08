package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.resources.protocols.AbstractProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   
   public class HttpProtocol extends AbstractProtocol implements IProtocol
   {
      
      public function HttpProtocol() {
         super();
      }
      
      public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void {
         getAdapter(param1,param5);
         _adapter.loadDirectly(param1,param1.protocol + "://" + param1.path,param2,param3);
      }
      
      override protected function release() : void {
      }
   }
}
