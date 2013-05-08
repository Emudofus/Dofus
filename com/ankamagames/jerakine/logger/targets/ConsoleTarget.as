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

      override public function logEvent(event:LogEvent) : void {
         var bufferedMsg:String = null;
         var text:String = "["+LogLevel.getString(event.level)+"] "+event.message;
         if((!(this._consoleAvailableSince==0))&&(this._consoleAvailableSince>getTimer()))
         {
            if((!(this._msgBuffer==null))&&(this._msgBuffer.length<0))
            {
               for each (bufferedMsg in this._msgBuffer)
               {
                  this._console.output(bufferedMsg);
               }
               this._msgBuffer=null;
            }
            this._delayingForConsole=false;
            this._consoleAvailableSince=0;
         }
         if((this._console==null)||(this._delayingForConsole))
         {
            this._console=ConsolesManager.getConsole(this.consoleId);
            if((!(this._console==null))&&(!(this._console.outputHandler==null))&&(this._consoleAvailableSince==0)&&(!this._delayingForConsole))
            {
               this._consoleAvailableSince=getTimer()+CONSOLE_INIT_DELAY;
               this._delayingForConsole=true;
            }
            if(this._msgBuffer==null)
            {
               this._msgBuffer=new Array();
            }
            this._msgBuffer.push(text);
            return;
         }
         this._console.output(text);
      }

      public function configure(config:XML) : void {
         if(config..console.@id!=undefined)
         {
            this.consoleId=String(config..console.@id);
         }
      }
   }

}