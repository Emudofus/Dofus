package com.ankamagames.berilia.managers
{
    import com.adobe.utils.*;
    import flashx.textLayout.elements.*;

    public class HtmlManager extends Object
    {
        public static const LINK:String = "a";
        public static const SPAN:String = "span";
        public static const COLOR:String = "color";
        public static const UNDERLINE:String = "underline";
        public static const ITALIC:String = "italic";
        public static const BOLD:String = "bold";
        private static var htmlVersion:String;
        public static const OLD_FASHION:String = "old";
        public static const INLINE_CSS_VERSION:String = "inline";

        public function HtmlManager()
        {
            return;
        }// end function

        public static function changeCssHandler(param1:String) : void
        {
            switch(param1)
            {
                case OLD_FASHION:
                case INLINE_CSS_VERSION:
                {
                    htmlVersion = param1;
                    break;
                }
                default:
                {
                    htmlVersion = OLD_FASHION;
                    break;
                    break;
                }
            }
            return;
        }// end function

        public static function addTag(param1:String, param2:String, param3:Object = null) : String
        {
            if (htmlVersion == INLINE_CSS_VERSION)
            {
                if (isTagValide(param2))
                {
                    return "<" + param2 + " " + formateStyleWithInlineCss(param3) + ">" + param1 + "</" + param2 + ">";
                }
                trace("ERROR TAG: \"" + param2 + "\" NOT VALID !!");
                return param1;
            }
            else
            {
                if (param3 == null)
                {
                    param3 = new Object();
                }
                if (param2 == BOLD)
                {
                    param3[BOLD] = true;
                }
                if (param2 == ITALIC)
                {
                    param3[ITALIC] = true;
                }
                if (param2 == UNDERLINE)
                {
                    param3["text-decoration"] = UNDERLINE;
                }
            }
            return formateStyleWithTags(param1, param3);
        }// end function

        private static function formateStyleWithInlineCss(param1:Object = null) : String
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

        private static function formateStyleWithTags(param1:String, param2:Object = null) : String
        {
            var _loc_3:* = "";
            if (param2 != null)
            {
                if (param2[COLOR])
                {
                    _loc_3 = _loc_3 + ("<font color=\"" + getHexaColor(param2[COLOR]) + "\">");
                }
                if (param2[ITALIC])
                {
                    _loc_3 = _loc_3 + "<i>";
                }
                if (param2[BOLD])
                {
                    _loc_3 = _loc_3 + "<b>";
                }
                if (param2["text-decoration"] == UNDERLINE || param2["textDecoration"] == UNDERLINE)
                {
                    _loc_3 = _loc_3 + "<u>";
                }
                _loc_3 = _loc_3 + param1;
                if (param2["text-decoration"] == UNDERLINE || param2["textDecoration"] == UNDERLINE)
                {
                    _loc_3 = _loc_3 + "</u>";
                }
                if (param2[BOLD])
                {
                    _loc_3 = _loc_3 + "</b>";
                }
                if (param2[ITALIC])
                {
                    _loc_3 = _loc_3 + "</i>";
                }
                if (param2[COLOR])
                {
                    _loc_3 = _loc_3 + "</font>";
                }
            }
            else
            {
                _loc_3 = param1;
            }
            return _loc_3;
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

        public static function addLink(param1:String, param2:String = "", param3:Object = null, param4:Boolean = false) : String
        {
            if (htmlVersion == INLINE_CSS_VERSION || param4)
            {
                if (param3 != null)
                {
                    return "<" + LINK + " href=\'" + param2 + "\'" + formateStyleWithInlineCss(param3) + ">" + param1 + "</" + LINK + ">";
                }
                return "<" + LINK + " href=\'" + param2 + "\'>" + param1 + "</" + LINK + ">";
            }
            return "<" + LINK + " href=\'" + param2 + "\'><b>" + param1 + "</b></" + LINK + ">";
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
            if (_loc_3["background-color"])
            {
                param1.backgroundColor = _loc_3["background-color"];
            }
            if (_loc_3["text-decoration"])
            {
                param1.textDecoration = _loc_3["text-decoration"];
            }
            if (_loc_3["font-style"])
            {
                param1.fontStyle = _loc_3["font-style"];
            }
            return param1;
        }// end function

        public static function addValueToInlineStyle(param1:String, param2:String, param3:String) : String
        {
            if (param1.length > 0)
            {
                if (param1.charAt((param1.length - 1)) != ";")
                {
                    param1 = param1 + ";";
                }
                param1 = param1 + (param2 + ":" + param3 + ";");
            }
            else
            {
                param1 = param2 + ":" + param3 + ";";
            }
            return param1;
        }// end function

    }
}
