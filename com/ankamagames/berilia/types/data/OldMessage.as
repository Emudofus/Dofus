package com.ankamagames.berilia.types.data
{
   import flash.utils.Dictionary;
   
   public class OldMessage extends Object
   {
      
      public function OldMessage(pHook:Hook, pArgs:Array) {
         super();
         this.hook = pHook;
         this.args = pArgs;
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public var hook:Hook;
      
      public var args:Array;
   }
}
