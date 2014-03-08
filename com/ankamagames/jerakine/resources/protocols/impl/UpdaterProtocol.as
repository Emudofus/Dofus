package com.ankamagames.jerakine.resources.protocols.impl
{
   import com.ankamagames.jerakine.resources.protocols.AbstractProtocol;
   import com.ankamagames.jerakine.resources.protocols.IProtocol;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.newCache.ICache;
   
   public class UpdaterProtocol extends AbstractProtocol implements IProtocol
   {
      
      public function UpdaterProtocol() {
         super();
      }
      
      public function load(uri:Uri, observer:IResourceObserver, dispatchProgress:Boolean, cache:ICache, forcedAdapter:Class, uniqueFile:Boolean) : void {
         throw new Error("Unimplemented stub.");
      }
      
      override protected function release() : void {
         throw new Error("Unimplemented stub.");
      }
   }
}
