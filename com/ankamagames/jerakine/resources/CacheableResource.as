package com.ankamagames.jerakine.resources
{
   public class CacheableResource extends Object
   {
      
      public function CacheableResource(type:uint, resource:*) {
         super();
         this.resourceType = type;
         this.resource = resource;
      }
      
      public var resource;
      
      public var resourceType:uint;
   }
}
