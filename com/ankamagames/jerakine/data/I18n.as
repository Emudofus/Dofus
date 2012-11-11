package com.ankamagames.jerakine.data
{
    import flash.utils.*;

    public class I18n extends AbstractDataManager
    {
        private static var _overrides:Dictionary = new Dictionary();

        public function I18n()
        {
            return;
        }// end function

        public static function addOverride(param1:uint, param2:uint) : void
        {
            _overrides[param1] = param2;
            return;
        }// end function

        public static function getText(param1:uint, param2:Array = null, param3:String = "%") : String
        {
            if (!param1)
            {
                return null;
            }
            if (_overrides[param1])
            {
                param1 = _overrides[param1];
            }
            var _loc_4:* = I18nFileAccessor.getInstance().getText(param1);
            if (I18nFileAccessor.getInstance().getText(param1) == null || _loc_4 == "null")
            {
                return "[UNKNOWN_TEXT_ID_" + param1 + "]";
            }
            return replaceParams(_loc_4, param2, param3);
        }// end function

        public static function getUiText(param1:String, param2:Array = null, param3:String = "%") : String
        {
            if (_overrides[param1])
            {
                param1 = _overrides[param1];
            }
            var _loc_4:* = I18nFileAccessor.getInstance().getNamedText(param1);
            if (I18nFileAccessor.getInstance().getNamedText(param1) == null || _loc_4 == "null")
            {
                return "[UNKNOWN_TEXT_NAME_" + param1 + "]";
            }
            return replaceParams(_loc_4, param2, param3);
        }// end function

        public static function hasUiText(param1:String) : Boolean
        {
            return I18nFileAccessor.getInstance().hasNamedText(param1);
        }// end function

        public static function replaceParams(param1:String, param2:Array, param3:String) : String
        {
            if (!param2 || !param2.length)
            {
                return param1;
            }
            var _loc_4:* = new Array();
            var _loc_5:* = 1;
            while (_loc_5 <= param2.length)
            {
                
                param1 = param1.replace(param3 + _loc_5, param2[(_loc_5 - 1)]);
                _loc_5 = _loc_5 + 1;
            }
            return param1;
        }// end function

    }
}
