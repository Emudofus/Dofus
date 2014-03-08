package com.ankamagames.jerakine.logger.targets
{
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.logger.LogLevel;
   import flash.utils.getTimer;
   import com.ankamagames.jerakine.console.ConsolesManager;
   
   public class ConsoleTarget extends AbstractTarget implements ConfigurableLoggingTarget
   {
      
      public function ConsoleTarget() {
         super();
      }
      
      public static var CONSOLE_INIT_DELAY:uint = 200;
      
      protected var _console:ConsoleHandler;
      
      protected var _msgBuffer:Array;
      
      protected var _delayingForConsole:Boolean;
      
      protected var _consoleAvailableSince:uint;
      
      public var consoleId:String = "defaultConsole";
      
      override public function logEvent(param1:LogEvent) : void {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         var _loc2_:String = "[" + LogLevel.getString(param1.level) + "] " + param1.message;
         if(!(this._consoleAvailableSince == 0) && this._consoleAvailableSince < getTimer())
         {
            if(!(this._msgBuffer == null) && this._msgBuffer.length > 0)
            {
               _loc3_ = this._msgBuffer.length;
               _loc4_ = -1;
               while(++_loc4_ < _loc3_)
               {
                  this._console.output(this._msgBuffer[_loc4_]);
               }
               this._msgBuffer = null;
            }
            this._delayingForConsole = false;
            this._consoleAvailableSince = 0;
         }
         if(this._console == null || (this._delayingForConsole))
         {
            this._console = ConsolesManager.getConsole(this.consoleId);
            if(!(this._console == null) && !(this._console.outputHandler == null) && this._consoleAvailableSince == 0 && !this._delayingForConsole)
            {
               this._consoleAvailableSince = getTimer() + CONSOLE_INIT_DELAY;
               this._delayingForConsole = true;
            }
            if(this._msgBuffer == null)
            {
               this._msgBuffer = new Array();
            }
            this._msgBuffer.push(_loc2_);
            return;
         }
         this._console.output(_loc2_);
      }
      
      public function configure(param1:XML) : void {
         if(param1..console.@id != undefined)
         {
            this.consoleId = String(param1..console.@id);
         }
      }
   }
}
