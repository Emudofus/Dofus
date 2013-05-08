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
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.dofus.network.messages.connection.ServerStatusUpdateMessage;
   import com.ankamagames.dofus.logic.connection.actions.ServerSelectionAction;
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
   import com.ankamagames.dofus.network.enums.ServerStatusEnum;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.net.DisconnectionReasonEnum;
   import com.ankamagames.dofus.logic.connection.managers.AuthentificationManager;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.jerakine.network.messages.WrongSocketClosureReasonMessage;
   import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
   import com.ankamagames.dofus.network.enums.ServerConnectionErrorEnum;


   public class ServerSelectionFrame extends Object implements Frame
   {
         

      public function ServerSelectionFrame() {
         super();
      }

      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ServerSelectionFrame));

      private var _serversList:Vector.<GameServerInformations>;

      private var _serversUsedList:Vector.<GameServerInformations>;

      private var _serversListMessage:ServersListMessage;

      private var _selectedServer:SelectedServerDataMessage;

      private var _worker:Worker;

      public function get priority() : int {
         return Priority.NORMAL;
      }

      public function get usedServers() : Vector.<GameServerInformations> {
         return this._serversUsedList;
      }

      public function get servers() : Vector.<GameServerInformations> {
         return this._serversList;
      }

      public function pushed() : Boolean {
         this._worker=Kernel.getWorker();
         return true;
      }

      public function process(msg:Message) : Boolean {
         var slmsg:ServersListMessage = null;
         var ssumsg:ServerStatusUpdateMessage = null;
         var ssaction:ServerSelectionAction = null;
         var ssdmsg:SelectedServerDataMessage = null;
         var escmsg:ExpectedSocketClosureMessage = null;
         var asaction:AcquaintanceSearchAction = null;
         var asmsg:AcquaintanceSearchMessage = null;
         var asemsg:AcquaintanceSearchErrorMessage = null;
         var reasonSearchError:String = null;
         var aslmsg:AcquaintanceServerListMessage = null;
         var ssrmsg:SelectedServerRefusedMessage = null;
         var error:String = null;
         var server:* = undefined;
         var ssmsg:ServerSelectionMessage = null;
         var errorText:String = null;
         switch(true)
         {
            case msg is ServersListMessage:
               slmsg=msg as ServersListMessage;
               PlayerManager.getInstance().server=null;
               this._serversList=slmsg.servers;
               this._serversListMessage=slmsg;
               if(!Berilia.getInstance().uiList["CharacterHeader"])
               {
                  KernelEventsManager.getInstance().processCallback(HookList.AuthenticationTicketAccepted);
               }
               this.broadcastServersListUpdate();
               return true;
            case msg is ServerStatusUpdateMessage:
               ssumsg=msg as ServerStatusUpdateMessage;
               this._serversList.forEach(this.getUpdateServerFunction(ssumsg.server));
               _log.debug("["+ssumsg.server.id+"] Status changed to "+ssumsg.server.status+".");
               this.broadcastServersListUpdate();
               return true;
            case msg is ServerSelectionAction:
               ssaction=msg as ServerSelectionAction;
               for(;this._serversList hasNext _loc17_;KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused,server.id,errorText,this.getSelectableServers()))
               {
                  server=nextValue(_loc17_,_loc18_);
                  if(server.id==ssaction.serverId)
                  {
                     if(server.status==ServerStatusEnum.ONLINE)
                     {
                        ssmsg=new ServerSelectionMessage();
                        ssmsg.initServerSelectionMessage(ssaction.serverId);
                        ConnectionsHandler.getConnection().send(ssmsg);
                     }
                     else
                     {
                        errorText="Status";
                        switch(server.status)
                        {
                           case ServerStatusEnum.OFFLINE:
                              errorText=errorText+"Offline";
                              continue;
                              break;
                           case ServerStatusEnum.STARTING:
                              errorText=errorText+"Starting";
                              continue;
                              break;
                           case ServerStatusEnum.NOJOIN:
                              errorText=errorText+"Nojoin";
                              continue;
                              break;
                           case ServerStatusEnum.SAVING:
                              errorText=errorText+"Saving";
                              continue;
                              break;
                           case ServerStatusEnum.STOPING:
                              errorText=errorText+"Stoping";
                              continue;
                              break;
                           case ServerStatusEnum.FULL:
                              errorText=errorText+"Full";
                              continue;
                              break;
                           case ServerStatusEnum.STATUS_UNKNOWN:
                        }
                        errorText=errorText+"Unknown";
                     }
                  }
               }
               return true;
            case msg is SelectedServerDataMessage:
               ssdmsg=msg as SelectedServerDataMessage;
               ConnectionsHandler.connectionGonnaBeClosed(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER);
               this._selectedServer=ssdmsg;
               AuthentificationManager.getInstance().gameServerTicket=ssdmsg.ticket;
               PlayerManager.getInstance().server=Server.getServerById(ssdmsg.serverId);
               return true;
            case msg is ExpectedSocketClosureMessage:
               escmsg=msg as ExpectedSocketClosureMessage;
               if(escmsg.reason!=DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER)
               {
                  this._worker.process(new WrongSocketClosureReasonMessage(DisconnectionReasonEnum.SWITCHING_TO_GAME_SERVER,escmsg.reason));
                  return true;
               }
               this._worker.removeFrame(this);
               this._worker.addFrame(new GameServerApproachFrame());
               ConnectionsHandler.connectToGameServer(this._selectedServer.address,this._selectedServer.port);
               return true;
            case msg is AcquaintanceSearchAction:
               asaction=msg as AcquaintanceSearchAction;
               asmsg=new AcquaintanceSearchMessage();
               asmsg.initAcquaintanceSearchMessage(asaction.friendName);
               ConnectionsHandler.getConnection().send(asmsg);
               return true;
            case msg is AcquaintanceSearchErrorMessage:
               asemsg=msg as AcquaintanceSearchErrorMessage;
               switch(asemsg.reason)
               {
                  case 1:
                     reasonSearchError="unavailable";
                     break;
                  case 2:
                     reasonSearchError="no_result";
                     break;
                  case 3:
                     reasonSearchError="flood";
                     break;
                  case 0:
               }
               reasonSearchError="unknown";
               KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceSearchError,reasonSearchError);
               return true;
            case msg is AcquaintanceServerListMessage:
               aslmsg=msg as AcquaintanceServerListMessage;
               KernelEventsManager.getInstance().processCallback(HookList.AcquaintanceServerList,aslmsg.servers);
               return true;
            case msg is SelectedServerRefusedMessage:
               ssrmsg=msg as SelectedServerRefusedMessage;
               this._serversList.forEach(this.getUpdateServerStatusFunction(ssrmsg.serverId,ssrmsg.serverStatus));
               this.broadcastServersListUpdate();
               switch(ssrmsg.error)
               {
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_DUE_TO_STATUS:
                     error="Status";
                     switch(ssrmsg.serverStatus)
                     {
                        case ServerStatusEnum.OFFLINE:
                           error=error+"Offline";
                           break;
                        case ServerStatusEnum.STARTING:
                           error=error+"Starting";
                           break;
                        case ServerStatusEnum.NOJOIN:
                           error=error+"Nojoin";
                           break;
                        case ServerStatusEnum.SAVING:
                           error=error+"Saving";
                           break;
                        case ServerStatusEnum.STOPING:
                           error=error+"Stoping";
                           break;
                        case ServerStatusEnum.FULL:
                           error=error+"Full";
                           break;
                        case ServerStatusEnum.STATUS_UNKNOWN:
                     }
                     error=error+"Unknown";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_ACCOUNT_RESTRICTED:
                     error="AccountRestricted";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_COMMUNITY_RESTRICTED:
                     error="CommunityRestricted";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_LOCATION_RESTRICTED:
                     error="LocationRestricted";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_SUBSCRIBERS_ONLY:
                     error="SubscribersOnly";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_REGULAR_PLAYERS_ONLY:
                     error="RegularPlayersOnly";
                     break;
                  case ServerConnectionErrorEnum.SERVER_CONNECTION_ERROR_NO_REASON:
               }
               error="NoReason";
               KernelEventsManager.getInstance().processCallback(HookList.SelectedServerRefused,ssrmsg.serverId,error,this.getSelectableServers());
               return true;
            default:
               return false;
         }
      }

      public function pulled() : Boolean {
         return true;
      }

      private function getSelectableServers() : Array {
         var server:* = undefined;
         var selectableServers:Array = new Array();
         for each (server in this._serversList)
         {
            if((server.status==ServerStatusEnum.ONLINE)&&(server.isSelectable))
            {
               selectableServers.push(server.id);
            }
         }
         return selectableServers;
      }

      private function broadcastServersListUpdate() : void {
         var server:Object = null;
         this._serversUsedList=new Vector.<GameServerInformations>();
         for each (server in this._serversList)
         {
            _log.warn("serveur "+server.id);
            if(server.charactersCount>0)
            {
               _log.warn("   "+server.charactersCount+" perso");
               this._serversUsedList.push(server);
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.ServersList,this._serversList);
      }

      private function getUpdateServerFunction(serverToUpdate:GameServerInformations) : Function {
         return new function(element:*, index:int, arr:Vector.<GameServerInformations>):void
         {
            var gsi:* = element as GameServerInformations;
            if(serverToUpdate.id==gsi.id)
            {
                  gsi.charactersCount=serverToUpdate.charactersCount;
                  gsi.completion=serverToUpdate.completion;
                  gsi.isSelectable=serverToUpdate.isSelectable;
                  gsi.status=serverToUpdate.status;
            }
         };
      }

      private function getUpdateServerStatusFunction(serverId:uint, newStatus:uint) : Function {
         return new function(element:*, index:int, arr:Vector.<GameServerInformations>):void
         {
            var gsi:* = element as GameServerInformations;
            if(serverId==gsi.id)
            {
                  gsi.status=newStatus;
            }
         };
      }
   }

}