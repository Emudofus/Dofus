package com.ankamagames.jerakine.types
{
   public class Callback extends Object
   {
      
      public function Callback(fMethod:Function, ... aArgs) {
         super();
         this.method = fMethod;
         this.args = aArgs;
      }
      
      public static function argFromArray(fMethod:Function, args:Array) : Callback {
         var cb:Callback = new Callback(fMethod);
         cb.args = args;
         return cb;
      }
      
      public var method:Function;
      
      public var args:Array;
      
      public function exec() : * {
         return this.method.apply(null,this.args);
      }
   }
}
