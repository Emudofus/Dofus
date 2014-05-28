package com.ankamagames.jerakine.replay
{
   public class KeyboardShortcut extends Object
   {
      
      public function KeyboardShortcut(targetedShortcut:String = null) {
         super();
         this.targetedShortcut = targetedShortcut;
      }
      
      public var targetedShortcut:String;
   }
}
