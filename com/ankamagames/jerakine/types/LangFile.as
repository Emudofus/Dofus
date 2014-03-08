package com.ankamagames.jerakine.types
{
   public class LangFile extends Object
   {
      
      public function LangFile(param1:String, param2:String, param3:String, param4:LangMetaData=null) {
         super();
         this.content = param1;
         this.url = param3;
         this.category = param2;
         this.metaData = param4;
      }
      
      public var content:String;
      
      public var url:String;
      
      public var category:String;
      
      public var metaData:LangMetaData;
   }
}
