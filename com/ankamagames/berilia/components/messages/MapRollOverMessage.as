package com.ankamagames.berilia.components.messages
{
    import flash.display.*;

    public class MapRollOverMessage extends ComponentMessage
    {
        private var _x:int;
        private var _y:int;

        public function MapRollOverMessage(param1:InteractiveObject, param2:int, param3:int)
        {
            super(param1);
            this._x = param2;
            this._y = param3;
            return;
        }// end function

        public function get x() : int
        {
            return this._x;
        }// end function

        public function get y() : int
        {
            return this._y;
        }// end function

    }
}
