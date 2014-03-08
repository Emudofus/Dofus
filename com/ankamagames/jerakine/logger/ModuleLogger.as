package com.ankamagames.jerakine.logger
{
   public final class ModuleLogger extends Object
   {
      
      public function ModuleLogger() {
         super();
      }
      
      public static var active:Boolean = false;
      
      private static var _callBack:Function;
      
      public static function log(... rest) : void {
         if((active) && !(_callBack == null))
         {
            _callBack.apply(_callBack,rest);
         }
      }
      
      public static function init(param1:Function) : void {
         _callBack = param1;
      }
   }
}
