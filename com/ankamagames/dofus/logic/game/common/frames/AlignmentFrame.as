package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.logic.game.common.actions.alignment.SetEnablePVPRequestAction;
    import com.ankamagames.dofus.network.messages.game.pvp.SetEnablePVPRequestMessage;
    import com.ankamagames.dofus.network.messages.game.pvp.AlignmentRankUpdateMessage;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.AlignmentHookList;
    import com.ankamagames.jerakine.messages.Message;

    public class AlignmentFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentFrame));

        private var _alignmentRank:int = -1;


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get playerRank():int
        {
            return (this._alignmentRank);
        }

        public function pushed():Boolean
        {
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:SetEnablePVPRequestAction;
            var _local_3:SetEnablePVPRequestMessage;
            var _local_4:AlignmentRankUpdateMessage;
            switch (true)
            {
                case (msg is SetEnablePVPRequestAction):
                    _local_2 = (msg as SetEnablePVPRequestAction);
                    _local_3 = new SetEnablePVPRequestMessage();
                    _local_3.initSetEnablePVPRequestMessage(_local_2.enable);
                    ConnectionsHandler.getConnection().send(_local_3);
                    return (true);
                case (msg is AlignmentRankUpdateMessage):
                    _local_4 = (msg as AlignmentRankUpdateMessage);
                    this._alignmentRank = _local_4.alignmentRank;
                    if (_local_4.verbose)
                    {
                        KernelEventsManager.getInstance().processCallback(AlignmentHookList.AlignmentRankUpdate, _local_4.alignmentRank);
                    };
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }


    }
}//package com.ankamagames.dofus.logic.game.common.frames

