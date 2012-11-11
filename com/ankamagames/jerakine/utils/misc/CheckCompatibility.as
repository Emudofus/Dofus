package com.ankamagames.jerakine.utils.misc
{
    import flash.utils.*;

    public class CheckCompatibility extends Object
    {
        private static var _cache:Dictionary = new Dictionary(true);

        public function CheckCompatibility()
        {
            return;
        }// end function

        public static function isCompatible(param1:Class, param2, param3:Boolean = false, param4:Boolean = true) : Boolean
        {
            var cacheKey:Class;
            var method:XML;
            var param:XML;
            var reference:* = param1;
            var target:* = param2;
            var strict:* = param3;
            var throwError:* = param4;
            if (target is Class)
            {
                cacheKey = target;
            }
            else
            {
                cacheKey = getDefinitionByName(getQualifiedClassName(target)) as Class;
            }
            if (!_cache[reference])
            {
                _cache[reference] = new Dictionary(true);
            }
            if (_cache[reference][cacheKey] != null)
            {
                if (throwError && !_cache[reference][cacheKey])
                {
                    throwErrorMsg(reference, target, strict);
                }
                return _cache[reference][cacheKey];
            }
            var referenceDesc:* = DescribeTypeCache.typeDescription(reference);
            var targetDesc:* = DescribeTypeCache.typeDescription(target);
            var _loc_6:* = 0;
            var _loc_7:* = referenceDesc..method;
            while (_loc_7 in _loc_6)
            {
                
                method = _loc_7[_loc_6];
                var _loc_9:* = 0;
                var _loc_10:* = targetDesc..method;
                var _loc_8:* = new XMLList("");
                for each (_loc_11 in _loc_10)
                {
                    
                    var _loc_12:* = _loc_10[_loc_9];
                    with (_loc_10[_loc_9])
                    {
                        if (@name == method.@name && (@returnType == method.@returnType || !strict && method.@returnType == "Object"))
                        {
                            _loc_8[_loc_9] = _loc_11;
                        }
                    }
                }
                if (!_loc_8.length())
                {
                    _cache[reference][cacheKey] = false;
                    if (throwError)
                    {
                        throwErrorMsg(reference, target, strict);
                    }
                    return false;
                }
                var _loc_8:* = 0;
                var _loc_9:* = method..parameter;
                while (_loc_9 in _loc_8)
                {
                    
                    param = _loc_9[_loc_8];
                    var _loc_11:* = 0;
                    var _loc_14:* = 0;
                    var _loc_15:* = targetDesc..method;
                    var _loc_13:* = new XMLList("");
                    for each (_loc_16 in _loc_15)
                    {
                        
                        var _loc_17:* = _loc_15[_loc_14];
                        with (_loc_15[_loc_14])
                        {
                            if (@name == method.@name)
                            {
                                _loc_13[_loc_14] = _loc_16;
                            }
                        }
                    }
                    var _loc_12:* = _loc_13..parameter;
                    var _loc_10:* = new XMLList("");
                    for each (_loc_13 in _loc_12)
                    {
                        
                        var _loc_14:* = _loc_12[_loc_11];
                        with (_loc_12[_loc_11])
                        {
                            if (@index == param.@index && @type == param.@type && @optional == param.@optional)
                            {
                                _loc_10[_loc_11] = _loc_13;
                            }
                        }
                    }
                    if (!_loc_10.length())
                    {
                        _cache[reference][cacheKey] = false;
                        if (throwError)
                        {
                            throwErrorMsg(reference, target, strict);
                        }
                        return false;
                    }
                }
            }
            _cache[reference][cacheKey] = true;
            return true;
        }// end function

        public static function getIncompatibility(param1:Class, param2, param3:Boolean = false) : String
        {
            var method:XML;
            var param:XML;
            var fct:String;
            var reference:* = param1;
            var target:* = param2;
            var strict:* = param3;
            var referenceDesc:* = DescribeTypeCache.typeDescription(reference);
            var targetDesc:* = DescribeTypeCache.typeDescription(target);
            var ok:Boolean;
            var _loc_5:* = 0;
            var _loc_6:* = referenceDesc..method;
            while (_loc_6 in _loc_5)
            {
                
                method = _loc_6[_loc_5];
                fct = "public function " + method.@name + "(";
                var _loc_8:* = 0;
                var _loc_9:* = targetDesc..method;
                var _loc_7:* = new XMLList("");
                for each (_loc_10 in _loc_9)
                {
                    
                    var _loc_11:* = _loc_9[_loc_8];
                    with (_loc_9[_loc_8])
                    {
                        if (@name == method.@name && (@returnType == method.@returnType || !strict && method.@returnType == "Object"))
                        {
                            _loc_7[_loc_8] = _loc_10;
                        }
                    }
                }
                if (!_loc_7.length())
                {
                    ok;
                }
                var _loc_7:* = 0;
                var _loc_8:* = method..parameter;
                while (_loc_8 in _loc_7)
                {
                    
                    param = _loc_8[_loc_7];
                    fct = fct + ((parseInt(param.@index) > 1 ? (", ") : ("")) + "param" + param.@index + " : " + param.@type);
                    var _loc_10:* = 0;
                    var _loc_13:* = 0;
                    var _loc_14:* = targetDesc..method;
                    var _loc_12:* = new XMLList("");
                    for each (_loc_15 in _loc_14)
                    {
                        
                        var _loc_16:* = _loc_14[_loc_13];
                        with (_loc_14[_loc_13])
                        {
                            if (@name == method.@name)
                            {
                                _loc_12[_loc_13] = _loc_15;
                            }
                        }
                    }
                    var _loc_11:* = _loc_12..parameter;
                    var _loc_9:* = new XMLList("");
                    for each (_loc_12 in _loc_11)
                    {
                        
                        var _loc_13:* = _loc_11[_loc_10];
                        with (_loc_11[_loc_10])
                        {
                            if (@index == param.@index && @type == param.@type && @optional == param.@optional)
                            {
                                _loc_9[_loc_10] = _loc_12;
                            }
                        }
                    }
                    if (!_loc_9.length())
                    {
                        ok;
                    }
                }
                fct = fct + (") : " + method.@returnType);
                if (!ok)
                {
                    return fct;
                }
            }
            return null;
        }// end function

        private static function throwErrorMsg(param1:Class, param2, param3:Boolean = false) : void
        {
            throw new Error(param2 + " don\'t implement correctly [" + getIncompatibility(param1, param2) + "]");
        }// end function

    }
}
