package d2data
{
   public class GuildFactSheetWrapper extends Object
   {
      
      public function GuildFactSheetWrapper() {
         super();
      }
      
      public function get guildId() : uint {
         return new uint();
      }
      
      public function get upEmblem() : EmblemWrapper {
         return new EmblemWrapper();
      }
      
      public function get backEmblem() : EmblemWrapper {
         return new EmblemWrapper();
      }
      
      public function get leaderId() : uint {
         return new uint();
      }
      
      public function get guildLevel() : uint {
         return new uint();
      }
      
      public function get nbMembers() : uint {
         return new uint();
      }
      
      public function get creationDate() : Number {
         return new Number();
      }
      
      public function get members() : Object {
         return new Object();
      }
      
      public function get allianceId() : uint {
         return new uint();
      }
      
      public function get allianceLeader() : Boolean {
         return new Boolean();
      }
      
      public function get nbConnectedMembers() : uint {
         return new uint();
      }
      
      public function get nbTaxCollectors() : uint {
         return new uint();
      }
      
      public function get lastActivity() : Number {
         return new Number();
      }
      
      public function get enabled() : Boolean {
         return new Boolean();
      }
      
      public function get hoursSinceLastConnection() : Number {
         return new Number();
      }
      
      public function get guildName() : String {
         return null;
      }
      
      public function get realGuildName() : String {
         return null;
      }
      
      public function get allianceName() : String {
         return null;
      }
      
      public function get allianceTag() : String {
         return null;
      }
      
      public function get leaderName() : String {
         return null;
      }
   }
}
