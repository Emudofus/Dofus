package com.ankamagames.berilia.components
{
   public class ComponentInternalAccessor extends Object
   {
      
      public function ComponentInternalAccessor() {
         super();
      }
      
      public static function access(target:*, to:String) : * {
         return target[to];
      }
   }
}
