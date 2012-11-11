package flashx.textLayout.utils
{

    final public class CharacterUtil extends Object
    {
        private static var whiteSpaceObject:Object = createWhiteSpaceObject();

        public function CharacterUtil()
        {
            return;
        }// end function

        public static function isHighSurrogate(param1:int) : Boolean
        {
            return param1 >= 55296 && param1 <= 56319;
        }// end function

        public static function isLowSurrogate(param1:int) : Boolean
        {
            return param1 >= 56320 && param1 <= 57343;
        }// end function

        private static function createWhiteSpaceObject() : Object
        {
            var _loc_1:* = new Object();
            _loc_1[32] = true;
            _loc_1[5760] = true;
            _loc_1[6158] = true;
            _loc_1[8192] = true;
            _loc_1[8193] = true;
            _loc_1[8194] = true;
            _loc_1[8195] = true;
            _loc_1[8196] = true;
            _loc_1[8197] = true;
            _loc_1[8198] = true;
            _loc_1[8199] = true;
            _loc_1[8200] = true;
            _loc_1[8201] = true;
            _loc_1[8202] = true;
            _loc_1[8239] = true;
            _loc_1[8287] = true;
            _loc_1[12288] = true;
            _loc_1[8232] = true;
            _loc_1[8233] = true;
            _loc_1[9] = true;
            _loc_1[10] = true;
            _loc_1[11] = true;
            _loc_1[12] = true;
            _loc_1[13] = true;
            _loc_1[133] = true;
            _loc_1[160] = true;
            return _loc_1;
        }// end function

        public static function isWhitespace(param1:int) : Boolean
        {
            return whiteSpaceObject[param1];
        }// end function

    }
}
