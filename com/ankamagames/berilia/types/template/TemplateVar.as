package com.ankamagames.berilia.types.template
{
   public class TemplateVar extends Object
   {
      
      public function TemplateVar(varName:String) {
         super();
         this.name = varName;
      }
      
      public var name:String;
      
      public var value:String;
      
      public function clone() : TemplateVar {
         var tmp:TemplateVar = new TemplateVar(this.name);
         tmp.value = this.value;
         return tmp;
      }
   }
}
