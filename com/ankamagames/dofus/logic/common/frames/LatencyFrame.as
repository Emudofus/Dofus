package com.ankamagames.dofus.logic.common.frames
{
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.game.common.managers.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.common.basic.*;
    import com.ankamagames.dofus.network.messages.game.basic.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class LatencyFrame extends Object implements Frame
    {
        public var pingRequested:uint;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(LatencyFrame));

        public function LatencyFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function pushed() : Boolean
        {
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            switch(true)
            {
                case param1 is BasicPongMessage:
                {
                    _loc_2 = param1 as BasicPongMessage;
                    if (_loc_2.quiet)
                    {
                        _log.warn("I don\'t know what to do with quiest Pong messages.");
                        return false;
                    }
                    _loc_3 = getTimer();
                    _loc_4 = _loc_3 - this.pingRequested;
                    this.pingRequested = 0;
                    KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation, "Pong " + _loc_4 + "ms !", ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO, TimeManager.getInstance().getTimestamp());
                    return true;
                }
                case param1 is BasicLatencyStatsRequestMessage:
                {
                    _loc_5 = ConnectionsHandler.getConnection();
                    _loc_6 = new BasicLatencyStatsMessage();
                    _loc_6.initBasicLatencyStatsMessage(Math.min(32767, _loc_5.latencyAvg), _loc_5.latencySamplesCount, _loc_5.latencySamplesMax);
                    _loc_5.send(_loc_6);
                    return true;
                }
                default:
                {
                    break;
                }
            }
            return false;
        }// end function

        public function pulled() : Boolean
        {
            return true;
        }// end function

    }
}
