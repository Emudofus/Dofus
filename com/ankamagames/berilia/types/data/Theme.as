package com.ankamagames.berilia.types.data
{
   public class Theme extends Object
   {
      
      public function Theme(fileName:String, name:String, description:String = "", previewUri:String = "") {
         super();
         this.name = name;
         this.description = description;
         this.previewUri = previewUri;
         this.fileName = fileName;
      }
      
      public var name:String;
      
      public var description:String;
      
      public var previewUri:String;
      
      public var fileName:String;
   }
}
