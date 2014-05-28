package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.types.connection.GameServerInformations;
   import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.datacenter.servers.Server;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   
   public class ConnectionApi extends Object implements IApi
   {
      
      public function ConnectionApi() {
         super();
      }
      
      private function get serverSelectionFrame() : ServerSelectionFrame {
         return Kernel.getWorker().getFrame(ServerSelectionFrame) as ServerSelectionFrame;
      }
      
      public function getUsedServers() : Vector.<GameServerInformations> {
         return this.serverSelectionFrame.usedServers;
      }
      
      public function getServers() : Vector.<GameServerInformations> {
         return this.serverSelectionFrame.servers;
      }
      
      public function isCharacterWaitingForChange(id:int) : Boolean {
         var serverApproachFrame:GameServerApproachFrame = Kernel.getWorker().getFrame(GameServerApproachFrame) as GameServerApproachFrame;
         if(serverApproachFrame)
         {
            return serverApproachFrame.isCharacterWaitingForChange(id);
         }
         return false;
      }
      
      public function allowAutoConnectCharacter(allow:Boolean) : void {
         PlayerManager.getInstance().allowAutoConnectCharacter = allow;
         PlayerManager.getInstance().autoConnectOfASpecificCharacterId = -1;
      }
      
      public function getAutochosenServer() : GameServerInformations {
         var commuServeur:GameServerInformations = null;
         var currServer:Object = null;
         var internationalServer:GameServerInformations = null;
         var currServerI:Object = null;
         var firstPop:* = 0;
         var server:GameServerInformations = null;
         var data:Object = null;
         var availableServers:Array = new Array();
         var serversList:Array = new Array();
         var playerCommuId:int = PlayerManager.getInstance().communityId;
         for each(commuServeur in this.serverSelectionFrame.servers)
         {
            currServer = Server.getServerById(commuServeur.id);
            if(currServer)
            {
               if((currServer.communityId == playerCommuId) || ((playerCommuId == 1) || (playerCommuId == 2)) && ((currServer.communityId == 1) || (currServer.communityId == 2)))
               {
                  serversList.push(commuServeur);
               }
            }
         }
         if(serversList.length == 0)
         {
            for each(internationalServer in this.serverSelectionFrame.servers)
            {
               currServerI = Server.getServerById(internationalServer.id);
               if((currServerI) && (currServerI.communityId == 2))
               {
                  serversList.push(internationalServer);
               }
            }
         }
         serversList.sortOn("completion",Array.NUMERIC);
         if(serversList.length > 0)
         {
            firstPop = -1;
            for each(server in serversList)
            {
               data = Server.getServerById(server.id);
               if((server.status == 3) && (firstPop == -1))
               {
                  firstPop = server.completion;
               }
               if((!(firstPop == -1)) && (data.population.id == firstPop) && (server.status == 3))
               {
                  if((!(BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE)) || (data.name.indexOf("Test") == -1))
                  {
                     availableServers.push(server);
                  }
               }
            }
            if(availableServers.length > 0)
            {
               return availableServers[Math.floor(Math.random() * availableServers.length)];
            }
         }
         return null;
      }
   }
}
