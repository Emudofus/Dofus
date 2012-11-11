package com.ankamagames.jerakine.utils.misc
{

    public class CopyObject extends Object
    {

        public function CopyObject()
        {
            return;
        }// end function

        public static function copyObject(param1:Object, param2:Array = null) : Object
        {
            var _loc_5:* = null;
            var _loc_3:* = new Object();
            var _loc_4:* = DescribeTypeCache.getVariables(param1);
            for each (_loc_5 in _loc_4)
            {
                
                if (param2 && param2.indexOf(_loc_5) != -1 || _loc_5 == "prototype")
                {
                    continue;
                }
                _loc_3[_loc_5] = param1[_loc_5];
            }
            return _loc_3;
        }// end function

    }
}
