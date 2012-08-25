package com.ankamagames.tiphon.types
{

    public class TiphonEventInfo extends Object
    {
        public var type:String;
        private var _label:String;
        private var _sprite:Object;
        private var _params:String;
        private var _animationType:String;
        private var _direction:int = -1;

        public function TiphonEventInfo(param1:String, param2:String = "")
        {
            this.type = param1;
            this._params = param2;
            return;
        }// end function

        public function set label(param1:String) : void
        {
            this._label = param1;
            return;
        }// end function

        public function get label() : String
        {
            return this._label;
        }// end function

        public function get sprite()
        {
            return this._sprite;
        }// end function

        public function get params() : String
        {
            return this._params;
        }// end function

        public function get animationType() : String
        {
            if (this._animationType == null)
            {
                return "undefined";
            }
            return this._animationType;
        }// end function

        public function get direction() : int
        {
            return this._direction;
        }// end function

        public function get animationName() : String
        {
            return this._animationType + "_" + this._direction;
        }// end function

        public function set animationName(param1:String) : void
        {
            var _loc_2:* = param1.split("_");
            var _loc_3:* = _loc_2.length;
            this._animationType = "";
            var _loc_4:uint = 0;
            while (_loc_4 < (_loc_3 - 1))
            {
                
                if (_loc_4 > 0)
                {
                    this._animationType = this._animationType + ("_" + _loc_2[_loc_4]);
                }
                else
                {
                    this._animationType = _loc_2[_loc_4];
                }
                _loc_4 = _loc_4 + 1;
            }
            this._direction = _loc_2[(_loc_2.length - 1)];
            if (this._direction == 3)
            {
                this._direction = 1;
            }
            if (this._direction == 7)
            {
                this._direction = 5;
            }
            return;
        }// end function

        public function duplicate() : TiphonEventInfo
        {
            return new TiphonEventInfo(this.type, this._params);
        }// end function

        public function destroy() : void
        {
            this._sprite = null;
            return;
        }// end function

    }
}
