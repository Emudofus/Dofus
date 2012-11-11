package com.ankamagames.jerakine.logger.targets
{
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.logger.targets.*;
    import flash.utils.*;

    public class ConsoleTarget extends AbstractTarget implements ConfigurableLoggingTarget
    {
        protected var _console:ConsoleHandler;
        protected var _msgBuffer:Array;
        protected var _delayingForConsole:Boolean;
        protected var _consoleAvailableSince:uint;
        public var consoleId:String = "defaultConsole";
        public static var CONSOLE_INIT_DELAY:uint = 200;

        public function ConsoleTarget()
        {
            return;
        }// end function

        override public function logEvent(event:LogEvent) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = "[" + LogLevel.getString(event.level) + "] " + event.message;
            if (this._consoleAvailableSince != 0 && this._consoleAvailableSince < getTimer())
            {
                if (this._msgBuffer != null && this._msgBuffer.length > 0)
                {
                    for each (_loc_3 in this._msgBuffer)
                    {
                        
                        this._console.output(_loc_3);
                    }
                    this._msgBuffer = null;
                }
                this._delayingForConsole = false;
                this._consoleAvailableSince = 0;
            }
            if (this._console == null || this._delayingForConsole)
            {
                this._console = ConsolesManager.getConsole(this.consoleId);
                if (this._console != null && this._console.outputHandler != null && this._consoleAvailableSince == 0 && !this._delayingForConsole)
                {
                    this._consoleAvailableSince = getTimer() + CONSOLE_INIT_DELAY;
                    this._delayingForConsole = true;
                }
                if (this._msgBuffer == null)
                {
                    this._msgBuffer = new Array();
                }
                this._msgBuffer.push(_loc_2);
                return;
            }
            this._console.output(_loc_2);
            return;
        }// end function

        public function configure(param1:XML) : void
        {
            if (param1..console.@id != undefined)
            {
                this.consoleId = String(param1..console.@id);
            }
            return;
        }// end function

    }
}
