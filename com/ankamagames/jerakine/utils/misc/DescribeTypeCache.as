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
            var variables:Array;
            var description:XML;
            var variableNode:XML;
            var key:String;
            var accessorNode:XML;
            var o:* = param1;
            var onlyVar:* = param2;
            var useCache:* = param3;
            var className:* = getQualifiedClassName(o);
            if (useCache)
            {
                if (onlyVar && _variables[className])
                {
                    return _variables[className];
                }
                if (!onlyVar && _variablesAndAccessor[className])
                {
                    return _variablesAndAccessor[className];
                }
            }
            variables = new Array();
            description = typeDescription(o, useCache);
            if (description.@isDynamic.toString() == "true" || o is Proxy)
            {
                try
                {
                    var _loc_5:* = 0;
                    var _loc_6:* = o;
                    while (_loc_6 in _loc_5)
                    {
                        
                        key = _loc_6[_loc_5];
                        variables.push(key);
                    }
                }
                catch (e:Error)
                {
                }
            }
            var _loc_5:* = 0;
            var _loc_6:* = description..variable;
            while (_loc_6 in _loc_5)
            {
                
                variableNode = _loc_6[_loc_5];
                variables.push(variableNode.@name.toString());
            }
            if (!onlyVar)
            {
                var _loc_5:* = 0;
                var _loc_6:* = description..accessor;
                while (_loc_6 in _loc_5)
                {
                    
                    accessorNode = _loc_6[_loc_5];
                    variables.push(accessorNode.@name.toString());
                }
            }
            if (useCache)
            {
                if (onlyVar)
                {
                    _variables[className] = variables;
                }
                else
                {
                    _variablesAndAccessor[className] = variables;
                }
            }
            return variables;
        }// end function

        public static function getTags(param1:Object) : Dictionary
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
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
