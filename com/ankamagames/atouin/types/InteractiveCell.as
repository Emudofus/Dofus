package com.ankamagames.atouin.types
{
    import flash.display.*;

    public class InteractiveCell extends Object
    {
        public var cellId:uint;
        public var sprite:DisplayObjectContainer;
        public var x:Number;
        public var y:Number;

        public function InteractiveCell(param1:uint, param2:DisplayObjectContainer, param3:Number, param4:Number)
        {
            this.cellId = param1;
            this.sprite = param2;
            this.x = param3;
            this.y = param4;
            return;
        }// end function

    }
}
