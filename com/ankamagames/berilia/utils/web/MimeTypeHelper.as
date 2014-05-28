package com.ankamagames.berilia.utils.web
{
   public class MimeTypeHelper extends Object
   {
      
      public function MimeTypeHelper() {
         super();
      }
      
      public static function getMimeType(fileExtension:String) : String {
         var mimeNode:XML = null;
         mimeNode = MimeTypeHelper.mimetypeXml.mimeType.(attribute("fileExtension") == fileExtension)[0];
         if(mimeNode)
         {
            return mimeNode.@type;
         }
         return null;
      }
      
      public static const mimetypeXml:XML;
   }
}
