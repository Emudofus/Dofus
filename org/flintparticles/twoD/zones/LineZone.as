package org.flintparticles.twoD.zones
{
    import flash.geom.*;
    import org.flintparticles.twoD.zones.*;

    public class LineZone extends Object implements Zone2D
    {
        private var _point1:Point;
        private var _point2:Point;
        private var _length:Point;

        public function LineZone(param1:Point, param2:Point)
        {
            this._point1 = param1;
            this._point2 = param2;
            this._length = param2.subtract(param1);
            return;
        }// end function

        public function get point1() : Point
        {
            return this._point1;
        }// end function

        public function set point1(param1:Point) : void
        {
            this._point1 = param1;
            this._length = this.point2.subtract(this.point1);
            return;
        }// end function

        public function get point2() : Point
        {
            return this._point2;
        }// end function

        public function set point2(param1:Point) : void
        {
            this._point2 = param1;
            this._length = this.point2.subtract(this.point1);
            return;
        }// end function

        public function contains(param1:Number, param2:Number) : Boolean
        {
            if ((param1 - this._point1.x) * this._length.y - (param2 - this._point1.y) * this._length.x != 0)
            {
                return false;
            }
            return (param1 - this._point1.x) * (param1 - this._point2.x) + (param2 - this._point1.y) * (param2 - this._point2.y) <= 0;
        }// end function

        public function getLocation() : Point
        {
            var _loc_1:* = this._point1.clone();
            var _loc_2:* = Math.random();
            _loc_1.x = _loc_1.x + this._length.x * _loc_2;
            _loc_1.y = _loc_1.y + this._length.y * _loc_2;
            return _loc_1;
        }// end function

        public function getArea() : Number
        {
            return this._length.length;
        }// end function

    }
}
