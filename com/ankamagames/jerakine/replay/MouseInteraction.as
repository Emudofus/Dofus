package com.ankamagames.jerakine.replay
{
   public class MouseInteraction extends Object
   {
      
      public function MouseInteraction(target:String = null, type:String = null, x:int = 0, y:int = 0) {
         super();
         this.target = target;
         this.type = type;
         this.x = x;
         this.y = y;
      }
      
      public var target:String;
      
      public var type:String;
      
      public var x:int;
      
      public var y:int;
      
      public function toString() : String {
         return "MouseInteraction : " + this.type.split("::")[1] + " on " + this.target;
      }
   }
}
