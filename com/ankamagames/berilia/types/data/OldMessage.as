package com.ankamagames.berilia.types.data
{
   import flash.utils.Dictionary;
   
   public class OldMessage extends Object
   {
      
      public function OldMessage(param1:Hook, param2:Array) {
         super();
         this.hook = param1;
         this.args = param2;
         MEMORY_LOG[this] = 1;
      }
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public var hook:Hook;
      
      public var args:Array;
   }
}
