package com.ankamagames.jerakine.utils.files
{
   public class FileUtils extends Object
   {
      
      public function FileUtils() {
         super();
      }
      
      public static function getExtension(sUrl:String) : String {
         if(sUrl == null)
         {
            return null;
         }
         var aTmp:Array = sUrl.split(".");
         if((!(aTmp == null)) && (aTmp.length > 1))
         {
            return aTmp[aTmp.length - 1];
         }
         return null;
      }
      
      public static function getFileName(sUrl:String) : String {
         var aTmp:Array = sUrl.split("/");
         return aTmp[aTmp.length - 1];
      }
      
      public static function getFilePath(sUrl:String) : String {
         var aTmp:Array = null;
         var aTmp2:Array = null;
         if(sUrl.indexOf("/") != -1)
         {
            aTmp = sUrl.split("/");
            aTmp.pop();
            return aTmp.join("/");
         }
         if(sUrl.indexOf("\\") != -1)
         {
            aTmp2 = sUrl.split("\\");
            aTmp2.pop();
            return aTmp2.join("\\");
         }
         return "";
      }
      
      public static function getFilePathStartName(sUrl:String) : String {
         var aTmp:Array = sUrl.split(".");
         aTmp.pop();
         return aTmp.join(".");
      }
      
      public static function getFileStartName(sUrl:String) : String {
         var aTmp:Array = sUrl.split(new RegExp("(\\/|\\|)"));
         aTmp = aTmp[aTmp.length - 1].split(".");
         aTmp.pop();
         return aTmp.join(".");
      }
   }
}
