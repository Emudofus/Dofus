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
      
      public function load(param1:Uri, param2:IResourceObserver, param3:Boolean, param4:ICache, param5:Class, param6:Boolean) : void {
         throw new Error("Unimplemented stub.");
      }
      
      override protected function release() : void {
         throw new Error("Unimplemented stub.");
      }
   }
}
