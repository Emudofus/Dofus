package com.ankamagames.dofus.console.common
{
    import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
    import com.ankamagames.dofus.logic.common.frames.LatencyFrame;
    import com.ankamagames.dofus.network.messages.common.basic.BasicPingMessage;
    import com.ankamagames.jerakine.network.IServerConnection;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import flash.utils.getTimer;
    import com.ankamagames.jerakine.console.ConsoleHandler;
    import com.ankamagames.jerakine.data.I18n;

    public class LatencyInstructionHandler implements ConsoleInstructionHandler 
    {


        public function handle(console:ConsoleHandler, cmd:String, args:Array):void
        {
            var _local_4:LatencyFrame;
            var _local_5:BasicPingMessage;
            var _local_6:IServerConnection;
            switch (cmd)
            {
                case "ping":
                    _local_4 = (Kernel.getWorker().getFrame(LatencyFrame) as LatencyFrame);
                    if (_local_4.pingRequested != 0)
                    {
                        return;
                    };
                    _local_5 = new BasicPingMessage().initBasicPingMessage();
                    ConnectionsHandler.getConnection().send(_local_5);
                    _local_4.pingRequested = getTimer();
                    console.output("Ping...");
                    return;
                case "aping":
                    _local_6 = ConnectionsHandler.getConnection().mainConnection;
                    console.output((((((("Avg ping : " + _local_6.latencyAvg) + "ms for the last ") + _local_6.latencySamplesCount) + " packets (max : ") + _local_6.latencySamplesMax) + ")"));
                    return;
            };
        }

        public function getHelp(cmd:String):String
        {
            switch (cmd)
            {
                case "ping":
                    return (I18n.getUiText("ui.chat.console.help.ping"));
                case "aping":
                    return (I18n.getUiText("ui.chat.console.help.aping"));
            };
            return (I18n.getUiText("ui.chat.console.noHelp", [cmd]));
        }

        public function getParamPossibilities(cmd:String, paramIndex:uint=0, currentParams:Array=null):Array
        {
            return ([]);
        }


    }
}//package com.ankamagames.dofus.console.common

