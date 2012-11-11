package flashx.textLayout.property
{

    public class UintPropertyHandler extends PropertyHandler
    {

        public function UintPropertyHandler()
        {
            return;
        }// end function

        override public function get customXMLStringHandler() : Boolean
        {
            return true;
        }// end function

        override public function toXMLString(param1:Object) : String
        {
            var _loc_2:* = param1.toString(16);
            if (_loc_2.length < 6)
            {
                _loc_2 = "000000".substr(0, 6 - _loc_2.length) + _loc_2;
            }
            _loc_2 = "#" + _loc_2;
            return _loc_2;
        }// end function

        override public function owningHandlerCheck(param1)
        {
            var _loc_2:* = NaN;
            var _loc_3:* = null;
            if (param1 is uint)
            {
                return param1;
            }
            if (param1 is String)
            {
                _loc_3 = String(param1);
                if (_loc_3.substr(0, 1) == "#")
                {
                    _loc_3 = "0x" + _loc_3.substr(1, (_loc_3.length - 1));
                }
                _loc_2 = _loc_3.toLowerCase().substr(0, 2) == "0x" ? (parseInt(_loc_3)) : (NaN);
            }
            else if (param1 is Number || param1 is int)
            {
                _loc_2 = Number(param1);
            }
            else
            {
                return undefined;
            }
            if (isNaN(_loc_2))
            {
                return undefined;
            }
            if (_loc_2 < 0 || _loc_2 > 4294967295)
            {
                return undefined;
            }
            return _loc_2;
        }// end function

    }
}
