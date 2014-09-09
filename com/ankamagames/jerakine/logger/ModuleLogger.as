package com.ankamagames.jerakine.logger
{
   public final class ModuleLogger extends Object
   {
      
      public function ModuleLogger() {
         super();
      }
      
      public static var active:Boolean = false;
      
      private static var _callbacks:Vector.<Function>;
      
      public static function log(... args) : void {
         var f:Function = null;
         if(active)
         {
            for each(f in _callbacks)
            {
               f.apply(f,args);
            }
         }
      }
      
      public static function addCallback(callBack:Function) : void {
         _callbacks.push(callBack);
      }
   }
}
