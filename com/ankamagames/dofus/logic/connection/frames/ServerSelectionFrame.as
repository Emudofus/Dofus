package com.ankamagames.dofus.logic.connection.frames
{
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.dofus.network.messages.connection.ServersListMessage;
   import com.ankamagames.dofus.network.messages.connection.SelectedServerDataMessage;
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
   import com.ankamagames.jerakine.messages.*;
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
      
      protected static const _log:Logger;
      
      private static function serverDateSortFunction(a:GameServerInformations, b:GameServerInformations) : Number {
         if(a.date < b.date)
         {
            return 1;
         }
         if(a.date == b.date)
         {
            return 0;
         }
         return -1;
      }
      
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
         this._worker = Kernel.getWorker();
         return true;
      }
      
      public function process(msg:Message) : Boolean {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public function pulled() : Boolean {
         return true;
      }
      
      private function getSelectableServers() : Array {
         var server:* = undefined;
         var selectableServers:Array = new Array();
         for each(server in this._serversList)
         {
            if((server.status == ServerStatusEnum.ONLINE) && (server.isSelectable))
            {
               selectableServers.push(server.id);
            }
         }
         return selectableServers;
      }
      
      private function broadcastServersListUpdate() : void {
         var server:Object = null;
         this._serversUsedList = new Vector.<GameServerInformations>();
         PlayerManager.getInstance().serversList = new Vector.<int>();
         for each(server in this._serversList)
         {
            if(server.charactersCount > 0)
            {
               this._serversUsedList.push(server);
               PlayerManager.getInstance().serversList.push(server.id);
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.ServersList,this._serversList);
      }
      
      private function getUpdateServerFunction(serverToUpdate:GameServerInformations) : Function {
         return function(element:*, index:int, arr:Vector.<GameServerInformations>):void
         {
            var gsi:* = element as GameServerInformations;
            if(serverToUpdate.id == gsi.id)
            {
               gsi.charactersCount = serverToUpdate.charactersCount;
               gsi.completion = serverToUpdate.completion;
               gsi.isSelectable = serverToUpdate.isSelectable;
               gsi.status = serverToUpdate.status;
            }
         };
      }
      
      private function getUpdateServerStatusFunction(serverId:uint, newStatus:uint) : Function {
         return function(element:*, index:int, arr:Vector.<GameServerInformations>):void
         {
            var gsi:* = element as GameServerInformations;
            if(serverId == gsi.id)
            {
               gsi.status = newStatus;
            }
         };
      }
   }
}
