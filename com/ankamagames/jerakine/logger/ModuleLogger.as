package com.ankamagames.jerakine.logger
{
   public final class ModuleLogger extends Object
   {
      
      public function ModuleLogger()
      {
         super();
      }
      
      public static var active:Boolean = false;
      
      private static var _callbacks:Vector.<Function> = new Vector.<Function>(0);
      
      public static function log(... rest) : void
      {
         var _loc2_:Function = null;
         if(active)
         {
            for each(_loc2_ in _callbacks)
            {
               _loc2_.apply(_loc2_,rest);
            }
         }
      }
      
      public static function addCallback(param1:Function) : void
      {
         _callbacks.push(param1);
      }
   }
}
