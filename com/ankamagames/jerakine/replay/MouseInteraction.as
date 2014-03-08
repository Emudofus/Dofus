package com.ankamagames.jerakine.replay
{
   public class MouseInteraction extends Object
   {
      
      public function MouseInteraction(param1:String=null, param2:String=null, param3:int=0, param4:int=0) {
         super();
         this.target = param1;
         this.type = param2;
         this.x = param3;
         this.y = param4;
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
