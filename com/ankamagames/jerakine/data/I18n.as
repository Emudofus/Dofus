package com.ankamagames.jerakine.data
{
   public class I18n extends AbstractDataManager
   {
      
      public function I18n() {
         super();
      }
      
      public static function addOverride(param1:uint, param2:uint) : void {
         I18nFileAccessor.getInstance().overrideId(param1,param2);
      }
      
      public static function getText(param1:uint, param2:Array=null, param3:String="%") : String {
         if(!param1)
         {
            return null;
         }
         var _loc4_:String = I18nFileAccessor.getInstance().getText(param1);
         if(_loc4_ == null || _loc4_ == "null")
         {
            return "[UNKNOWN_TEXT_ID_" + param1 + "]";
         }
         return replaceParams(_loc4_,param2,param3);
      }
      
      public static function getUiText(param1:String, param2:Array=null, param3:String="%") : String {
         var _loc4_:String = I18nFileAccessor.getInstance().getNamedText(param1);
         if(_loc4_ == null || _loc4_ == "null")
         {
            return "[UNKNOWN_TEXT_NAME_" + param1 + "]";
         }
         return replaceParams(_loc4_,param2,param3);
      }
      
      public static function hasUiText(param1:String) : Boolean {
         return I18nFileAccessor.getInstance().hasNamedText(param1);
      }
      
      public static function replaceParams(param1:String, param2:Array, param3:String) : String {
         if(!param2 || !param2.length)
         {
            return param1;
         }
         var _loc4_:Array = new Array();
         var _loc5_:uint = 1;
         while(_loc5_ <= param2.length)
         {
            param1 = param1.replace(param3 + _loc5_,param2[_loc5_-1]);
            _loc5_++;
         }
         return param1;
      }
   }
}
