package d2data
{
   public class GuildWrapper extends Object
   {
      
      public function GuildWrapper() {
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
      
      public function get level() : uint {
         return new uint();
      }
      
      public function get enabled() : Boolean {
         return new Boolean();
      }
      
      public function get creationDate() : uint {
         return new uint();
      }
      
      public function get leaderId() : uint {
         return new uint();
      }
      
      public function get nbMembers() : uint {
         return new uint();
      }
      
      public function get nbConnectedMembers() : uint {
         return new uint();
      }
      
      public function get experience() : Number {
         return new Number();
      }
      
      public function get expLevelFloor() : Number {
         return new Number();
      }
      
      public function get expNextLevelFloor() : Number {
         return new Number();
      }
      
      public function get alliance() : AllianceWrapper {
         return new AllianceWrapper();
      }
      
      public function get allianceTag() : String {
         return new String();
      }
      
      public function get guildName() : String {
         return null;
      }
      
      public function get realGuildName() : String {
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
      
      public function get manageGuildBoosts() : Boolean {
         return false;
      }
      
      public function get manageRights() : Boolean {
         return false;
      }
      
      public function get inviteNewMembers() : Boolean {
         return false;
      }
      
      public function get banMembers() : Boolean {
         return false;
      }
      
      public function get manageXPContribution() : Boolean {
         return false;
      }
      
      public function get manageRanks() : Boolean {
         return false;
      }
      
      public function get hireTaxCollector() : Boolean {
         return false;
      }
      
      public function get manageMyXpContribution() : Boolean {
         return false;
      }
      
      public function get collect() : Boolean {
         return false;
      }
      
      public function get manageLightRights() : Boolean {
         return false;
      }
      
      public function get useFarms() : Boolean {
         return false;
      }
      
      public function get organizeFarms() : Boolean {
         return false;
      }
      
      public function get takeOthersRidesInFarm() : Boolean {
         return false;
      }
      
      public function get prioritizeMeInDefense() : Boolean {
         return false;
      }
      
      public function get collectMyTaxCollectors() : Boolean {
         return false;
      }
      
      public function get setAlliancePrism() : Boolean {
         return false;
      }
      
      public function get talkInAllianceChannel() : Boolean {
         return false;
      }
   }
}
