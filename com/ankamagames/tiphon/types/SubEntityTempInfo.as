package com.ankamagames.tiphon.types
{
   import flash.display.DisplayObject;
   
   public class SubEntityTempInfo extends Object
   {
      
      public function SubEntityTempInfo(param1:DisplayObject, param2:int, param3:int) {
         super();
         this.entity = param1;
         this.category = param2;
         this.slot = param3;
      }
      
      public var entity:DisplayObject;
      
      public var category:int;
      
      public var slot:int;
   }
}
