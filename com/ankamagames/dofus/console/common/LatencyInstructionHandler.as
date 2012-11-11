package com.ankamagames.dofus.console.common
{
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.frames.*;
    import com.ankamagames.dofus.network.messages.common.basic.*;
    import com.ankamagames.jerakine.console.*;
    import com.ankamagames.jerakine.data.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LatencyInstructionHandler extends Object implements ConsoleInstructionHandler
    {

        public function LatencyInstructionHandler()
        {
            return;
        }// end function

        public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            switch(param2)
            {
                case "ping":
                {
                    _loc_4 = Kernel.getWorker().getFrame(LatencyFrame) as LatencyFrame;
                    if (_loc_4.pingRequested != 0)
                    {
                        break;
                    }
                    _loc_5 = new BasicPingMessage().initBasicPingMessage();
                    ConnectionsHandler.getConnection().send(_loc_5);
                    _loc_4.pingRequested = getTimer();
                    param1.output("Ping...");
                    break;
                }
                case "aping":
                {
                    _loc_6 = ConnectionsHandler.getConnection();
                    param1.output("Avg ping : " + _loc_6.latencyAvg + "ms for the last " + _loc_6.latencySamplesCount + " packets (max : " + _loc_6.latencySamplesMax + ")");
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function getHelp(param1:String) : String
        {
            switch(param1)
            {
                case "ping":
                {
                    return I18n.getUiText("ui.chat.console.help.ping");
                }
                case "aping":
                {
                    return I18n.getUiText("ui.chat.console.help.aping");
                }
                default:
                {
                    break;
                }
            }
            return I18n.getUiText("ui.chat.console.noHelp", [param1]);
        }// end function

        public function getParamPossibilities(param1:String, param2:uint = 0, param3:Array = null) : Array
        {
            return [];
        }// end function

    }
}
