package com.ankamagames.jerakine.utils.files
{
   public class FileUtils extends Object
   {
      
      public function FileUtils() {
         super();
      }
      
      public static function getExtension(param1:String) : String {
         if(param1 == null)
         {
            return null;
         }
         var _loc2_:Array = param1.split(".");
         if(!(_loc2_ == null) && _loc2_.length > 1)
         {
            return _loc2_[_loc2_.length-1];
         }
         return null;
      }
      
      public static function getFileName(param1:String) : String {
         var _loc2_:Array = param1.split("/");
         return _loc2_[_loc2_.length-1];
      }
      
      public static function getFilePath(param1:String) : String {
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         if(param1.indexOf("/") != -1)
         {
            _loc2_ = param1.split("/");
            _loc2_.pop();
            return _loc2_.join("/");
         }
         if(param1.indexOf("\\") != -1)
         {
            _loc3_ = param1.split("\\");
            _loc3_.pop();
            return _loc3_.join("\\");
         }
         return "";
      }
      
      public static function getFilePathStartName(param1:String) : String {
         var _loc2_:Array = param1.split(".");
         _loc2_.pop();
         return _loc2_.join(".");
      }
      
      public static function getFileStartName(param1:String) : String {
         var _loc2_:Array = param1.split(new RegExp("(\\/|\\|)"));
         _loc2_ = _loc2_[_loc2_.length-1].split(".");
         _loc2_.pop();
         return _loc2_.join(".");
      }
   }
}
