package com.ankamagames.dofus.logic.connection.frames
{
    import com.ankamagames.jerakine.messages.Frame;
    import com.ankamagames.jerakine.logger.Logger;
    import com.ankamagames.jerakine.logger.Log;
    import flash.utils.getQualifiedClassName;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.connection.GameServerInformations;
    import com.ankamagames.dofus.network.messages.connection.ServersListMessage;
    import com.ankamagames.dofus.network.messages.connection.SelectedServerDataMessage;
    import com.ankamagames.jerakine.messages.Worker;
    import com.ankamagames.jerakine.types.enums.Priority;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.network.messages.connection.ServerStatusUpdateMessage;
    import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
    import com.ankamagames.dofus.network.messages.connection.SelectedServerDataExtendedMessage;
    import com.ankamagames.jerakine.network.messages.ExpectedSocketClosureMessage;
    import com.ankamagames.dofus.logic.connection.actions.AcquaintanceSearchAction;
    import com.ankamagames.dofus.network.messages.connection.search.AcquaintanceSearchMessage;
    import com.ankamagames.dofus.network.messages.connection.search.AcquaintanceSearchErrorMessage;
    import com.ankamagames.dofus.network.messages.connection.search.AcquaintanceServerListMessage;
    import com.ankamagames.dofus.network.messages.connection.SelectedServerRefusedMessage;
    import com.ankamagames.dofus.network.messages.connection.ServerSelectionMessage;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.berilia.Berilia;
    import com.ankamagames.berilia.managers.KernelEventsManager;
    import com.ankamagames.dofus.misc.lists.HookList;
    import com.ankamagames.dofus.logic.connection.managers.GuestModeManager;
    import com.ankamagames.dofus.network.enums.ServerStatusEnum;
    import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
    import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
    import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
    import com.ankamagames.dofus.datacenter.servers.Server;
    import com.ankamagames.jerakine.network.messages.WrongSocketClosureReasonMessage;
    import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
    import com.ankamagames.dofus.network.enums.ServerConnectionErrorEnum;
    import com.ankamagames.jerakine.messages.Message;
    import com.ankamagames.jerakine.messages.*;
    import __AS3__.vec.*;

    public class ServerSelectionFrame implements Frame 
    {

        protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerSelectionFrame));

        private var _serversList:Vector.<GameServerInformations>;
        private var _serversUsedList:Vector.<GameServerInformations>;
        private var _serversListMessage:ServersListMessage;
        private var _selectedServer:SelectedServerDataMessage;
        private var _worker:Worker;


        private static function serverDateSortFunction(a:GameServerInformations, b:GameServerInformations):Number
        {
            if (a.date < b.date)
            {
                return (1);
            };
            if (a.date == b.date)
            {
                return (0);
            };
            return (-1);
        }


        public function get priority():int
        {
            return (Priority.NORMAL);
        }

        public function get usedServers():Vector.<GameServerInformations>
        {
            return (this._serversUsedList);
        }

        public function get servers():Vector.<GameServerInformations>
        {
            return (this._serversList);
        }

        public function pushed():Boolean
        {
            this._worker = Kernel.getWorker();
            return (true);
        }

        public function process(msg:Message):Boolean
        {
            var _local_2:ServersListMessage;
            var _local_3:ServerStatusUpdateMessage;
            var _local_4:ServerSelectionAction;
            var _local_5:SelectedServerDataExtendedMessage;
            var _local_6:SelectedServerDataMessage;
            var _local_7:ExpectedSocketClosureMessage;
            var _local_8:AcquaintanceSearchAction;
            var _local_9:AcquaintanceSearchMessage;
            var _local_10:AcquaintanceSearchErrorMessage;
            var _local_11:String;
            var _local_12:AcquaintanceServerListMessage;
            var _local_13:SelectedServerRefusedMessage;
            var _local_14:String;
            var server:*;
            var ssmsg:ServerSelectionMessage;
            var _local_17:String;
            var sdeid:int;
            switch (true)
            {
                case (msg is ServersListMessage):
                    _local_2 = (msg as ServersListMessage);
                    PlayerManager.getInstance().server = null;
                    this._serversList = _local_2.servers;
                    this._serversListMessage = _local_2;
                    this._serversList.sort(serverDateSortFunction);
                    if (!(Berilia.getInstance().uiList["CharacterHeader"]))
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.AuthenticationTicketAccepted);
                    };
                    this.broadcastServersListUpdate();
                    return (true);
                case (msg is ServerStatusUpdateMessage):
                    _local_3 = (msg as ServerStatusUpdateMessage);
                    this._serversList.forEach(this.getUpdateServerFunction(_local_3.server));
                    _log.info((((("Server " + _local_3.server.id) + " status changed to ") + _local_3.server.status) + "."));
                    this.broadcastServersListUpdate();
                    return (true);
                case (msg is ServerSelectionAction):
                    _local_4 = (msg as ServerSelectionAction);
                    GuestModeManager.getInstance().forceGuestMode = false;
                    for each (server in this._serversList)
                    {
                        if (server.id == _local_4.serverId)
                        {
                            if (server.status == ServerStatusEnum.ONLINE)
                            {
                                ssmsg = new ServerSelectionMessage();
                                ssmsg.initServerSelectionMessage(_local_4.serverId);
                                ConnectionsHandler.getConnection().send(ssmsg);
                            }
                            else
                            {
                                _local_17 = "Status";
                                switch (server.status)
                                {
                                    case ServerStatusEnum.OFFLINE:
                                        _local_17 = (_local_17 + "Offline");
                                        break;
                                    case ServerStatusEnum.STARTING:
                                        _local_17 = (_local_17 + "Starting");
                                        break;
                                    case ServerStatusEnum.NOJOIN:
                                        _local_17 = (_local_17 + "Nojoin");
                                        break;
                                    case ServerStatusEnum.SAVING:
                                        _local_17 = (_local_17 + "Saving");
                                        break;
                                    case ServerStatusEnum.STOPING:
                                        _local_17 = (_local_17 + "Stoping");
                                        break;
                                    case ServerStatusEnum.FULL:
                                        _local_17 = (_local_17 + "Full");
                                        break;
                                    case ServerStatusEnum.STATUS_UNKNOWN:
                                    default:
                                        _local_17 = (_local_17 + "Unknown");
                                };
                                KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused, server.id, _local_17, this.getSelectableServers());
                            };
                        };
                    };
                    return (true);
                case (msg is SelectedServerDataExtendedMessage):
                    _local_5 = (msg as SelectedServerDataExtendedMessage);
                    PlayerManager.getInstance().serversList = new Vector.<int>();
                    for each (sdeid in _local_5.serverIds)
                    {
                        PlayerManager.getInstance().serversList.push(sdeid);
                    };
                case (msg is SelectedServerDataMessage):
                    _local_6 = (msg as SelectedServerDataMessage);
                    ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER);
                    this._selectedServer = _local_6;
                    AuthentificationManager.getInstance().gameServerTicket = _local_6.ticket;
                    PlayerManager.getInstance().server = Server.getServerById(_local_6.serverId);
                    return (true);
                case (msg is ExpectedSocketClosureMessage):
                    _local_7 = (msg as ExpectedSocketClosureMessage);
                    if (_local_7.reason != DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER)
                    {
                        this._worker.process(new WrongSocketClosureReasonMessage(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER, _local_7.reason));
                        return (true);
                    };
                    this._worker.removeFrame(this);
                    this._worker.addFrame(new GameServerApproachFrame());
                    ConnectionsHandler.connectToGameServer(this._selectedServer.address, this._selectedServer.port);
                    return (true);
                case (msg is AcquaintanceSearchAction):
                    _local_8 = (msg as AcquaintanceSearchAction);
                    _local_9 = new AcquaintanceSearchMessage();
                    _local_9.initAcquaintanceSearchMessage(_local_8.friendName);
                    ConnectionsHandler.getConnection().send(_local_9);
                    return (true);
                case (msg is AcquaintanceSearchErrorMessage):
                    _local_10 = (msg as AcquaintanceSearchErrorMessage);
                    switch (_local_10.reason)
                    {
                        case 1:
                            _local_11 = "unavailable";
                            break;
                        case 2:
                            _local_11 = "no_result";
                            break;
                        case 3:
                            _local_11 = "flood";
                            break;
                        case 0:
                        default:
                            _local_11 = "unknown";
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceSearchError, _local_11);
                    return (true);
                case (msg is AcquaintanceServerListMessage):
                    _local_12 = (msg as AcquaintanceServerListMessage);
                    KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceServerList, _local_12.servers);
                    return (true);
                case (msg is SelectedServerRefusedMessage):
                    _local_13 = (msg as SelectedServerRefusedMessage);
                    this._serversList.forEach(this.getUpdateServerStatusFunction(_local_13.serverId, _local_13.serverStatus));
                    this.broadcastServersListUpdate();
                    switch (_local_13.error)
                    {
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_DUE_TO_STATUS:
                            _local_14 = "Status";
                            switch (_local_13.serverStatus)
                            {
                                case ServerStatusEnum.OFFLINE:
                                    _local_14 = (_local_14 + "Offline");
                                    break;
                                case ServerStatusEnum.STARTING:
                                    _local_14 = (_local_14 + "Starting");
                                    break;
                                case ServerStatusEnum.NOJOIN:
                                    _local_14 = (_local_14 + "Nojoin");
                                    break;
                                case ServerStatusEnum.SAVING:
                                    _local_14 = (_local_14 + "Saving");
                                    break;
                                case ServerStatusEnum.STOPING:
                                    _local_14 = (_local_14 + "Stoping");
                                    break;
                                case ServerStatusEnum.FULL:
                                    _local_14 = (_local_14 + "Full");
                                    break;
                                case ServerStatusEnum.STATUS_UNKNOWN:
                                default:
                                    _local_14 = (_local_14 + "Unknown");
                            };
                            break;
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_ACCOUNT_RESTRICTED:
                            _local_14 = "AccountRestricted";
                            break;
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_COMMUNITY_RESTRICTED:
                            _local_14 = "CommunityRestricted";
                            break;
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_LOCATION_RESTRICTED:
                            _local_14 = "LocationRestricted";
                            break;
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_SUBSCRIBERS_ONLY:
                            _local_14 = "SubscribersOnly";
                            break;
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_REGULAR_PLAYERS_ONLY:
                            _local_14 = "RegularPlayersOnly";
                            break;
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_NO_REASON:
                        default:
                            _local_14 = "NoReason";
                    };
                    KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused, _local_13.serverId, _local_14, this.getSelectableServers());
                    return (true);
            };
            return (false);
        }

        public function pulled():Boolean
        {
            return (true);
        }

        private function getSelectableServers():Array
        {
            var server:*;
            var selectableServers:Array = new Array();
            for each (server in this._serversList)
            {
                if ((((server.status == ServerStatusEnum.ONLINE)) && (server.isSelectable)))
                {
                    selectableServers.push(server.id);
                };
            };
            return (selectableServers);
        }

        private function broadcastServersListUpdate():void
        {
            var server:Object;
            this._serversUsedList = new Vector.<GameServerInformations>();
            PlayerManager.getInstance().serversList = new Vector.<int>();
            for each (server in this._serversList)
            {
                if (server.charactersCount > 0)
                {
                    this._serversUsedList.push(server);
                    PlayerManager.getInstance().serversList.push(server.id);
                };
            };
            KernelEventsManager.getInstance().processCallback(HookList.ServersList, this._serversList);
        }

        private function getUpdateServerFunction(serverToUpdate:GameServerInformations):Function
        {
            return (function (element:*, index:int, arr:Vector.<GameServerInformations>):void
            {
                var gsi:* = (element as GameServerInformations);
                if (serverToUpdate.id == gsi.id)
                {
                    gsi.charactersCount = serverToUpdate.charactersCount;
                    gsi.completion = serverToUpdate.completion;
                    gsi.isSelectable = serverToUpdate.isSelectable;
                    gsi.status = serverToUpdate.status;
                };
            });
        }

        private function getUpdateServerStatusFunction(serverId:uint, newStatus:uint):Function
        {
            return (function (element:*, index:int, arr:Vector.<GameServerInformations>):void
            {
                var gsi:* = (element as GameServerInformations);
                if (serverId == gsi.id)
                {
                    gsi.status = newStatus;
                };
            });
        }


    }
}//package com.ankamagames.dofus.logic.connection.frames

