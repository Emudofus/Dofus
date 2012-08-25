package com.ankamagames.dofus.uiApi
{
    import __AS3__.vec.*;
    import com.ankamagames.berilia.interfaces.*;
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.dofus.kernel.*;
    import com.ankamagames.dofus.logic.game.common.frames.*;
    import com.ankamagames.jerakine.logger.*;
    import flash.utils.*;

    public class PartyApi extends Object implements IApi
    {
        private var _module:UiModule;
        protected var _log:Logger;

        public function PartyApi()
        {
            this._log = Log.getLogger(getQualifiedClassName(PartyApi));
            return;
        }// end function

        private function get partyManagementFrame() : PartyManagementFrame
        {
            return Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
        }// end function

        public function set module(param1:UiModule) : void
        {
            this._module = param1;
            return;
        }// end function

        public function destroy() : void
        {
            this._module = null;
            return;
        }// end function

        public function getPartyMembers(param1:int = 0) : Object
        {
            if (param1 == 1)
            {
                return this.partyManagementFrame.arenaPartyMembers;
            }
            return this.partyManagementFrame.partyMembers;
        }// end function

        public function getPartyLeaderId(param1:int) : int
        {
            var _loc_2:Object = null;
            if (param1 == this.partyManagementFrame.arenaPartyId)
            {
                for each (_loc_2 in this.partyManagementFrame.arenaPartyMembers)
                {
                    
                    if (_loc_2.isLeader)
                    {
                        return _loc_2.id;
                    }
                }
            }
            else if (param1 == this.partyManagementFrame.partyId)
            {
                for each (_loc_2 in this.partyManagementFrame.partyMembers)
                {
                    
                    if (_loc_2.isLeader)
                    {
                        return _loc_2.id;
                    }
                }
            }
            return -1;
        }// end function

        public function isInParty(param1:uint) : Boolean
        {
            var _loc_2:Object = null;
            for each (_loc_2 in this.partyManagementFrame.partyMembers)
            {
                
                if (param1 == _loc_2.id)
                {
                    return true;
                }
            }
            for each (_loc_2 in this.partyManagementFrame.arenaPartyMembers)
            {
                
                if (param1 == _loc_2.id)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public function getPartyId() : int
        {
            return this.partyManagementFrame.partyId;
        }// end function

        public function isArenaRegistered() : Boolean
        {
            return this.partyManagementFrame.isArenaRegistered;
        }// end function

        public function getArenaCurrentStatus() : int
        {
            return this.partyManagementFrame.arenaCurrentStatus;
        }// end function

        public function getArenaPartyId() : int
        {
            return this.partyManagementFrame.arenaPartyId;
        }// end function

        public function getArenaLeader() : Object
        {
            return this.partyManagementFrame.arenaLeader;
        }// end function

        public function getArenaReadyPartyMemberIds() : Object
        {
            return this.partyManagementFrame.arenaReadyPartyMemberIds;
        }// end function

        public function getArenaAlliesIds() : Object
        {
            return this.partyManagementFrame.arenaAlliesIds;
        }// end function

        public function getArenaRanks() : Object
        {
            return this.partyManagementFrame.arenaRanks;
        }// end function

        public function getTodaysArenaFights() : int
        {
            return this.partyManagementFrame.todaysArenaFights;
        }// end function

        public function getTodaysWonArenaFights() : int
        {
            return this.partyManagementFrame.todaysWonArenaFights;
        }// end function

        public function getAllMemberFollowPlayerId(param1:int) : uint
        {
            return this.partyManagementFrame.allMemberFollowPlayerId;
        }// end function

        public function getPartyLoyalty(param1:int) : Boolean
        {
            return this.partyManagementFrame.partyLoyalty;
        }// end function

        public function getAllSubscribedDungeons() : Vector.<uint>
        {
            return this.partyManagementFrame.subscribedDungeons;
        }// end function

    }
}
