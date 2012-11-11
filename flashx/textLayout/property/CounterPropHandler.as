package flashx.textLayout.property
{

    public class CounterPropHandler extends PropertyHandler
    {
        private var _defaultNumber:int;
        private static const _orderedPattern:RegExp = /^\s*ordered(\s+-?\d+){0,1}\s*$""^\s*ordered(\s+-?\d+){0,1}\s*$/;
        private static const _orderedBeginPattern:RegExp = /^\s*ordered\s*""^\s*ordered\s*/g;

        public function CounterPropHandler(param1:int)
        {
            this._defaultNumber = param1;
            return;
        }// end function

        public function get defaultNumber() : int
        {
            return this._defaultNumber;
        }// end function

        override public function get customXMLStringHandler() : Boolean
        {
            return true;
        }// end function

        override public function toXMLString(param1:Object) : String
        {
            return param1["ordered"] == 1 ? ("ordered") : ("ordered " + param1["ordered"]);
        }// end function

        override public function owningHandlerCheck(param1)
        {
            return param1 is String && _orderedPattern.test(param1) || param1.hasOwnProperty("ordered") ? (param1) : (undefined);
        }// end function

        override public function setHelper(param1)
        {
            var _loc_2:* = param1 as String;
            if (_loc_2 == null)
            {
                return param1;
            }
            _orderedBeginPattern.lastIndex = 0;
            _orderedBeginPattern.test(_loc_2);
            var _loc_3:* = _orderedBeginPattern.lastIndex != _loc_2.length ? (parseInt(_loc_2.substr(_orderedBeginPattern.lastIndex))) : (this._defaultNumber);
            return {ordered:_loc_3};
        }// end function

    }
}
