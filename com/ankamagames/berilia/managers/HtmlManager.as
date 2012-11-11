package com.ankamagames.berilia.managers
{
    import com.adobe.utils.*;
    import flashx.textLayout.elements.*;

    public class HtmlManager extends Object
    {
        public static const LINK:String = "a";
        public static const SPAN:String = "span";
        public static const COLOR:String = "color";
        public static const ITALIC:String = "italic";
        public static const BOLD:String = "bold";

        public function HtmlManager()
        {
            return;
        }// end function

        public static function addTag(param1:String, param2:String, param3:Object = null) : String
        {
            if (isTagValide(param2))
            {
                return "<" + param2 + " " + formateStyle(param3) + ">" + param1 + "</" + param2 + ">";
            }
            trace("ERROR TAG: \"" + param2 + "\" NOT VALID !!");
            return param1;
        }// end function

        private static function formateStyle(param1:Object = null) : String
        {
            var _loc_2:* = "";
            if (param1 != null)
            {
                _loc_2 = _loc_2 + " style=\"";
                if (param1[COLOR])
                {
                    _loc_2 = _loc_2 + ("color:" + getHexaColor(param1[COLOR]) + ";");
                }
                if (param1[ITALIC])
                {
                    _loc_2 = _loc_2 + ("font-style:" + param1[ITALIC] + ";");
                }
                if (param1[BOLD])
                {
                    _loc_2 = _loc_2 + "font-weight: bold;";
                }
                _loc_2 = _loc_2 + "\"";
            }
            return _loc_2;
        }// end function

        private static function getHexaColor(param1) : String
        {
            var _loc_2:* = "";
            switch(true)
            {
                case param1 is int:
                case param1 is uint:
                {
                    _loc_2 = "#" + param1.toString(16);
                    break;
                }
                case param1 is String:
                {
                    if (param1.indexOf("#") == 0)
                    {
                        _loc_2 = String(param1);
                    }
                    else
                    {
                        _loc_2 = param1.replace("0x", "#");
                    }
                    break;
                }
                default:
                {
                    _loc_2 = "#FF0000";
                    break;
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function addLink(param1:String, param2:String = "", param3:Object = null) : String
        {
            param1 = "<" + LINK + " href=\'" + param2 + "\'" + formateStyle(param3) + ">" + param1 + "</" + LINK + ">";
            return param1;
        }// end function

        public static function removeStyle(param1:String, param2:String, param3:Boolean = false) : String
        {
            return param1;
        }// end function

        public static function addStyleToWords(param1:String, param2:String, param3:String) : String
        {
            return param1;
        }// end function

        private static function isTagValide(param1:String) : Boolean
        {
            switch(param1)
            {
                case SPAN:
                {
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public static function parseStyle(param1:String) : Array
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_2:* = new Array();
            var _loc_3:* = param1.split(";");
            for each (_loc_4 in _loc_3)
            {
                
                _loc_5 = _loc_4.split(":");
                if (_loc_5[0] != "")
                {
                    _loc_2[_loc_5[0]] = StringUtil.trim(_loc_5[1]);
                }
            }
            return _loc_2;
        }// end function

        public static function formateSpan(param1:SpanElement, param2:String) : SpanElement
        {
            var _loc_3:* = parseStyle(param2);
            if (_loc_3["font-weight"])
            {
                param1.fontWeight = _loc_3["font-weight"];
            }
            if (_loc_3["color"])
            {
                param1.color = _loc_3["color"];
            }
            return param1;
        }// end function

    }
}
