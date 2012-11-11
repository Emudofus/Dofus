package com.ankamagames.jerakine.json
{
    import flash.utils.*;

    public class JSONEncoder extends Object
    {
        private var _depthLimit:uint = 0;
        private var _showObjectType:Boolean = false;
        private var jsonString:String;

        public function JSONEncoder(param1, param2:uint = 0, param3:Boolean = false)
        {
            this._depthLimit = param2;
            this._showObjectType = param3;
            this.jsonString = this.convertToString(param1);
            return;
        }// end function

        public function getString() : String
        {
            return this.jsonString;
        }// end function

        private function convertToString(param1, param2:int = 0) : String
        {
            if (this._depthLimit != 0 && param2 > this._depthLimit)
            {
                return "";
            }
            if (param1 is String)
            {
                return this.escapeString(param1 as String);
            }
            if (param1 is Number)
            {
                return isFinite(param1 as Number) ? (param1.toString()) : ("null");
            }
            else if (param1 is Boolean)
            {
                return param1 ? ("true") : ("false");
            }
            else
            {
                if (param1 is Array || param1 is Vector.<int> || param1 is Vector.<uint> || param1 is Vector.<String> || param1 is Vector.<Boolean> || param1 is Vector.<null> || param1 is Dictionary)
                {
                    return this.arrayToString(param1, (param2 + 1));
                }
                if (param1 is Object && param1 != null)
                {
                    return this.objectToString(param1, (param2 + 1));
                }
            }
            return "null";
        }// end function

        private function escapeString(param1:String) : String
        {
            var _loc_3:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_2:* = "";
            var _loc_4:* = param1.length;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_3 = param1.charAt(_loc_5);
                switch(_loc_3)
                {
                    case "\"":
                    {
                        _loc_2 = _loc_2 + "\\\"";
                        break;
                    }
                    case "\\":
                    {
                        _loc_2 = _loc_2 + "\\\\";
                        break;
                    }
                    case "\b":
                    {
                        _loc_2 = _loc_2 + "\\b";
                        break;
                    }
                    case "\f":
                    {
                        _loc_2 = _loc_2 + "\\f";
                        break;
                    }
                    case "\n":
                    {
                        _loc_2 = _loc_2 + "\\n";
                        break;
                    }
                    case "\r":
                    {
                        _loc_2 = _loc_2 + "\\r";
                        break;
                    }
                    case "\t":
                    {
                        _loc_2 = _loc_2 + "\\t";
                        break;
                    }
                    default:
                    {
                        if (_loc_3 < " ")
                        {
                            _loc_6 = _loc_3.charCodeAt(0).toString(16);
                            _loc_7 = _loc_6.length == 2 ? ("00") : ("000");
                            _loc_2 = _loc_2 + ("\\u" + _loc_7 + _loc_6);
                        }
                        else
                        {
                            _loc_2 = _loc_2 + _loc_3;
                        }
                        break;
                    }
                }
                _loc_5++;
            }
            return "\"" + _loc_2 + "\"";
        }// end function

        private function arrayToString(param1, param2:int) : String
        {
            var _loc_4:* = undefined;
            if (this._depthLimit != 0 && param2 > this._depthLimit)
            {
                return "";
            }
            var _loc_3:* = "";
            for each (_loc_4 in param1)
            {
                
                if (_loc_3.length > 0)
                {
                    _loc_3 = _loc_3 + ",";
                }
                _loc_3 = _loc_3 + this.convertToString(_loc_4);
            }
            return "[" + _loc_3 + "]";
        }// end function

        private function objectToString(param1:Object, param2:int) : String
        {
            var className:Array;
            var value:Object;
            var key:String;
            var v:XML;
            var o:* = param1;
            var depth:* = param2;
            if (this._depthLimit != 0 && depth > this._depthLimit)
            {
                return "";
            }
            var s:String;
            var classInfo:* = describeType(o);
            if (classInfo.@name.toString() == "Object")
            {
                var _loc_4:* = 0;
                var _loc_5:* = o;
                while (_loc_5 in _loc_4)
                {
                    
                    key = _loc_5[_loc_4];
                    value = o[key];
                    if (value is Function)
                    {
                        continue;
                    }
                    if (s.length > 0)
                    {
                        s = s + ",";
                    }
                    s = s + (this.escapeString(key) + ":" + this.convertToString(value));
                }
            }
            else
            {
                var _loc_4:* = 0;
                var _loc_7:* = 0;
                var _loc_8:* = classInfo..;
                var _loc_6:* = new XMLList("");
                for each (_loc_9 in _loc_8)
                {
                    
                    var _loc_10:* = _loc_8[_loc_7];
                    with (_loc_8[_loc_7])
                    {
                        if (name() == "variable" || name() == "accessor" && attribute("access").charAt(0) == "r")
                        {
                            _loc_6[_loc_7] = _loc_9;
                        }
                    }
                }
                var _loc_5:* = _loc_6;
                do
                {
                    
                    v = _loc_5[_loc_4];
                    var _loc_7:* = 0;
                    var _loc_8:* = v.metadata;
                    var _loc_6:* = new XMLList("");
                    for each (_loc_9 in _loc_8)
                    {
                        
                        var _loc_10:* = _loc_8[_loc_7];
                        with (_loc_8[_loc_7])
                        {
                            if (@name == "Transient")
                            {
                                _loc_6[_loc_7] = _loc_9;
                            }
                        }
                    }
                    if (v.metadata && _loc_6.length() > 0)
                    {
                    }
                    else
                    {
                        if (s.length > 0)
                        {
                            s = s + ",";
                        }
                        try
                        {
                            s = s + (this.escapeString(v.@name.toString()) + ":" + this.convertToString(o[v.@name]));
                        }
                        catch (e:Error)
                        {
                        }
                    }
                }while (_loc_5 in _loc_4)
            }
            if (this._showObjectType)
            {
                className = getQualifiedClassName(o).split("::");
            }
            if (className != null)
            {
                return "{" + this.escapeString("type") + ":" + this.escapeString(className.pop()) + ", " + this.escapeString("value") + ":{" + s + "}}";
            }
            return "{" + s + "}";
        }// end function

    }
}
