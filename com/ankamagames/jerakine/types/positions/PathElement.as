package com.ankamagames.jerakine.types.positions
{

    public class PathElement extends Object
    {
        private var _oStep:MapPoint;
        private var _nOrientation:uint;

        public function PathElement(param1:MapPoint = null, param2:uint = 0)
        {
            if (!param1)
            {
                this._oStep = new MapPoint();
            }
            else
            {
                this._oStep = param1;
            }
            this._nOrientation = param2;
            return;
        }// end function

        public function get orientation() : uint
        {
            return this._nOrientation;
        }// end function

        public function set orientation(param1:uint) : void
        {
            this._nOrientation = param1;
            return;
        }// end function

        public function get step() : MapPoint
        {
            return this._oStep;
        }// end function

        public function set step(param1:MapPoint) : void
        {
            this._oStep = param1;
            return;
        }// end function

        public function get cellId() : uint
        {
            return this._oStep.cellId;
        }// end function

        public function toString() : String
        {
            return "[PathElement(cellId:" + this.cellId + ", x:" + this._oStep.x + ", y:" + this._oStep.y + ", orientation:" + this._nOrientation + ")]";
        }// end function

    }
}
