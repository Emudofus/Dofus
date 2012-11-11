package com.ankamagames.atouin.types
{
    import flash.display.*;

    public class CellContainer extends Sprite
    {
        public var cellId:uint = 0;
        public var startX:int = 0;
        public var startY:int = 0;
        public var depth:int = 0;
        public var layerId:int = 0;

        public function CellContainer(param1:uint)
        {
            this.cellId = param1;
            name = "Cell_" + this.cellId;
            return;
        }// end function

    }
}
