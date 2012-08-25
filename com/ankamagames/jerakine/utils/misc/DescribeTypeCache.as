package com.ankamagames.jerakine.utils.misc
{
    import flash.utils.*;

    public class DescribeTypeCache extends Object
    {
        private static var _classDesc:Dictionary = new Dictionary();
        private static var _variables:Dictionary = new Dictionary();
        private static var _variablesAndAccessor:Dictionary = new Dictionary();
        private static var _tags:Dictionary = new Dictionary();

        public function DescribeTypeCache()
        {
            return;
        }// end function

        public static function typeDescription(param1:Object, param2:Boolean = true) : XML
        {
            if (!param2)
            {
                return describeType(param1);
            }
            var _loc_3:* = getQualifiedClassName(param1);
            if (!_classDesc[_loc_3])
            {
                _classDesc[_loc_3] = describeType(param1);
            }
            return _classDesc[_loc_3];
        }// end function

        public static function getVariables(param1:Object, param2:Boolean = false, param3:Boolean = true) : Array
        {
            var _loc_5:Array = null;
            var _loc_6:XML = null;
            var _loc_7:XML = null;
            var _loc_8:XML = null;
            var _loc_4:* = getQualifiedClassName(param1);
            if (param3)
            {
                if (param2 && _variables[_loc_4])
                {
                    return _variables[_loc_4];
                }
                if (!param2 && _variablesAndAccessor[_loc_4])
                {
                    return _variablesAndAccessor[_loc_4];
                }
            }
            _loc_5 = new Array();
            _loc_6 = typeDescription(param1, param3);
            for each (_loc_7 in _loc_6..variable)
            {
                
                _loc_5.push(_loc_7.@name.toString());
            }
            if (!param2)
            {
                for each (_loc_8 in _loc_6..accessor)
                {
                    
                    _loc_5.push(_loc_8.@name.toString());
                }
            }
            if (param3)
            {
                if (param2)
                {
                    _variables[_loc_4] = _loc_5;
                }
                else
                {
                    _variablesAndAccessor[_loc_4] = _loc_5;
                }
            }
            return _loc_5;
        }// end function

        public static function getTags(param1:Object) : Dictionary
        {
            var _loc_4:XML = null;
            var _loc_5:XML = null;
            var _loc_6:String = null;
            var _loc_2:* = getQualifiedClassName(param1);
            if (_tags[_loc_2])
            {
                return _tags[_loc_2];
            }
            _tags[_loc_2] = new Dictionary();
            var _loc_3:* = typeDescription(param1);
            for each (_loc_4 in _loc_3..metadata)
            {
                
                _loc_6 = _loc_4.parent().@name;
                if (!_tags[_loc_2][_loc_6])
                {
                    _tags[_loc_2][_loc_6] = new Dictionary();
                }
                _tags[_loc_2][_loc_6][_loc_4.@name.toString()] = true;
            }
            for each (_loc_5 in _loc_3..variable)
            {
                
                _loc_6 = _loc_5.@name;
                if (!_tags[_loc_2][_loc_6])
                {
                    _tags[_loc_2][_loc_6] = new Dictionary();
                }
            }
            for each (_loc_5 in _loc_3..method)
            {
                
                _loc_6 = _loc_5.@name;
                if (!_tags[_loc_2][_loc_6])
                {
                    _tags[_loc_2][_loc_6] = new Dictionary();
                }
            }
            return _tags[_loc_2];
        }// end function

    }
}
