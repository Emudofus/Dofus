package com.ankamagames.dofus.logic.connection.frames
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.*;
    import com.ankamagames.berilia.managers.*;
    import com.ankamagames.dofus.datacenter.servers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.kernel.net.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.connection.actions.*;
    import com.ankamagames.dofus.logic.connection.managers.*;
    import com.ankamagames.dofus.logic.game.approach.frames.*;
    import com.ankamagames.dofus.misc.lists.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.messages.connection.*;
    import com.ankamagames.dofus.network.messages.connection.search.*;
    import com.ankamagames.dofus.network.types.connection.*;
    import com.ankamagames.jerakine.logger.*;
    import com.ankamagames.jerakine.messages.*;
    import com.ankamagames.jerakine.network.messages.*;
    import com.ankamagames.jerakine.types.enums.*;
    import flash.utils.*;

    public class ServerSelectionFrame extends Object implements Frame
    {
        private var _serversList:Vector.<GameServerInformations>;
        private var _serversUsedList:Vector.<GameServerInformations>;
        private var _serversListMessage:ServersListMessage;
        private var _selectedServer:SelectedServerDataMessage;
        private var _worker:Worker;
        static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerSelectionFrame));

        public function ServerSelectionFrame()
        {
            return;
        }// end function

        public function get priority() : int
        {
            return Priority.NORMAL;
        }// end function

        public function get usedServers() : Vector.<GameServerInformations>
        {
            return this._serversUsedList;
        }// end function

        public function get servers() : Vector.<GameServerInformations>
        {
            return this._serversList;
        }// end function

        public function pushed() : Boolean
        {
            this._worker = Kernel.getWorker();
            return true;
        }// end function

        public function process(param1:Message) : Boolean
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = undefined;
            var _loc_15:* = null;
            var _loc_16:* = null;
            switch(true)
            {
                case param1 is ServersListMessage:
                {
                    _loc_2 = param1 as ServersListMessage;
                    PlayerManager.getInstance().server = null;
                    this._serversList = _loc_2.servers;
                    this._serversListMessage = _loc_2;
                    if (!Berilia.getInstance().uiList["CharacterHeader"])
                    {
                        KernelEventsManager.getInstance().processCallback(HookList.AuthenticationTicketAccepted);
                    }
                    this.broadcastServersListUpdate();
                    return true;
                }
                case param1 is ServerStatusUpdateMessage:
                {
                    _loc_3 = param1 as ServerStatusUpdateMessage;
                    this._serversList.forEach(this.getUpdateServerFunction(_loc_3.server));
                    _log.debug("[" + _loc_3.server.id + "] Status changed to " + _loc_3.server.status + ".");
                    this.broadcastServersListUpdate();
                    return true;
                }
                case param1 is ServerSelectionAction:
                {
                    _loc_4 = param1 as ServerSelectionAction;
                    for each (_loc_14 in this._serversList)
                    {
                        
                        if (_loc_14.id == _loc_4.serverId)
                        {
                            if (_loc_14.status == ServerStatusEnum.ONLINE)
                            {
                                _loc_15 = new ServerSelectionMessage();
                                _loc_15.initServerSelectionMessage(_loc_4.serverId);
                                ConnectionsHandler.getConnection().send(_loc_15);
                                continue;
                            }
                            _loc_16 = "Status";
                            switch(_loc_14.status)
                            {
                                case ServerStatusEnum.OFFLINE:
                                {
                                    _loc_16 = _loc_16 + "Offline";
                                    break;
                                }
                                case ServerStatusEnum.STARTING:
                                {
                                    _loc_16 = _loc_16 + "Starting";
                                    break;
                                }
                                case ServerStatusEnum.NOJOIN:
                                {
                                    _loc_16 = _loc_16 + "Nojoin";
                                    break;
                                }
                                case ServerStatusEnum.SAVING:
                                {
                                    _loc_16 = _loc_16 + "Saving";
                                    break;
                                }
                                case ServerStatusEnum.STOPING:
                                {
                                    _loc_16 = _loc_16 + "Stoping";
                                    break;
                                }
                                case ServerStatusEnum.FULL:
                                {
                                    _loc_16 = _loc_16 + "Full";
                                    break;
                                }
                                case ServerStatusEnum.STATUS_UNKNOWN:
                                {
                                }
                                default:
                                {
                                    _loc_16 = _loc_16 + "Unknown";
                                    break;
                                    break;
                                }
                            }
                            KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused, _loc_14.id, _loc_16, this.getSelectableServers());
                        }
                    }
                    return true;
                }
                case param1 is SelectedServerDataMessage:
                {
                    _loc_5 = param1 as SelectedServerDataMessage;
                    ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER);
                    this._selectedServer = _loc_5;
                    AuthentificationManager.getInstance().gameServerTicket = _loc_5.ticket;
                    PlayerManager.getInstance().server = Server.getServerById(_loc_5.serverId);
                    return true;
                }
                case param1 is ExpectedSocketClosureMessage:
                {
                    _loc_6 = param1 as ExpectedSocketClosureMessage;
                    if (_loc_6.reason != DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER)
                    {
                        this._worker.process(new WrongSocketClosureReasonMessage(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER, _loc_6.reason));
                        return true;
                    }
                    this._worker.removeFrame(this);
                    this._worker.addFrame(new GameServerApproachFrame());
                    ConnectionsHandler.connectToGameServer(this._selectedServer.address, this._selectedServer.port);
                    return true;
                }
                case param1 is AcquaintanceSearchAction:
                {
                    _loc_7 = param1 as AcquaintanceSearchAction;
                    _loc_8 = new AcquaintanceSearchMessage();
                    _loc_8.initAcquaintanceSearchMessage(_loc_7.friendName);
                    ConnectionsHandler.getConnection().send(_loc_8);
                    return true;
                }
                case param1 is AcquaintanceSearchErrorMessage:
                {
                    _loc_9 = param1 as AcquaintanceSearchErrorMessage;
                    switch(_loc_9.reason)
                    {
                        case 1:
                        {
                            _loc_10 = "unavailable";
                            break;
                        }
                        case 2:
                        {
                            _loc_10 = "no_result";
                            break;
                        }
                        case 3:
                        {
                            _loc_10 = "flood";
                            break;
                        }
                        case 0:
                        {
                        }
                        default:
                        {
                            _loc_10 = "unknown";
                            break;
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceSearchError, _loc_10);
                    return true;
                }
                case param1 is AcquaintanceServerListMessage:
                {
                    _loc_11 = param1 as AcquaintanceServerListMessage;
                    KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceServerList, _loc_11.servers);
                    return true;
                }
                case param1 is SelectedServerRefusedMessage:
                {
                    _loc_12 = param1 as SelectedServerRefusedMessage;
                    this._serversList.forEach(this.getUpdateServerStatusFunction(_loc_12.serverId, _loc_12.serverStatus));
                    this.broadcastServersListUpdate();
                    switch(_loc_12.error)
                    {
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_DUE_TO_STATUS:
                        {
                            _loc_13 = "Status";
                            switch(_loc_12.serverStatus)
                            {
                                case ServerStatusEnum.OFFLINE:
                                {
                                    _loc_13 = _loc_13 + "Offline";
                                    break;
                                }
                                case ServerStatusEnum.STARTING:
                                {
                                    _loc_13 = _loc_13 + "Starting";
                                    break;
                                }
                                case ServerStatusEnum.NOJOIN:
                                {
                                    _loc_13 = _loc_13 + "Nojoin";
                                    break;
                                }
                                case ServerStatusEnum.SAVING:
                                {
                                    _loc_13 = _loc_13 + "Saving";
                                    break;
                                }
                                case ServerStatusEnum.STOPING:
                                {
                                    _loc_13 = _loc_13 + "Stoping";
                                    break;
                                }
                                case ServerStatusEnum.FULL:
                                {
                                    _loc_13 = _loc_13 + "Full";
                                    break;
                                }
                                case ServerStatusEnum.STATUS_UNKNOWN:
                                {
                                }
                                default:
                                {
                                    _loc_13 = _loc_13 + "Unknown";
                                    break;
                                    break;
                                }
                            }
                            break;
                        }
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_ACCOUNT_RESTRICTED:
                        {
                            _loc_13 = "AccountRestricted";
                            break;
                        }
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_COMMUNITY_RESTRICTED:
                        {
                            _loc_13 = "CommunityRestricted";
                            break;
                        }
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_LOCATION_RESTRICTED:
                        {
                            _loc_13 = "LocationRestricted";
                            break;
                        }
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_SUBSCRIBERS_ONLY:
                        {
                            _loc_13 = "SubscribersOnly";
                            break;
                        }
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_REGULAR_PLAYERS_ONLY:
                        {
                            _loc_13 = "RegularPlayersOnly";
                            break;
                        }
                        case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_NO_REASON:
                        {
                        }
                        default:
                        {
                            _loc_13 = "NoReason";
                            break;
                            break;
                        }
                    }
                    KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused, _loc_12.serverId, _loc_13, this.getSelectableServers());
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

        private function getSelectableServers() : Array
        {
            var _loc_2:* = undefined;
            var _loc_1:* = new Array();
            for each (_loc_2 in this._serversList)
            {
                
                if (_loc_2.status == ServerStatusEnum.ONLINE && _loc_2.isSelectable)
                {
                    _loc_1.push(_loc_2.id);
                }
            }
            return _loc_1;
        }// end function

        private function broadcastServersListUpdate() : void
        {
            var _loc_1:* = null;
            this._serversUsedList = new Vector.<GameServerInformations>;
            for each (_loc_1 in this._serversList)
            {
                
                _log.warn("serveur " + _loc_1.id);
                if (_loc_1.charactersCount > 0)
                {
                    _log.warn("   " + _loc_1.charactersCount + " perso");
                    this._serversUsedList.push(_loc_1);
                }
            }
            KernelEventsManager.getInstance().processCallback(HookList.ServersList, this._serversList);
            return;
        }// end function

        private function getUpdateServerFunction(param1:GameServerInformations) : Function
        {
            var serverToUpdate:* = param1;
            return function (param1, param2:int, param3:Vector.<GameServerInformations>) : void
            {
                var _loc_4:* = param1 as GameServerInformations;
                if (serverToUpdate.id == _loc_4.id)
                {
                    _loc_4.charactersCount = serverToUpdate.charactersCount;
                    _loc_4.completion = serverToUpdate.completion;
                    _loc_4.isSelectable = serverToUpdate.isSelectable;
                    _loc_4.status = serverToUpdate.status;
                }
                return;
            }// end function
            ;
        }// end function

        private function getUpdateServerStatusFunction(param1:uint, param2:uint) : Function
        {
            var serverId:* = param1;
            var newStatus:* = param2;
            return function (param1, param2:int, param3:Vector.<GameServerInformations>) : void
            {
                var _loc_4:* = param1 as GameServerInformations;
                if (serverId == _loc_4.id)
                {
                    _loc_4.status = newStatus;
                }
                return;
            }// end function
            ;
        }// end function

    }
}
