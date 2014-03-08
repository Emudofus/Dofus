package com.ankamagames.jerakine.logger
{
   public class LogLogger extends Object implements Logger
   {
      
      public function LogLogger(param1:String) {
         super();
         this._category = param1;
      }
      
      private static var _enabled:Boolean = true;
      
      private static var _useModuleLoggerHasOutputLog:Boolean = false;
      
      public static function useModuleLoggerHasOutputLog(param1:Boolean) : void {
         _useModuleLoggerHasOutputLog = param1;
      }
      
      public static function activeLog(param1:Boolean) : void {
         _enabled = param1;
      }
      
      public static function logIsActive() : Boolean {
         return _enabled;
      }
      
      private var _category:String;
      
      public function get category() : String {
         return this._category;
      }
      
      public function trace(param1:Object) : void {
         this.log(LogLevel.TRACE,param1);
      }
      
      public function debug(param1:Object) : void {
         this.log(LogLevel.DEBUG,param1);
      }
      
      public function info(param1:Object) : void {
         this.log(LogLevel.INFO,param1);
      }
      
      public function warn(param1:Object) : void {
         this.log(LogLevel.WARN,param1);
      }
      
      public function error(param1:Object) : void {
         this.log(LogLevel.ERROR,param1);
      }
      
      public function fatal(param1:Object) : void {
         this.log(LogLevel.FATAL,param1);
      }
      
      public function logDirectly(param1:LogEvent) : void {
         if(_enabled)
         {
            Log.broadcastToTargets(param1);
         }
      }
      
      public function log(param1:uint, param2:Object) : void {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(_enabled)
         {
            _loc3_ = param2.toString();
            _loc4_ = this.getFormatedMessage(_loc3_);
            Log.broadcastToTargets(new TextLogEvent(this._category,param1 != LogLevel.COMMANDS?_loc4_:_loc3_,param1));
            if(_useModuleLoggerHasOutputLog)
            {
               ModuleLogger.log(_loc4_,param1);
            }
         }
      }
      
      private function getFormatedMessage(param1:String) : String {
         if(!param1)
         {
            param1 = "";
         }
         var _loc2_:Array = this._category.split("::");
         var _loc3_:* = "[" + _loc2_[_loc2_.length-1] + "] ";
         var _loc4_:* = "";
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc4_ + " ";
            _loc5_++;
         }
         var param1:String = param1.replace("\n","\n" + _loc4_);
         return _loc3_ + param1;
      }
      
      public function clear() : void {
         this.log(LogLevel.COMMANDS,"clear");
      }
   }
}
