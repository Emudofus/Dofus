package com.ankamagames.berilia.types.uiDefinition
{
    import com.ankamagames.berilia.types.graphic.*;

    public class LocationELement extends Object
    {
        public var point:uint;
        public var relativePoint:uint;
        public var relativeTo:String;
        public var type:uint;
        public var offsetX:Number;
        public var offsetY:Number;
        public var offsetXType:uint;
        public var offsetYType:uint;

        public function LocationELement()
        {
            return;
        }// end function

        public function toGraphicLocation() : GraphicLocation
        {
            var _loc_1:* = new GraphicLocation(this.point, this.relativePoint, this.relativeTo);
            _loc_1.offsetXType = this.offsetXType;
            _loc_1.offsetYType = this.offsetYType;
            if (!isNaN(this.offsetX))
            {
                _loc_1.setOffsetX(this.offsetX);
            }
            if (!isNaN(this.offsetY))
            {
                _loc_1.setOffsetY(this.offsetY);
            }
            return _loc_1;
        }// end function

    }
}
