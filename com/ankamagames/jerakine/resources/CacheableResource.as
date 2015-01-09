package com.ankamagames.jerakine.resources
{
    public class CacheableResource 
    {

        public var resource;
        public var resourceType:uint;

        public function CacheableResource(type:uint, resource:*)
        {
            this.resourceType = type;
            this.resource = resource;
        }

    }
}//package com.ankamagames.jerakine.resources

