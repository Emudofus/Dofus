package com.adobe.utils
{

    public class StringUtil extends Object
    {

        public function StringUtil()
        {
            return;
        }// end function

        public static function beginsWith(param1:String, param2:String) : Boolean
        {
            return param2 == param1.substring(0, param2.length);
        }// end function

        public static function trim(param1:String) : String
        {
            return ltrim(rtrim(param1));
        }// end function

        public static function stringsAreEqual(param1:String, param2:String, param3:Boolean) : Boolean
        {
            if (param3)
            {
                return param1 == param2;
            }
            return param1.toUpperCase() == param2.toUpperCase();
        }// end function

        public static function replace(param1:String, param2:String, param3:String) : String
        {
            return param1.split(param2).join(param3);
        }// end function

        public static function rtrim(param1:String) : String
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = _loc_2;
            while (_loc_3 > 0)
            {
                
                if (param1.charCodeAt((_loc_3 - 1)) > 32)
                {
                    return param1.substring(0, _loc_3);
                }
                _loc_3 = _loc_3 - 1;
            }
            return "";
        }// end function

        public static function endsWith(param1:String, param2:String) : Boolean
        {
            return param2 == param1.substring(param1.length - param2.length);
        }// end function

        public static function stringHasValue(param1:String) : Boolean
        {
            return param1 != null && param1.length > 0;
        }// end function

        public static function remove(param1:String, param2:String) : String
        {
            return replace(param1, param2, "");
        }// end function

        public static function ltrim(param1:String) : String
        {
            var _loc_2:* = param1.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                if (param1.charCodeAt(_loc_3) > 32)
                {
                    return param1.substring(_loc_3);
                }
                _loc_3 = _loc_3 + 1;
            }
            return "";
        }// end function

    }
}
