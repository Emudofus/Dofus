package flashx.textLayout.property
{

    public class PercentPropertyHandler extends PropertyHandler
    {
        private var _minValue:Number;
        private var _maxValue:Number;
        private var _limits:String;

        public function PercentPropertyHandler(param1:String, param2:String, param3:String = "allLimits")
        {
            this._minValue = Property.toNumberIfPercent(param1);
            this._maxValue = Property.toNumberIfPercent(param2);
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
            var _loc_2:* = Property.toNumberIfPercent(param1);
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
            return param1;
        }// end function

    }
}
