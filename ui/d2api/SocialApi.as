package d2api
{
   import d2data.SpouseWrapper;
   import d2data.GuildWrapper;
   import d2data.GuildFactSheetWrapper;
   import d2data.TaxCollectorWrapper;
   import d2data.SocialEntityInFightWrapper;
   import d2data.AllianceWrapper;
   import d2data.PrismSubAreaWrapper;
   import d2data.BasicChatSentence;
   
   public class SocialApi extends Object
   {
      
      public function SocialApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getFriendsList() : Object {
         return null;
      }
      
      public function isFriend(playerName:String) : Boolean {
         return false;
      }
      
      public function getEnemiesList() : Object {
         return null;
      }
      
      public function isEnemy(playerName:String) : Boolean {
         return false;
      }
      
      public function getIgnoredList() : Object {
         return null;
      }
      
      public function isIgnored(name:String, accountId:int = 0) : Boolean {
         return false;
      }
      
      public function getAccountName(name:String) : String {
         return null;
      }
      
      public function getWarnOnFriendConnec() : Boolean {
         return false;
      }
      
      public function getWarnOnMemberConnec() : Boolean {
         return false;
      }
      
      public function getWarnWhenFriendOrGuildMemberLvlUp() : Boolean {
         return false;
      }
      
      public function getWarnWhenFriendOrGuildMemberAchieve() : Boolean {
         return false;
      }
      
      public function getSpouse() : SpouseWrapper {
         return null;
      }
      
      public function hasSpouse() : Boolean {
         return false;
      }
      
      public function getAllowedGuildEmblemSymbolCategories() : int {
         return 0;
      }
      
      public function hasGuild() : Boolean {
         return false;
      }
      
      public function getGuild() : GuildWrapper {
         return null;
      }
      
      public function getGuildMembers() : Object {
         return null;
      }
      
      public function getGuildRights() : Object {
         return null;
      }
      
      public function getGuildByid(id:int) : GuildFactSheetWrapper {
         return null;
      }
      
      public function hasGuildRight(pPlayerId:uint, pRightId:String) : Boolean {
         return false;
      }
      
      public function getGuildHouses() : Object {
         return null;
      }
      
      public function guildHousesUpdateNeeded() : Boolean {
         return false;
      }
      
      public function getGuildPaddocks() : Object {
         return null;
      }
      
      public function getMaxGuildPaddocks() : int {
         return 0;
      }
      
      public function isGuildNameInvalid() : Boolean {
         return false;
      }
      
      public function getMaxCollectorCount() : uint {
         return 0;
      }
      
      public function getTaxCollectors() : Object {
         return null;
      }
      
      public function getTaxCollector(id:int) : TaxCollectorWrapper {
         return null;
      }
      
      public function getGuildFightingTaxCollectors() : Object {
         return null;
      }
      
      public function getGuildFightingTaxCollector(pFightId:uint) : SocialEntityInFightWrapper {
         return null;
      }
      
      public function getAllFightingTaxCollectors() : Object {
         return null;
      }
      
      public function getAllFightingTaxCollector(pFightId:uint) : SocialEntityInFightWrapper {
         return null;
      }
      
      public function isPlayerDefender(pType:int, pPlayerId:uint, pSocialFightId:int) : Boolean {
         return false;
      }
      
      public function hasAlliance() : Boolean {
         return false;
      }
      
      public function getAlliance() : AllianceWrapper {
         return null;
      }
      
      public function getAllianceById(id:int) : AllianceWrapper {
         return null;
      }
      
      public function getAllianceGuilds() : Object {
         return null;
      }
      
      public function isAllianceNameInvalid() : Boolean {
         return false;
      }
      
      public function isAllianceTagInvalid() : Boolean {
         return false;
      }
      
      public function getPrismSubAreaById(id:int) : PrismSubAreaWrapper {
         return null;
      }
      
      public function getFightingPrisms() : Object {
         return null;
      }
      
      public function getFightingPrism(pFightId:uint) : SocialEntityInFightWrapper {
         return null;
      }
      
      public function isPlayerPrismDefender(pPlayerId:uint, pSubAreaId:int) : Boolean {
         return false;
      }
      
      public function getChatSentence(timestamp:Number, fingerprint:String) : BasicChatSentence {
         return null;
      }
   }
}
