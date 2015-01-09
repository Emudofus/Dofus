package com.ankamagames.dofus.uiApi
{
    import com.ankamagames.berilia.interfaces.IApi;
    import com.ankamagames.dofus.kernel.Kernel;
    import com.ankamagames.dofus.logic.connection.frames.ServerSelectionFrame;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.connection.GameServerInformations;
    import com.ankamagames.dofus.logic.connection.managers.GuestModeManager;
    import com.ankamagames.dofus.logic.game.approach.frames.GameServerApproachFrame;
    import com.ankamagames.dofus.logic.common.managers.PlayerManager;
    import com.ankamagames.dofus.datacenter.servers.Server;
    import com.ankamagames.dofus.network.enums.ServerStatusEnum;
    import com.ankamagames.dofus.BuildInfos;
    import com.ankamagames.dofus.network.enums.BuildTypeEnum;

    [Trusted]
    [InstanciedApi]
    public class ConnectionApi implements IApi 
    {


        private function get serverSelectionFrame():ServerSelectionFrame
        {
            return ((Kernel.getWorker().getFrame(ServerSelectionFrame) as ServerSelectionFrame));
        }

        [Untrusted]
        public function getUsedServers():Vector.<GameServerInformations>
        {
            return (this.serverSelectionFrame.usedServers);
        }

        [Untrusted]
        public function getServers():Vector.<GameServerInformations>
        {
            return (this.serverSelectionFrame.servers);
        }

        [Untrusted]
        public function hasGuestAccount():Boolean
        {
            return (GuestModeManager.getInstance().hasGuestAccount());
        }

        [Untrusted]
        public function isCharacterWaitingForChange(id:int):Boolean
        {
            var serverApproachFrame:GameServerApproachFrame = (Kernel.getWorker().getFrame(GameServerApproachFrame) as GameServerApproachFrame);
            if (serverApproachFrame)
            {
                return (serverApproachFrame.isCharacterWaitingForChange(id));
            };
            return (false);
        }

        [Untrusted]
        public function allowAutoConnectCharacter(allow:Boolean):void
        {
            PlayerManager.getInstance().allowAutoConnectCharacter = allow;
            PlayerManager.getInstance().autoConnectOfASpecificCharacterId = -1;
        }

        [Untrusted]
        public function getAutochosenServer():GameServerInformations
        {
            var commuServeur:GameServerInformations;
            var currServer:Object;
            var internationalServer:GameServerInformations;
            var currServerI:Object;
            var firstPop:int;
            var server:GameServerInformations;
            var data:Object;
            var availableServers:Array = new Array();
            var serversList:Array = new Array();
            var playerCommuId:int = PlayerManager.getInstance().communityId;
            for each (commuServeur in this.serverSelectionFrame.servers)
            {
                currServer = Server.getServerById(commuServeur.id);
                if (currServer)
                {
                    if ((((currServer.communityId == playerCommuId)) || ((((((playerCommuId == 1)) || ((playerCommuId == 2)))) && ((((currServer.communityId == 1)) || ((currServer.communityId == 2))))))))
                    {
                        serversList.push(commuServeur);
                    };
                };
            };
            if (serversList.length == 0)
            {
                for each (internationalServer in this.serverSelectionFrame.servers)
                {
                    currServerI = Server.getServerById(internationalServer.id);
                    if (((currServerI) && ((currServerI.communityId == 2))))
                    {
                        serversList.push(internationalServer);
                    };
                };
            };
            serversList.sortOn("completion", Array.NUMERIC);
            if (serversList.length > 0)
            {
                firstPop = -1;
                for each (server in serversList)
                {
                    if ((((((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE)) && ((server.id == 36)))) && ((server.status == ServerStatusEnum.ONLINE))))
                    {
                        return (server);
                    };
                    data = Server.getServerById(server.id);
                    if ((((server.status == ServerStatusEnum.ONLINE)) && ((firstPop == -1))))
                    {
                        firstPop = server.completion;
                    };
                    if (((((!((firstPop == -1))) && ((data.population.id == firstPop)))) && ((server.status == ServerStatusEnum.ONLINE))))
                    {
                        if (((!((BuildInfos.BUILD_TYPE == BuildTypeEnum.RELEASE))) || ((data.name.indexOf("Test") == -1))))
                        {
                            availableServers.push(server);
                        };
                    };
                };
                if (availableServers.length > 0)
                {
                    return (availableServers[Math.floor((Math.random() * availableServers.length))]);
                };
            };
            return (null);
        }


    }
}//package com.ankamagames.dofus.uiApi

