package flashx.textLayout.property
{
    import flashx.textLayout.elements.*;

    public class CounterContentHandler extends PropertyHandler
    {
        private static const _counterContentPattern1:RegExp = /^\s*counter\s*\(\s*ordered\s*\)\s*$""^\s*counter\s*\(\s*ordered\s*\)\s*$/;
        private static const _counterContentPattern2:RegExp = /^\s*counter\s*\(\s*ordered\s*,\s*\S+\s*\)\s*$""^\s*counter\s*\(\s*ordered\s*,\s*\S+\s*\)\s*$/;
        private static const _countersContentPattern1:RegExp = /^\s*counters\s*\(\s*ordered\s*\)\s*$""^\s*counters\s*\(\s*ordered\s*\)\s*$/;
        private static const _countersContentPattern2:RegExp = /^\s*counters\s*\(\s*ordered\s*,\s*"".*""\s*\)\s*$""^\s*counters\s*\(\s*ordered\s*,\s*".*"\s*\)\s*$/;
        private static const _countersContentPattern3:RegExp = /^\s*counters\s*\(\s*ordered\s*,\s*"".*""\s*,\s*\S+\s*\)\s*$""^\s*counters\s*\(\s*ordered\s*,\s*".*"\s*,\s*\S+\s*\)\s*$/;
        private static const _counterBeginPattern:RegExp = /^\s*counter\s*\(\s*ordered\s*,\s*""^\s*counter\s*\(\s*ordered\s*,\s*/g;
        private static const _trailingStuff:RegExp = /\s*\)\s*""\s*\)\s*/g;
        private static const _countersTillSuffixPattern:RegExp = /^\s*counters\s*\(\s*ordered\s*,\s*""""^\s*counters\s*\(\s*ordered\s*,\s*"/g;
        private static const _afterSuffixPattern2:RegExp = /^""\s*\)\s*$""^"\s*\)\s*$/;
        private static const _afterSuffixPattern3:RegExp = /^""\s*,\s*\S+\s*\)\s*$""^"\s*,\s*\S+\s*\)\s*$/;
        private static const _countersTillListStyleTypePattern:RegExp = /^\s*counters\s*\(\s*ordered\s*,\s*"".*""\s*,\s*""^\s*counters\s*\(\s*ordered\s*,\s*".*"\s*,\s*/g;

        public function CounterContentHandler()
        {
            return;
        }// end function

        override public function get customXMLStringHandler() : Boolean
        {
            return true;
        }// end function

        override public function toXMLString(param1:Object) : String
        {
            var _loc_2:* = null;
            if (param1.hasOwnProperty("counter"))
            {
                return param1.ordered == null ? ("counter(ordered)") : ("counter(ordered," + param1.ordered + ")");
            }
            if (param1.hasOwnProperty("counters"))
            {
                _loc_2 = "counters(ordered";
                if (param1.suffix != null)
                {
                    _loc_2 = _loc_2 + (",\"" + param1.suffix + "\"");
                    if (param1.ordered)
                    {
                        _loc_2 = _loc_2 + ("," + param1.ordered);
                    }
                }
                _loc_2 = _loc_2 + ")";
                return _loc_2;
            }
            return param1.toString();
        }// end function

        override public function owningHandlerCheck(param1)
        {
            var _loc_2:* = null;
            if (!(param1 is String))
            {
                return param1.hasOwnProperty("counter") || param1.hasOwnProperty("counters") ? (param1) : (undefined);
            }
            if (_counterContentPattern1.test(param1))
            {
                return param1;
            }
            if (_counterContentPattern2.test(param1))
            {
                _loc_2 = extractListStyleTypeFromCounter(param1);
                return ListElement.listSuffixes[_loc_2] !== undefined ? (param1) : (undefined);
            }
            if (_countersContentPattern1.test(param1))
            {
                return param1;
            }
            if (_countersContentPattern2.test(param1))
            {
                return param1;
            }
            if (_countersContentPattern3.test(param1))
            {
                _loc_2 = extractListStyleTypeFromCounters(param1);
                return ListElement.listSuffixes[_loc_2] !== undefined ? (param1) : (undefined);
            }
            return undefined;
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
            if (_counterContentPattern1.test(param1))
            {
                return {counter:"ordered"};
            }
            if (_counterContentPattern2.test(param1))
            {
                _loc_3 = extractListStyleTypeFromCounter(param1);
                return {counter:"ordered", ordered:_loc_3};
            }
            if (_countersContentPattern1.test(param1))
            {
                return {counters:"ordered"};
            }
            if (_countersContentPattern2.test(param1))
            {
                _loc_4 = extractSuffixFromCounters2(param1);
                return {counters:"ordered", suffix:_loc_4};
            }
            if (_countersContentPattern3.test(param1))
            {
                _loc_3 = extractListStyleTypeFromCounters(param1);
                _loc_4 = extractSuffixFromCounters3(param1);
                return {counters:"ordered", suffix:_loc_4, ordered:_loc_3};
            }
            return undefined;
        }// end function

        static function extractListStyleTypeFromCounter(param1:String) : String
        {
            _counterBeginPattern.lastIndex = 0;
            _counterBeginPattern.test(param1);
            param1 = param1.substr(_counterBeginPattern.lastIndex);
            _trailingStuff.lastIndex = 0;
            _trailingStuff.test(param1);
            param1 = param1.substr(0, (_trailingStuff.lastIndex - 1));
            return param1;
        }// end function

        static function extractSuffixFromCounters2(param1:String) : String
        {
            _countersTillSuffixPattern.lastIndex = 0;
            _countersTillSuffixPattern.test(param1);
            param1 = param1.substr(_countersTillSuffixPattern.lastIndex);
            var _loc_2:* = "";
            while (!_afterSuffixPattern2.test(param1))
            {
                
                _loc_2 = _loc_2 + param1.substr(0, 1);
                param1 = param1.substr(1);
            }
            return _loc_2;
        }// end function

        static function extractSuffixFromCounters3(param1:String) : String
        {
            _countersTillSuffixPattern.lastIndex = 0;
            _countersTillSuffixPattern.test(param1);
            param1 = param1.substr(_countersTillSuffixPattern.lastIndex);
            var _loc_2:* = "";
            while (!_afterSuffixPattern3.test(param1))
            {
                
                _loc_2 = _loc_2 + param1.substr(0, 1);
                param1 = param1.substr(1);
            }
            return _loc_2;
        }// end function

        static function extractListStyleTypeFromCounters(param1:String) : String
        {
            _countersTillListStyleTypePattern.lastIndex = 0;
            _countersTillListStyleTypePattern.test(param1);
            param1 = param1.substr(_countersTillListStyleTypePattern.lastIndex);
            _trailingStuff.lastIndex = 0;
            _trailingStuff.test(param1);
            param1 = param1.substr(0, (_trailingStuff.lastIndex - 1));
            return param1;
        }// end function

    }
}
