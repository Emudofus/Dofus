package com.ankamagames.jerakine.types
{


   public class Callback extends Object
   {
         

      public function Callback(fMethod:Function, ... aArgs) {
         super();
         this.method=fMethod;
         this.args=aArgs;
      }



      public var method:Function;

      public var args:Array;

      public function exec() : void {
         this.method.apply(null,this.args);
      }
   }

}