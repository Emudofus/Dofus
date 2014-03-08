package com.ankamagames.jerakine.logger
{
   public class LogTargetFilter extends Object
   {
      
      public function LogTargetFilter(pTarget:String, pAllow:Boolean=true) {
         super();
         this.target = pTarget;
         this.allow = pAllow;
      }
      
      public var allow:Boolean = true;
      
      public var target:String;
   }
}
