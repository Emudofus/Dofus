package com.ankamagames.berilia.utils
{
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.newCache.*;
    import com.ankamagames.jerakine.types.*;
    import flash.utils.*;

    public class UriCacheFactory extends Object
    {
        private static var _log:Logger = Log.getLogger(getQualifiedClassName(UriCacheFactory));
        private static var _aCache:Array = new Array();

        public function UriCacheFactory()
        {
            return;
        }// end function

        public static function init(param1:String, param2:ICache) : ICache
        {
            _aCache[param1] = param2;
            return param2;
        }// end function

        public static function getCacheFromUri(param1:Uri) : ICache
        {
            var _loc_3:String = null;
            var _loc_2:* = param1.normalizedUri;
            for (_loc_3 in _aCache)
            {
                
                if (_loc_2.indexOf(_loc_3) != -1)
                {
                    return _aCache[_loc_3];
                }
            }
            return null;
        }// end function

        public static function get caches() : Array
        {
            return _aCache;
        }// end function

    }
}
