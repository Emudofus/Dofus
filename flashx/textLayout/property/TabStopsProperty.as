package flashx.textLayout.property
{
    import __AS3__.vec.*;
    import flash.text.engine.*;
    import flashx.textLayout.formats.*;

    public class TabStopsProperty extends ArrayProperty
    {
        private static const _tabStopRegex:RegExp = /([sScCeEdD]?)([^| ]+)(|[^ ]*)?( |$)""([sScCeEdD]?)([^| ]+)(|[^ ]*)?( |$)/g;
        private static const _escapeBackslashRegex:RegExp = /\\\\\\\"""\\\\/g;
        private static const _escapeSpaceRegex:RegExp = /\\\ ""\\ /g;
        private static const _backslashRegex:RegExp = /\\\"""\\/g;
        private static const _spaceRegex:RegExp = / "" /g;
        private static const _backslashPlaceholderRegex:RegExp = /""/g;
        private static const _spacePlaceholderRegex:RegExp = /""/g;
        private static const _backslashPlaceHolder:String = String.fromCharCode(57344);
        private static const _spacePlaceHolder:String = String.fromCharCode(57345);

        public function TabStopsProperty(param1:String, param2:Array, param3:Boolean, param4:Vector.<String>)
        {
            super(param1, param2, param3, param4, TabStopFormat);
            return;
        }// end function

        override public function setHelper(param1, param2)
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = NaN;
            if (param2 == null || param2 == FormatValue.INHERIT)
            {
                return param2;
            }
            var _loc_3:* = param2 as Array;
            if (_loc_3)
            {
                if (!checkArrayTypes(_loc_3))
                {
                    Property.errorHandler(this, param2);
                    return param1;
                }
            }
            else
            {
                _loc_4 = param2 as String;
                if (!_loc_4)
                {
                    Property.errorHandler(this, param2);
                    return param1;
                }
                _loc_3 = new Array();
                _loc_4 = _loc_4.replace(_escapeBackslashRegex, _backslashPlaceHolder);
                _loc_4 = _loc_4.replace(_escapeSpaceRegex, _spacePlaceHolder);
                _tabStopRegex.lastIndex = 0;
                do
                {
                    
                    _loc_5 = _tabStopRegex.exec(_loc_4);
                    if (!_loc_5)
                    {
                        break;
                    }
                    _loc_6 = new TabStopFormat();
                    switch(_loc_5[1].toLowerCase())
                    {
                        case "s":
                        case "":
                        {
                            _loc_6.alignment = TabAlignment.START;
                            break;
                        }
                        case "c":
                        {
                            _loc_6.alignment = TabAlignment.CENTER;
                            break;
                        }
                        case "e":
                        {
                            _loc_6.alignment = TabAlignment.END;
                            break;
                        }
                        case "d":
                        {
                            _loc_6.alignment = TabAlignment.DECIMAL;
                            break;
                        }
                        default:
                        {
                            break;
                        }
                    }
                    _loc_7 = Number(_loc_5[2]);
                    if (isNaN(_loc_7))
                    {
                        Property.errorHandler(this, param2);
                        return param1;
                    }
                    _loc_6.position = _loc_7;
                    if (_loc_6.alignment == TabAlignment.DECIMAL)
                    {
                        if (_loc_5[3] == "")
                        {
                            _loc_6.decimalAlignmentToken = ".";
                        }
                        else
                        {
                            _loc_6.decimalAlignmentToken = _loc_5[3].slice(1).replace(_backslashPlaceholderRegex, "\\");
                            _loc_6.decimalAlignmentToken = _loc_6.decimalAlignmentToken.replace(_spacePlaceholderRegex, " ");
                        }
                    }
                    else if (_loc_5[3] != "")
                    {
                        Property.errorHandler(this, param2);
                        return param1;
                    }
                    _loc_3.push(_loc_6);
                }while (true)
            }
            return _loc_3.sort(compareTabStopFormats);
        }// end function

        override public function toXMLString(param1:Object) : String
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = "";
            var _loc_3:* = param1 as Array;
            for each (_loc_4 in _loc_3)
            {
                
                if (_loc_2.length)
                {
                    _loc_2 = _loc_2 + " ";
                }
                switch(_loc_4.alignment)
                {
                    case TabAlignment.START:
                    {
                        _loc_2 = _loc_2 + "s";
                        break;
                    }
                    case TabAlignment.CENTER:
                    {
                        _loc_2 = _loc_2 + "c";
                        break;
                    }
                    case TabAlignment.END:
                    {
                        _loc_2 = _loc_2 + "e";
                        break;
                    }
                    case TabAlignment.DECIMAL:
                    {
                        _loc_2 = _loc_2 + "d";
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                _loc_2 = _loc_2 + _loc_4.position.toString();
                if (_loc_4.alignment == TabAlignment.DECIMAL)
                {
                    _loc_5 = _loc_4.decimalAlignmentToken.replace(_backslashRegex, "\\\\");
                    _loc_5 = _loc_5.replace(_spaceRegex, "\\ ");
                    _loc_2 = _loc_2 + ("|" + _loc_5);
                }
            }
            return _loc_2;
        }// end function

        private static function compareTabStopFormats(param1:TabStopFormat, param2:TabStopFormat) : Number
        {
            return param1.position == param2.position ? (0) : (param1.position < param2.position ? (-1) : (1));
        }// end function

    }
}
