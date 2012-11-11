package com.ankamagames.berilia.types.data
{
    import flash.display.*;

    public class GridItem extends Object
    {
        public var index:uint;
        public var container:DisplayObject;
        public var data:Object;

        public function GridItem(param1:uint, param2:DisplayObject, param3)
        {
            this.index = param1;
            this.container = param2;
            this.data = param3;
            return;
        }// end function

    }
}
