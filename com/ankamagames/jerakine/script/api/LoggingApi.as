package com.ankamagames.jerakine.script.api
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   
   public class LoggingApi extends Object
   {
      
      public function LoggingApi() {
         super();
      }
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LoggingApi));
      
      public static function Trace(param1:*, param2:uint=0) : void {
         var _loc3_:String = "" + (param1 != null?param1:"NULL");
         _log.log(param2,_loc3_);
      }
   }
}
