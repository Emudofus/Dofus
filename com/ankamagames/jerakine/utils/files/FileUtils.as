package com.ankamagames.jerakine.utils.files
{

    public class FileUtils extends Object
    {

        public function FileUtils()
        {
            return;
        }// end function

        public static function getExtension(param1:String) : String
        {
            var _loc_2:* = param1.split(".");
            if (_loc_2.length > 1)
            {
                return _loc_2[(_loc_2.length - 1)];
            }
            return null;
        }// end function

        public static function getFileName(param1:String) : String
        {
            var _loc_2:* = param1.split("/");
            return _loc_2[(_loc_2.length - 1)];
        }// end function

        public static function getFilePath(param1:String) : String
        {
            var _loc_2:Array = null;
            var _loc_3:Array = null;
            if (param1.indexOf("/") != -1)
            {
                _loc_2 = param1.split("/");
                _loc_2.pop();
                return _loc_2.join("/");
            }
            if (param1.indexOf("\\") != -1)
            {
                _loc_3 = param1.split("\\");
                _loc_3.pop();
                return _loc_3.join("\\");
            }
            return "";
        }// end function

        public static function getFilePathStartName(param1:String) : String
        {
            var _loc_2:* = param1.split(".");
            _loc_2.pop();
            return _loc_2.join(".");
        }// end function

        public static function getFileStartName(param1:String) : String
        {
            var _loc_2:* = param1.split(/(\/|\|)""(\/|\|)/);
            _loc_2 = _loc_2[(_loc_2.length - 1)].split(".");
            _loc_2.pop();
            return _loc_2.join(".");
        }// end function

    }
}
