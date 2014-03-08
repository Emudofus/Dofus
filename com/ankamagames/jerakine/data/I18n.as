package com.ankamagames.jerakine.data
{
   public class I18n extends AbstractDataManager
   {
      
      public function I18n() {
         super();
      }
      
      public static function addOverride(id:uint, newId:uint) : void {
         I18nFileAccessor.getInstance().overrideId(id,newId);
      }
      
      public static function getText(id:uint, params:Array=null, replace:String="%") : String {
         if(!id)
         {
            return null;
         }
         var txt:String = I18nFileAccessor.getInstance().getText(id);
         if((txt == null) || (txt == "null"))
         {
            return "[UNKNOWN_TEXT_ID_" + id + "]";
         }
         return replaceParams(txt,params,replace);
      }
      
      public static function getUiText(textId:String, params:Array=null, replace:String="%") : String {
         var txt:String = I18nFileAccessor.getInstance().getNamedText(textId);
         if((txt == null) || (txt == "null"))
         {
            return "[UNKNOWN_TEXT_NAME_" + textId + "]";
         }
         return replaceParams(txt,params,replace);
      }
      
      public static function hasUiText(textId:String) : Boolean {
         return I18nFileAccessor.getInstance().hasNamedText(textId);
      }
      
      public static function replaceParams(text:String, params:Array, replace:String) : String {
         if((!params) || (!params.length))
         {
            return text;
         }
         var prc:Array = new Array();
         var i:uint = 1;
         while(i <= params.length)
         {
            text = text.replace(replace + i,params[i - 1]);
            i++;
         }
         return text;
      }
   }
}
