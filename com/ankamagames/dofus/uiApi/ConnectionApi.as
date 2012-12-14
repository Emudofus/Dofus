package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.dofus.*;
    import com.ankamagames.dofus.datacenter.servers.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.common.managers.*;
    import com.ankamagames.dofus.logic.connection.frames.*;
    import com.ankamagames.dofus.logic.game.approach.frames.*;
    import com.ankamagames.dofus.network.enums.*;
    import com.ankamagames.dofus.network.types.connection.*;

    public class ConnectionApi extends Object implements IApi
    {

        public function ConnectionApi()
        {
            return;
        }// end function

        private function get serverSelectionFrame() : ServerSelectionFrame
        {
            return Kernel.getWorker().getFrame(ServerSelectionFrame) as ServerSelectionFrame;
        }// end function

        public function getUsedServers() : Vector.<GameServerInformations>
        {
            return this.serverSelectionFrame.usedServers;
        }// end function

        public function getServers() : Vector.<GameServerInformations>
        {
            return this.serverSelectionFrame.servers;
        }// end function

        public function isCharacterWaitingForChange(param1:int) : Boolean
        {
            var _loc_2:* = Kernel.getWorker().getFrame(GameServerApproachFrame) as GameServerApproachFrame;
            if (_loc_2)
            {
                return _loc_2.isCharacterWaitingForChange(param1);
            }
            return false;
        }// end function

        public function getAutochosenServer() : GameServerInformations
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_1:* = new Array();
            var _loc_2:* = new Array();
            var _loc_3:* = PlayerManager.getInstance().communityId;
            for each (_loc_4 in this.serverSelectionFrame.servers)
            {
                
                _loc_5 = Server.getServerById(_loc_4.id);
                if (_loc_5)
                {
                    if (_loc_5.communityId == _loc_3 || (_loc_3 == 1 || _loc_3 == 2) && (_loc_5.communityId == 1 || _loc_5.communityId == 2))
                    {
                        _loc_2.push(_loc_4);
                    }
                }
            }
            if (_loc_2.length == 0)
            {
                for each (_loc_6 in this.serverSelectionFrame.servers)
                {
                    
                    _loc_7 = Server.getServerById(_loc_6.id);
                    if (_loc_7 && _loc_7.communityId == 2)
                    {
                        _loc_2.push(_loc_6);
                    }
                }
            }
            _loc_2.sortOn("completion", Array.NUMERIC);
            if (_loc_2.length > 0)
            {
                _loc_8 = -1;
                for each (_loc_9 in _loc_2)
                {
                    
                    _loc_10 = Server.getServerById(_loc_9.id);
                    if (_loc_9.status == 3 && _loc_8 == -1)
                    {
                        _loc_8 = _loc_9.completion;
                    }
                    if (_loc_8 != -1 && _loc_10.population.id == _loc_8 && _loc_9.status == 3)
                    {
                        if (BuildInfos.BUILD_TYPE != BuildTypeEnum.RELEASE || _loc_10.name.indexOf("Test") == -1)
                        {
                            _loc_1.push(_loc_9);
                        }
                    }
                }
                if (_loc_1.length > 0)
                {
                    return _loc_1[Math.floor(Math.random() * _loc_1.length)];
                }
            }
            return null;
        }// end function

    }
}
