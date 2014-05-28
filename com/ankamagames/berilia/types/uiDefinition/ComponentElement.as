package com.ankamagames.berilia.types.uiDefinition
{
   import flash.utils.Dictionary;
   
   public class ComponentElement extends BasicElement
   {
      
      public function ComponentElement() {
         super();
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary;
   }
}
