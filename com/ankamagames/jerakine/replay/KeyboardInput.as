package com.ankamagames.jerakine.replay
{
   public class KeyboardInput extends Object
   {
      
      public function KeyboardInput(param1:String=null, param2:String=null) {
         super();
         this.target = param1;
         this.content = param2;
      }
      
      public var target:String;
      
      public var content:String;
   }
}
