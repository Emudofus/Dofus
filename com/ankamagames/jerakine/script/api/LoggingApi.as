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
      
      public static function Trace(msg:*, level:uint=0) : void {
         var str:String = "" + (!(msg == null)?msg:"NULL");
         _log.log(level,str);
      }
   }
}
