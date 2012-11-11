package flashx.textLayout.property
{
    import __AS3__.vec.*;
    import flashx.textLayout.formats.*;

    public class ArrayProperty extends Property
    {
        private var _memberType:Class;

        public function ArrayProperty(param1:String, param2:Array, param3:Boolean, param4:Vector.<String>, param5:Class)
        {
            super(param1, param2, param3, param4);
            this._memberType = param5;
            return;
        }// end function

        public function get memberType() : Class
        {
            return this._memberType;
        }// end function

        protected function checkArrayTypes(param1:Object) : Boolean
        {
            var _loc_2:* = null;
            if (param1 == null)
            {
                return true;
            }
            if (!(param1 is Array))
            {
                return false;
            }
            if (this._memberType == null)
            {
                return true;
            }
            for each (_loc_2 in param1 as Array)
            {
                
                if (!(_loc_2 is this._memberType))
                {
                    return false;
                }
            }
            return true;
        }// end function

        override public function get defaultValue()
        {
            return super.defaultValue == null ? (null) : ((super.defaultValue as Array).slice());
        }// end function

        override public function setHelper(param1, param2)
        {
            if (param2 === null)
            {
                param2 = undefined;
            }
            if (param2 == undefined || param2 == FormatValue.INHERIT)
            {
                return param2;
            }
            if (param2 is String)
            {
                param2 = this.valueFromString(String(param2));
            }
            if (!this.checkArrayTypes(param2))
            {
                Property.errorHandler(this, param2);
                return param1;
            }
            return (param2 as Array).slice();
        }// end function

        override public function concatInheritOnlyHelper(param1, param2)
        {
            return inherited && param1 === undefined || param1 == FormatValue.INHERIT ? (param2 is Array ? ((param2 as Array).slice()) : (param2)) : (param1);
        }// end function

        override public function concatHelper(param1, param2)
        {
            if (inherited)
            {
                return param1 === undefined || param1 == FormatValue.INHERIT ? (param2 is Array ? ((param2 as Array).slice()) : (param2)) : (param1);
            }
            if (param1 === undefined)
            {
                return this.defaultValue;
            }
            return param1 == FormatValue.INHERIT ? (param2 is Array ? ((param2 as Array).slice()) : (param2)) : (param1);
        }// end function

        override public function equalHelper(param1, param2) : Boolean
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            if (this._memberType != null)
            {
                _loc_3 = param1 as Array;
                _loc_4 = param2 as Array;
                if (_loc_3 && _loc_4)
                {
                    if (_loc_3.length == _loc_4.length)
                    {
                        _loc_5 = this._memberType.description;
                        _loc_6 = 0;
                        while (_loc_6 < _loc_3.length)
                        {
                            
                            if (!Property.equalAllHelper(_loc_5, param1[_loc_6], param2[_loc_6]))
                            {
                                return false;
                            }
                            _loc_6++;
                        }
                        return true;
                    }
                }
            }
            return param1 == param2;
        }// end function

        override public function toXMLString(param1:Object) : String
        {
            var _loc_5:* = null;
            var _loc_6:* = false;
            var _loc_7:* = null;
            if (param1 == FormatValue.INHERIT)
            {
                return String(param1);
            }
            var _loc_2:* = this._memberType.description;
            var _loc_3:* = "";
            var _loc_4:* = false;
            for each (_loc_5 in param1)
            {
                
                if (_loc_4)
                {
                    _loc_3 = _loc_3 + "; ";
                }
                _loc_6 = false;
                for each (_loc_7 in _loc_2)
                {
                    
                    param1 = _loc_5[_loc_7.name];
                    if (param1 != null)
                    {
                        if (_loc_6)
                        {
                            _loc_3 = _loc_3 + ", ";
                        }
                        _loc_3 = _loc_3 + (_loc_7.name + ":" + _loc_7.toXMLString(param1));
                        _loc_6 = true;
                    }
                }
                _loc_4 = true;
            }
            return _loc_3;
        }// end function

        private function valueFromString(param1:String)
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            if (param1 == null || param1 == "")
            {
                return null;
            }
            if (param1 == FormatValue.INHERIT)
            {
                return param1;
            }
            var _loc_2:* = new Array();
            var _loc_3:* = this._memberType.description;
            var _loc_4:* = param1.split("; ");
            for each (_loc_5 in _loc_4)
            {
                
                _loc_6 = new this._memberType();
                _loc_7 = _loc_5.split(", ");
                for each (_loc_8 in _loc_7)
                {
                    
                    _loc_9 = _loc_8.split(":");
                    _loc_10 = _loc_9[0];
                    _loc_11 = _loc_9[1];
                    for each (_loc_12 in _loc_3)
                    {
                        
                        if (_loc_12.name == _loc_10)
                        {
                            _loc_6[_loc_10] = _loc_12.setHelper(_loc_11, _loc_6[_loc_10]);
                            break;
                        }
                    }
                }
                _loc_2.push(_loc_6);
            }
            return _loc_2;
        }// end function

    }
}
