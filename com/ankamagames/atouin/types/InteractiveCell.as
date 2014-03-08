package com.ankamagames.atouin.types
{
   import flash.display.DisplayObjectContainer;
   
   public class InteractiveCell extends Object
   {
      
      public function InteractiveCell(param1:uint, param2:DisplayObjectContainer, param3:Number, param4:Number) {
         super();
         this.cellId = param1;
         this.sprite = param2;
         this.x = param3;
         this.y = param4;
      }
      
      public var cellId:uint;
      
      public var sprite:DisplayObjectContainer;
      
      public var x:Number;
      
      public var y:Number;
   }
}
