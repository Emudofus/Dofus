package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.common.basic.BasicPongMessage;
    import com.ankamagames.jerakine.network.IServerConnection;
    import com.ankamagames.dofus.network.messages.game.basic.BasicLatencyStatsMessage;
    import flash.utils.getTimer;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.ChatHookList;
    import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
    import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.network.messages.game.basic.BasicLatencyStatsRequestMessage;
    import com.ankamagames.jerakine.messages.Message;

    public class LatencyFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(LatencyFrame));

        public var pingRequested:uint;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:BasicPongMessage;
            var _local_3:uint;
            var _local_4:uint;
            var _local_5:IServerConnection;
            var _local_6:BasicLatencyStatsMessage;
            switch (true)
            {
                case (msg is BasicPongMessage):
                    _local_2 = (msg as BasicPongMessage);
                    if (_local_2.quiet)
                    {
                        return (true);
                    };
                    _local_3 = getTimer();
                    _local_4 = (_local_3 - this.pingRequested);
                    this.pingRequested = 0;
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, (("Pong " + _local_4) + "ms !"), ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return (true);
                case (msg is BasicLatencyStatsRequestMessage):
                    _local_5 = ConnectionsHandler.getConnection().mainConnection;
                    _local_6 = new BasicLatencyStatsMessage();
                    _local_6.initBasicLatencyStatsMessage(Math.min(32767, _local_5.latencyAvg), _local_5.latencySamplesCount, _local_5.latencySamplesMax);
                    _local_5.send(_local_6);
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.common.frames

