package com.ankamagames.dofus.logic.game.common.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import com.ankamagames.dofus.network.types.game.context.fight.FightExternalInformations;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightListRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightListMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.logic.game.common.actions.spectator.MapRunningFightDetailsRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightDetailsRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.StopToListenRunningFightRequestMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightDetailsExtendedMessage;
    import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRunningFightDetailsMessage;
    import com.ankamagames.dofus.logic.game.common.actions.spectator.JoinAsSpectatorRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightJoinRequestMessage;
    import com.ankamagames.dofus.logic.game.common.actions.roleplay.JoinFightRequestAction;
    import com.ankamagames.dofus.logic.game.common.actions.spectator.GameFightSpectatePlayerRequestAction;
    import com.ankamagames.dofus.network.messages.game.context.fight.GameFightSpectatePlayerRequestMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeam;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.logic.game.common.actions.OpenCurrentFightAction;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.game.common.actions.spectator.StopToListenRunningFightAction;
    import com.ankamagames.dofus.network.enums.TeamEnum;
    import com.ankamagames.jerakine.messages.Message;
    import __AS3__.vec.*;

    public class SpectatorManagementFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SpectatorManagementFrame));


        private static function sortFights(a:FightExternalInformations, b:FightExternalInformations):int
        {
            if (a.fightStart == b.fightStart)
            {
                return (0);
            };
            if (a.fightStart == 0)
            {
                return (-1);
            };
            if (b.fightStart == 0)
            {
                return (1);
            };
            return ((b.fightStart - a.fightStart));
        }


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
            var _local_2:MapRunningFightListRequestMessage;
            var _local_3:MapRunningFightListMessage;
            var _local_4:Vector.<FightExternalInformations>;
            var _local_5:MapRunningFightDetailsRequestAction;
            var _local_6:MapRunningFightDetailsRequestMessage;
            var _local_7:StopToListenRunningFightRequestMessage;
            var _local_8:MapRunningFightDetailsExtendedMessage;
            var _local_9:String;
            var _local_10:String;
            var _local_11:MapRunningFightDetailsMessage;
            var _local_12:JoinAsSpectatorRequestAction;
            var _local_13:GameFightJoinRequestMessage;
            var _local_14:JoinFightRequestAction;
            var _local_15:GameFightSpectatePlayerRequestAction;
            var _local_16:GameFightSpectatePlayerRequestMessage;
            var f:FightExternalInformations;
            var namedTeam:NamedPartyTeam;
            switch (true)
            {
                case (msg is OpenCurrentFightAction):
                    _local_2 = new MapRunningFightListRequestMessage();
                    _local_2.initMapRunningFightListRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_2);
                    return (true);
                case (msg is MapRunningFightListMessage):
                    _local_3 = (msg as MapRunningFightListMessage);
                    _local_4 = new Vector.<FightExternalInformations>();
                    for each (f in _local_3.fights)
                    {
                        _local_4.push(f);
                    };
                    _local_4.sort(sortFights);
                    KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightList, _local_4);
                    return (true);
                case (msg is MapRunningFightDetailsRequestAction):
                    _local_5 = (msg as MapRunningFightDetailsRequestAction);
                    _local_6 = new MapRunningFightDetailsRequestMessage();
                    _local_6.initMapRunningFightDetailsRequestMessage(_local_5.fightId);
                    ConnectionsHandler.getConnection().send(_local_6);
                    return (true);
                case (msg is StopToListenRunningFightAction):
                    _local_7 = new StopToListenRunningFightRequestMessage();
                    _local_7.initStopToListenRunningFightRequestMessage();
                    ConnectionsHandler.getConnection().send(_local_7);
                    return (true);
                case (msg is MapRunningFightDetailsExtendedMessage):
                    _local_8 = (msg as MapRunningFightDetailsExtendedMessage);
                    _local_9 = "";
                    _local_10 = "";
                    for each (namedTeam in _local_8.namedPartyTeams)
                    {
                        if (((namedTeam.partyName) && (!((namedTeam.partyName == "")))))
                        {
                            if (namedTeam.teamId == TeamEnum.TEAM_CHALLENGER)
                            {
                                _local_9 = namedTeam.partyName;
                            }
                            else
                            {
                                if (namedTeam.teamId == TeamEnum.TEAM_DEFENDER)
                                {
                                    _local_10 = namedTeam.partyName;
                                };
                            };
                        };
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightDetails, _local_8.fightId, _local_8.attackers, _local_8.defenders, _local_9, _local_10);
                    return (true);
                case (msg is MapRunningFightDetailsMessage):
                    _local_11 = (msg as MapRunningFightDetailsMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.MapRunningFightDetails, _local_11.fightId, _local_11.attackers, _local_11.defenders, "", "");
                    return (true);
                case (msg is JoinAsSpectatorRequestAction):
                    _local_12 = (msg as JoinAsSpectatorRequestAction);
                    _local_13 = new GameFightJoinRequestMessage();
                    _local_13.initGameFightJoinRequestMessage(0, _local_12.fightId);
                    ConnectionsHandler.getConnection().send(_local_13);
                    return (true);
                case (msg is JoinFightRequestAction):
                    _local_14 = (msg as JoinFightRequestAction);
                    _local_13 = new GameFightJoinRequestMessage();
                    _local_13.initGameFightJoinRequestMessage(_local_14.teamLeaderId, _local_14.fightId);
                    ConnectionsHandler.getConnection().send(_local_13);
                    return (true);
                case (msg is GameFightSpectatePlayerRequestAction):
                    _local_15 = (msg as GameFightSpectatePlayerRequestAction);
                    _local_16 = new GameFightSpectatePlayerRequestMessage();
                    _local_16.initGameFightSpectatePlayerRequestMessage(_local_15.playerId);
                    ConnectionsHandler.getConnection().send(_local_16);
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

