package d2api
{
   public class PartyApi extends Object
   {
      
      public function PartyApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getPartyMembers(typeId:int = 0) : Object {
         return null;
      }
      
      public function getPartyLeaderId(partyId:int) : int {
         return 0;
      }
      
      public function isInParty(pPlayerId:uint) : Boolean {
         return false;
      }
      
      public function getPartyId() : int {
         return 0;
      }
      
      public function isArenaRegistered() : Boolean {
         return false;
      }
      
      public function getArenaCurrentStatus() : int {
         return 0;
      }
      
      public function getArenaPartyId() : int {
         return 0;
      }
      
      public function getArenaLeader() : Object {
         return null;
      }
      
      public function getArenaReadyPartyMemberIds() : Object {
         return null;
      }
      
      public function getArenaAlliesIds() : Object {
         return null;
      }
      
      public function getArenaRanks() : Object {
         return null;
      }
      
      public function getTodaysArenaFights() : int {
         return 0;
      }
      
      public function getTodaysWonArenaFights() : int {
         return 0;
      }
      
      public function getAllMemberFollowPlayerId(partyId:int) : uint {
         return 0;
      }
      
      public function getPartyLoyalty(partyId:int) : Boolean {
         return false;
      }
      
      public function getAllSubscribedDungeons() : Object {
         return null;
      }
   }
}
