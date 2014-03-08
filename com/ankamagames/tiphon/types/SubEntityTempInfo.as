package com.ankamagames.tiphon.types
{
   import flash.display.DisplayObject;
   
   public class SubEntityTempInfo extends Object
   {
      
      public function SubEntityTempInfo(entity:DisplayObject, category:int, slot:int) {
         super();
         this.entity = entity;
         this.category = category;
         this.slot = slot;
      }
      
      public var entity:DisplayObject;
      
      public var category:int;
      
      public var slot:int;
   }
}
