package com.ankamagames.berilia.managers
{
   import com.adobe.utils.StringUtil;
   import flashx.textLayout.elements.SpanElement;
   
   public class HtmlManager extends Object
   {
      
      public function HtmlManager() {
         super();
      }
      
      public static const LINK:String = "a";
      
      public static const SPAN:String = "span";
      
      public static const COLOR:String = "color";
      
      public static const UNDERLINE:String = "underline";
      
      public static const ITALIC:String = "italic";
      
      public static const BOLD:String = "bold";
      
      private static var htmlVersion:String;
      
      public static const OLD_FASHION:String = "old";
      
      public static const INLINE_CSS_VERSION:String = "inline";
      
      public static function changeCssHandler(param1:String) : void {
         switch(param1)
         {
            case OLD_FASHION:
            case INLINE_CSS_VERSION:
               htmlVersion = param1;
               break;
            default:
               htmlVersion = OLD_FASHION;
         }
      }
      
      public static function addTag(param1:String, param2:String, param3:Object=null) : String {
         if(htmlVersion == INLINE_CSS_VERSION)
         {
            if(isTagValide(param2))
            {
               return "<" + param2 + " " + formateStyleWithInlineCss(param3) + ">" + param1 + "</" + param2 + ">";
            }
            trace("ERROR TAG: \"" + param2 + "\" NOT VALID !!");
            return param1;
         }
         if(param3 == null)
         {
            param3 = new Object();
         }
         if(param2 == BOLD)
         {
            param3[BOLD] = true;
         }
         if(param2 == ITALIC)
         {
            param3[ITALIC] = true;
         }
         if(param2 == UNDERLINE)
         {
            param3["text-decoration"] = UNDERLINE;
         }
         return formateStyleWithTags(param1,param3);
      }
      
      private static function formateStyleWithInlineCss(param1:Object=null) : String {
         var _loc2_:* = "";
         if(param1 != null)
         {
            _loc2_ = _loc2_ + " style=\"";
            if(param1[COLOR])
            {
               _loc2_ = _loc2_ + ("color:" + getHexaColor(param1[COLOR]) + ";");
            }
            if(param1[ITALIC])
            {
               _loc2_ = _loc2_ + ("font-style:" + param1[ITALIC] + ";");
            }
            if(param1[BOLD])
            {
               _loc2_ = _loc2_ + "font-weight: bold;";
            }
            _loc2_ = _loc2_ + "\"";
         }
         return _loc2_;
      }
      
      private static function formateStyleWithTags(param1:String, param2:Object=null) : String {
         var _loc3_:* = "";
         if(param2 != null)
         {
            if(param2[COLOR])
            {
               _loc3_ = _loc3_ + ("<font color=\"" + getHexaColor(param2[COLOR]) + "\">");
            }
            if(param2[ITALIC])
            {
               _loc3_ = _loc3_ + "<i>";
            }
            if(param2[BOLD])
            {
               _loc3_ = _loc3_ + "<b>";
            }
            if(param2["text-decoration"] == UNDERLINE || param2["textDecoration"] == UNDERLINE)
            {
               _loc3_ = _loc3_ + "<u>";
            }
            _loc3_ = _loc3_ + param1;
            if(param2["text-decoration"] == UNDERLINE || param2["textDecoration"] == UNDERLINE)
            {
               _loc3_ = _loc3_ + "</u>";
            }
            if(param2[BOLD])
            {
               _loc3_ = _loc3_ + "</b>";
            }
            if(param2[ITALIC])
            {
               _loc3_ = _loc3_ + "</i>";
            }
            if(param2[COLOR])
            {
               _loc3_ = _loc3_ + "</font>";
            }
         }
         else
         {
            _loc3_ = param1;
         }
         return _loc3_;
      }
      
      private static function getHexaColor(param1:*) : String {
         var _loc2_:* = "";
         switch(true)
         {
            case param1 is int:
            case param1 is uint:
               _loc2_ = "#" + param1.toString(16);
               break;
            case param1 is String:
               if(param1.indexOf("#") == 0)
               {
                  _loc2_ = String(param1);
               }
               else
               {
                  _loc2_ = param1.replace("0x","#");
               }
               break;
            default:
               _loc2_ = "#FF0000";
         }
         return _loc2_;
      }
      
      public static function addLink(param1:String, param2:String="", param3:Object=null, param4:Boolean=false) : String {
         if(htmlVersion == INLINE_CSS_VERSION || (param4))
         {
            if(param3 != null)
            {
               return "<" + LINK + " href=\'" + param2 + "\'" + formateStyleWithInlineCss(param3) + ">" + param1 + "</" + LINK + ">";
            }
            return "<" + LINK + " href=\'" + param2 + "\'>" + param1 + "</" + LINK + ">";
         }
         return "<" + LINK + " href=\'" + param2 + "\'><b>" + param1 + "</b></" + LINK + ">";
      }
      
      public static function removeStyle(param1:String, param2:String, param3:Boolean=false) : String {
         return param1;
      }
      
      public static function addStyleToWords(param1:String, param2:String, param3:String) : String {
         return param1;
      }
      
      private static function isTagValide(param1:String) : Boolean {
         switch(param1)
         {
            case SPAN:
               return true;
            default:
               return false;
         }
      }
      
      public static function parseStyle(param1:String) : Array {
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc2_:Array = new Array();
         var _loc3_:Array = param1.split(";");
         for each (_loc4_ in _loc3_)
         {
            _loc5_ = _loc4_.split(":");
            if(_loc5_[0] != "")
            {
               _loc2_[_loc5_[0]] = StringUtil.trim(_loc5_[1]);
            }
         }
         return _loc2_;
      }
      
      public static function formateSpan(param1:SpanElement, param2:String) : SpanElement {
         var _loc3_:Array = parseStyle(param2);
         if(_loc3_["font-weight"])
         {
            param1.fontWeight = _loc3_["font-weight"];
         }
         if(_loc3_["color"])
         {
            param1.color = _loc3_["color"];
         }
         if(_loc3_["background-color"])
         {
            param1.backgroundColor = _loc3_["background-color"];
         }
         if(_loc3_["text-decoration"])
         {
            param1.textDecoration = _loc3_["text-decoration"];
         }
         if(_loc3_["font-style"])
         {
            param1.fontStyle = _loc3_["font-style"];
         }
         return param1;
      }
      
      public static function addValueToInlineStyle(param1:String, param2:String, param3:String) : String {
         if(param1.length > 0)
         {
            if(param1.charAt(param1.length-1) != ";")
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
      }
   }
}
