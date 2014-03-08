package com.ankamagames.berilia.types.data
{
   public class TextTooltipInfo extends Object
   {
      
      public function TextTooltipInfo(content:String, css:String=null, cssClass:String=null, maxWidth:int=400) {
         super();
         this.content = content;
         this.css = css;
         if(cssClass)
         {
            this.cssClass = cssClass;
         }
         else
         {
            this.cssClass = "text";
         }
         this.maxWidth = maxWidth;
      }
      
      public var content:String;
      
      public var css:String;
      
      public var cssClass:String;
      
      public var maxWidth:int;
      
      public var bgCornerRadius:int = 0;
   }
}
