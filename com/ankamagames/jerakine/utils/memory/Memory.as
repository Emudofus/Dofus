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
      
      private static const UNITS:Array = ["B","KB","MB","GB","TB","PB"];
      
      public static function usage() : uint {
         return System.totalMemory;
      }
      
      public static function humanReadableUsage() : String {
         var _loc1_:uint = System.totalMemory;
         var _loc2_:uint = 0;
         while(_loc1_ > MOD)
         {
            _loc1_ = _loc1_ / MOD;
            _loc2_++;
         }
         return _loc1_ + " " + UNITS[_loc2_];
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
