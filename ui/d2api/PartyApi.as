package d2api
{
    public class PartyApi 
    {


        [Trusted]
        public function destroy():void
        {
        }

        [Untrusted]
        public function getPartyMembers(typeId:int=0):Object
        {
            return (null);
        }

        [Untrusted]
        public function getPartyLeaderId(partyId:int):int
        {
            return (0);
        }

        [Untrusted]
        public function isInParty(pPlayerId:uint):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getPartyId():int
        {
            return (0);
        }

        [Untrusted]
        public function isArenaRegistered():Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getArenaCurrentStatus():int
        {
            return (0);
        }

        [Untrusted]
        public function getArenaPartyId():int
        {
            return (0);
        }

        [Untrusted]
        public function getArenaLeader():Object
        {
            return (null);
        }

        [Untrusted]
        public function getArenaReadyPartyMemberIds():Object
        {
            return (null);
        }

        [Untrusted]
        public function getArenaAlliesIds():Object
        {
            return (null);
        }

        [Untrusted]
        public function getArenaRanks():Object
        {
            return (null);
        }

        [Untrusted]
        public function getTodaysArenaFights():int
        {
            return (0);
        }

        [Untrusted]
        public function getTodaysWonArenaFights():int
        {
            return (0);
        }

        [Untrusted]
        public function getAllMemberFollowPlayerId(partyId:int):uint
        {
            return (0);
        }

        [Untrusted]
        public function getPartyLoyalty(partyId:int):Boolean
        {
            return (false);
        }

        [Untrusted]
        public function getAllSubscribedDungeons():Object
        {
            return (null);
        }


    }
}//package d2api

