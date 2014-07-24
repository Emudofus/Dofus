package d2data
{
   public class AllianceWrapper extends Object
   {
      
      public function AllianceWrapper() {
         super();
      }
      
      public function get allianceId() : uint {
         return new uint();
      }
      
      public function get upEmblem() : EmblemWrapper {
         return new EmblemWrapper();
      }
      
      public function get backEmblem() : EmblemWrapper {
         return new EmblemWrapper();
      }
      
      public function get enabled() : Boolean {
         return new Boolean();
      }
      
      public function get creationDate() : uint {
         return new uint();
      }
      
      public function get nbGuilds() : uint {
         return new uint();
      }
      
      public function get nbMembers() : uint {
         return new uint();
      }
      
      public function get nbSubareas() : uint {
         return new uint();
      }
      
      public function get leaderGuildId() : uint {
         return new uint();
      }
      
      public function get leaderCharacterId() : uint {
         return new uint();
      }
      
      public function get leaderCharacterName() : String {
         return new String();
      }
      
      public function get guilds() : Object {
         return new Object();
      }
      
      public function get prismIds() : Object {
         return new Object();
      }
      
      public function get allianceTag() : String {
         return null;
      }
      
      public function get realAllianceTag() : String {
         return null;
      }
      
      public function get allianceName() : String {
         return null;
      }
      
      public function get realAllianceName() : String {
         return null;
      }
      
      public function get memberRightsNumber() : uint {
         return 0;
      }
      
      public function get memberRights() : Object {
         return null;
      }
      
      public function get isBoss() : Boolean {
         return false;
      }
   }
}
