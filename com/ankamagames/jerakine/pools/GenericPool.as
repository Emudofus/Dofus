package com.ankamagames.jerakine.pools
{
    import flash.utils.*;

    public class GenericPool extends Object
    {
        private static var _pools:Dictionary = new Dictionary();

        public function GenericPool()
        {
            return;
        }// end function

        public static function get(param1:Class, ... args)
        {
            if (_pools[param1] && _pools[param1].length)
            {
                return param1["create"].apply(null, args.concat(_pools[param1].pop()));
            }
            return param1["create"].apply(null, args);
        }// end function

        public static function free(param1:Poolable) : void
        {
            param1.free();
            var _loc_2:* = Object(param1).constructor;
            if (!_pools[_loc_2])
            {
                _pools[_loc_2] = new Array();
            }
            (_pools[_loc_2] as Array).push(param1);
            return;
        }// end function

    }
}
