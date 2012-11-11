package com.ankamagames.jerakine.resources
{

    public class CacheableResource extends Object
    {
        public var resource:Object;
        public var resourceType:uint;

        public function CacheableResource(param1:uint, param2)
        {
            this.resourceType = param1;
            this.resource = param2;
            return;
        }// end function

    }
}
