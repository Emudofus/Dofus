package com.ankamagames.jerakine.replay
{
   public class KeyboardInput extends Object
   {
      
      public function KeyboardInput(target:String=null, content:String=null) {
         super();
         this.target = target;
         this.content = content;
      }
      
      public var target:String;
      
      public var content:String;
   }
}
