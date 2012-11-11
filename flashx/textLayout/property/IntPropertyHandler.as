package flashx.textLayout.property
{

    public class IntPropertyHandler extends PropertyHandler
    {
        private var _minValue:int;
        private var _maxValue:int;
        private var _limits:String;

        public function IntPropertyHandler(param1:int, param2:int, param3:String = "allLimits")
        {
            this._minValue = param1;
            this._maxValue = param2;
            this._limits = param3;
            return;
        }// end function

        public function get minValue() : int
        {
            return this._minValue;
        }// end function

        public function get maxValue() : int
        {
            return this._maxValue;
        }// end function

        public function checkLowerLimit() : Boolean
        {
            return this._limits == Property.ALL_LIMITS || this._limits == Property.LOWER_LIMIT;
        }// end function

        public function checkUpperLimit() : Boolean
        {
            return this._limits == Property.ALL_LIMITS || this._limits == Property.UPPER_LIMIT;
        }// end function

        override public function owningHandlerCheck(param1)
        {
            var _loc_2:* = param1 is String ? (parseInt(param1)) : (int(param1));
            if (isNaN(_loc_2))
            {
                return undefined;
            }
            var _loc_3:* = int(_loc_2);
            if (this.checkLowerLimit() && _loc_3 < this._minValue)
            {
                return undefined;
            }
            if (this.checkUpperLimit() && _loc_3 > this._maxValue)
            {
                return undefined;
            }
            return _loc_3;
        }// end function

    }
}
