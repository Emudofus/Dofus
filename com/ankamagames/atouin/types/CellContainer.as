package com.ankamagames.atouin.types
{
    import com.ankamagames.atouin.types.*;
    import com.ankamagames.jerakine.data.*;
    import flash.display.*;
    import flash.geom.*;

    public class CellContainer extends Sprite implements ICellContainer
    {
        private var _cellId:int = 0;
        private var _layerId:int = 0;
        private var _startX:int = 0;
        private var _startY:int = 0;
        private var _depth:int = 0;
        private static var _ratio:Number;
        private static var cltr:ColorTransform;

        public function CellContainer(param1:uint)
        {
            this.cellId = param1;
            name = "Cell_" + this.cellId;
            return;
        }// end function

        public function get cellId() : uint
        {
            return this._cellId;
        }// end function

        public function set cellId(param1:uint) : void
        {
            this._cellId = param1;
            return;
        }// end function

        public function get layerId() : int
        {
            return this._layerId;
        }// end function

        public function set layerId(param1:int) : void
        {
            this._layerId = param1;
            return;
        }// end function

        public function get startX() : int
        {
            return this._startX;
        }// end function

        public function set startX(param1:int) : void
        {
            this._startX = param1;
            return;
        }// end function

        public function get startY() : int
        {
            return this._startY;
        }// end function

        public function set startY(param1:int) : void
        {
            this._startY = param1;
            return;
        }// end function

        public function get depth() : int
        {
            return this._depth;
        }// end function

        public function set depth(param1:int) : void
        {
            this._depth = param1;
            return;
        }// end function

        public function addFakeChild(param1:Object, param2:Object, param3:Object) : void
        {
            var _loc_5:* = undefined;
            if (isNaN(_ratio))
            {
                _loc_5 = XmlConfig.getInstance().getEntry("config.gfx.world.scaleRatio");
                _ratio = _loc_5 == null ? (1) : (parseFloat(_loc_5));
            }
            var _loc_4:* = param1 as DisplayObject;
            if (param1 is Bitmap)
            {
                _loc_4.x = param2.x * _ratio;
                _loc_4.y = param2.y * _ratio;
            }
            else
            {
                _loc_4.x = param2.x;
                _loc_4.y = param2.y;
            }
            if (param2 != null)
            {
                _loc_4.alpha = param2.alpha;
                _loc_4.scaleX = param2.scaleX;
                _loc_4.scaleY = param2.scaleY;
            }
            if (param3 != null)
            {
                if (cltr == null)
                {
                    cltr = new ColorTransform();
                }
                cltr.redMultiplier = param3.red;
                cltr.greenMultiplier = param3.green;
                cltr.blueMultiplier = param3.blue;
                cltr.alphaMultiplier = param3.alpha;
                _loc_4.transform.colorTransform = cltr;
            }
            addChild(_loc_4);
            return;
        }// end function

    }
}
