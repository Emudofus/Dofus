package com.ankamagames.jerakine.logger
{
   public final class ModuleLogger extends Object
   {
      
      public function ModuleLogger() {
         super();
      }
      
      public static var active:Boolean = false;
      
      private static var _callBack:Function;
      
      public static function log(... args) : void {
         if((active) && (!(_callBack == null)))
         {
            _callBack.apply(_callBack,args);
         }
      }
      
      public static function init(callBack:Function) : void {
         _callBack = callBack;
      }
   }
}
