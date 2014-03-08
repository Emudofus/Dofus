package com.ankamagames.berilia.components
{
   public class ComponentInternalAccessor extends Object
   {
      
      public function ComponentInternalAccessor() {
         super();
      }
      
      public static function access(param1:*, param2:String) : * {
         return param1[param2];
      }
   }
}
