package com.ankamagames.tiphon.types
{
    import flash.display.*;

    public class SubEntityTempInfo extends Object
    {
        public var entity:DisplayObject;
        public var category:int;
        public var slot:int;

        public function SubEntityTempInfo(param1:DisplayObject, param2:int, param3:int)
        {
            this.entity = param1;
            this.category = param2;
            this.slot = param3;
            return;
        }// end function

    }
}
