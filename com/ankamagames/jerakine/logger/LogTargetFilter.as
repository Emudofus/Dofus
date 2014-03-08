package com.ankamagames.jerakine.logger
{
   public class LogTargetFilter extends Object
   {
      
      public function LogTargetFilter(param1:String, param2:Boolean=true) {
         super();
         this.target = param1;
         this.allow = param2;
      }
      
      public var allow:Boolean = true;
      
      public var target:String;
   }
}
