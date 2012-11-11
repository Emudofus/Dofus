package flashx.textLayout.property
{

    public class SpacingLimitPropertyHandler extends PropertyHandler
    {
        private var _minPercentValue:String;
        private var _maxPercentValue:String;
        private static const _spacingLimitPattern:RegExp = /\d+%""\d+%/g;
        private static const _spacingLimitArrayPattern:RegExp = /^\s*(\d+%)(\s*,\s*)(\d+%)?(\s*,\s*)(\d+%)?\s*$""^\s*(\d+%)(\s*,\s*)(\d+%)?(\s*,\s*)(\d+%)?\s*$/;

        public function SpacingLimitPropertyHandler(param1:String, param2:String)
        {
            this._minPercentValue = param1;
            this._maxPercentValue = param2;
            return;
        }// end function

        override public function get customXMLStringHandler() : Boolean
        {
            return true;
        }// end function

        override public function toXMLString(param1:Object) : String
        {
            if (param1.hasOwnProperty("optimumSpacing") && param1.hasOwnProperty("minimumSpacing") && param1.hasOwnProperty("maximumSpacing"))
            {
                return param1.optimumSpacing.toString() + "," + param1.minimumSpacing.toString() + "," + param1.maximumSpacing.toString();
            }
            return param1.toString();
        }// end function

        override public function owningHandlerCheck(param1)
        {
            if (param1 is String)
            {
                if (_spacingLimitArrayPattern.test(param1))
                {
                    return param1;
                }
            }
            else if (param1.hasOwnProperty("optimumSpacing") && param1.hasOwnProperty("minimumSpacing") && param1.hasOwnProperty("maximumSpacing"))
            {
                return param1;
            }
            return undefined;
        }// end function

        private function checkValue(param1) : Boolean
        {
            var _loc_2:* = Property.toNumberIfPercent(this._minPercentValue);
            var _loc_3:* = Property.toNumberIfPercent(this._maxPercentValue);
            var _loc_4:* = Property.toNumberIfPercent(param1.optimumSpacing);
            if (Property.toNumberIfPercent(param1.optimumSpacing) < _loc_2 || _loc_4 > _loc_3)
            {
                return false;
            }
            var _loc_5:* = Property.toNumberIfPercent(param1.minimumSpacing);
            if (Property.toNumberIfPercent(param1.minimumSpacing) < _loc_2 || _loc_5 > _loc_3)
            {
                return false;
            }
            var _loc_6:* = Property.toNumberIfPercent(param1.maximumSpacing);
            if (Property.toNumberIfPercent(param1.maximumSpacing) < _loc_2 || _loc_6 > _loc_3)
            {
                return false;
            }
            if (_loc_4 < _loc_5 || _loc_4 > _loc_6)
            {
                return false;
            }
            if (_loc_5 > _loc_6)
            {
                return false;
            }
            return true;
        }// end function

        override public function setHelper(param1)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = param1 as String;
            if (_loc_2 == null)
            {
                return param1;
            }
            if (_spacingLimitArrayPattern.test(param1))
            {
                _loc_3 = new Object();
                _loc_4 = _loc_2.match(_spacingLimitPattern);
                if (_loc_4.length == 1)
                {
                    _loc_3.optimumSpacing = _loc_4[0];
                    _loc_3.minimumSpacing = _loc_3.optimumSpacing;
                    _loc_3.maximumSpacing = _loc_3.optimumSpacing;
                }
                else if (_loc_4.length == 3)
                {
                    _loc_3.optimumSpacing = _loc_4[0];
                    _loc_3.minimumSpacing = _loc_4[1];
                    _loc_3.maximumSpacing = _loc_4[2];
                }
                else
                {
                    return undefined;
                }
                if (this.checkValue(_loc_3))
                {
                    return _loc_3;
                }
            }
            return undefined;
        }// end function

    }
}
