package com.ankamagames.jerakine.utils.memory
{
   import flash.system.System;
   import flash.net.LocalConnection;
   
   public class Memory extends Object
   {
      
      public function Memory() {
         super();
      }
      
      private static const MOD:uint = 1024;
      
      private static const UNITS:Array;
      
      public static function usage() : uint {
         return System.totalMemory;
      }
      
      public static function humanReadableUsage() : String {
         var memory:uint = System.totalMemory;
         var i:uint = 0;
         while(memory > MOD)
         {
            memory = memory / MOD;
            i++;
         }
         return memory + " " + UNITS[i];
      }
      
      public static function gc() : void {
         try
         {
            new LocalConnection().connect("foo");
            new LocalConnection().connect("foo");
         }
         catch(e:*)
         {
         }
      }
   }
}
