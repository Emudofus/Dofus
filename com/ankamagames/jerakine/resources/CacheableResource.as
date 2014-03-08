package com.ankamagames.jerakine.resources
{
   public class CacheableResource extends Object
   {
      
      public function CacheableResource(param1:uint, param2:*) {
         super();
         this.resourceType = param1;
         this.resource = param2;
      }
      
      public var resource;
      
      public var resourceType:uint;
   }
}
