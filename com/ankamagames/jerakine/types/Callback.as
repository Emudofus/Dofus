package com.ankamagames.jerakine.types
{
   public class Callback extends Object
   {
      
      public function Callback(param1:Function, ... rest) {
         super();
         this.method = param1;
         this.args = rest;
      }
      
      public static function argFromArray(param1:Function, param2:Array) : Callback {
         var _loc3_:Callback = new Callback(param1);
         _loc3_.args = param2;
         return _loc3_;
      }
      
      public var method:Function;
      
      public var args:Array;
      
      public function exec() : * {
         return this.method.apply(null,this.args);
      }
   }
}
