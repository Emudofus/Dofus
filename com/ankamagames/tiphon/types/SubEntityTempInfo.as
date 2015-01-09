package com.ankamagames.tiphon.types
{
    import flash.display.DisplayObject;

    public class SubEntityTempInfo 
    {

        public var entity:DisplayObject;
        public var category:int;
        public var slot:int;

        public function SubEntityTempInfo(entity:DisplayObject, category:int, slot:int)
        {
            this.entity = entity;
            this.category = category;
            this.slot = slot;
        }

    }
}//package com.ankamagames.tiphon.types

