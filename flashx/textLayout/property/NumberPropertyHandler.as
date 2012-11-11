package flashx.textLayout.property
{

    public class NumberPropertyHandler extends PropertyHandler
    {
        private var _minValue:Number;
        private var _maxValue:Number;
        private var _limits:String;

        public function NumberPropertyHandler(param1:Number, param2:Number, param3:String = "allLimits")
        {
            this._minValue = param1;
            this._maxValue = param2;
            this._limits = param3;
            return;
        }// end function

        public function get minValue() : Number
        {
            return this._minValue;
        }// end function

        public function get maxValue() : Number
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
            var _loc_2:* = param1 is String ? (parseFloat(param1)) : (Number(param1));
            if (isNaN(_loc_2))
            {
                return undefined;
            }
            if (this.checkLowerLimit() && _loc_2 < this._minValue)
            {
                return undefined;
            }
            if (this.checkUpperLimit() && _loc_2 > this._maxValue)
            {
                return undefined;
            }
            return _loc_2;
        }// end function

        public function clampToRange(param1:Number) : Number
        {
            if (this.checkLowerLimit() && param1 < this._minValue)
            {
                return this._minValue;
            }
            if (this.checkUpperLimit() && param1 > this._maxValue)
            {
                return this._maxValue;
            }
            return param1;
        }// end function

    }
}
