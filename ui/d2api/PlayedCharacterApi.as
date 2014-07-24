package d2api
{
   import d2network.CharacterCharacteristicsInformations;
   import d2data.Title;
   import d2data.Ornament;
   import d2network.GameRolePlayCharacterInformations;
   import d2network.ActorRestrictionsInformations;
   import d2data.SpellWrapper;
   import d2data.WorldPointWrapper;
   import d2data.SubArea;
   import d2data.WeaponWrapper;
   
   public class PlayedCharacterApi extends Object
   {
      
      public function PlayedCharacterApi() {
         super();
      }
      
      public function characteristics() : CharacterCharacteristicsInformations {
         return null;
      }
      
      public function getPlayedCharacterInfo() : Object {
         return null;
      }
      
      public function getCurrentEntityLook() : Object {
         return null;
      }
      
      public function getInventory() : Object {
         return null;
      }
      
      public function getEquipment() : Object {
         return null;
      }
      
      public function getSpellInventory() : Object {
         return null;
      }
      
      public function getJobs() : Object {
         return null;
      }
      
      public function getMount() : Object {
         return null;
      }
      
      public function getTitle() : Title {
         return null;
      }
      
      public function getOrnament() : Ornament {
         return null;
      }
      
      public function getKnownTitles() : Object {
         return null;
      }
      
      public function getKnownOrnaments() : Object {
         return null;
      }
      
      public function titlesOrnamentsAskedBefore() : Boolean {
         return false;
      }
      
      public function getEntityInfos() : GameRolePlayCharacterInformations {
         return null;
      }
      
      public function getEntityTooltipInfos() : Object {
         return null;
      }
      
      public function inventoryWeight() : uint {
         return 0;
      }
      
      public function inventoryWeightMax() : uint {
         return 0;
      }
      
      public function isIncarnation() : Boolean {
         return false;
      }
      
      public function isMutated() : Boolean {
         return false;
      }
      
      public function isInHouse() : Boolean {
         return false;
      }
      
      public function isInExchange() : Boolean {
         return false;
      }
      
      public function isInFight() : Boolean {
         return false;
      }
      
      public function isInPreFight() : Boolean {
         return false;
      }
      
      public function isInParty() : Boolean {
         return false;
      }
      
      public function isPartyLeader() : Boolean {
         return false;
      }
      
      public function isRidding() : Boolean {
         return false;
      }
      
      public function isPetsMounting() : Boolean {
         return false;
      }
      
      public function hasCompanion() : Boolean {
         return false;
      }
      
      public function id() : uint {
         return 0;
      }
      
      public function restrictions() : ActorRestrictionsInformations {
         return null;
      }
      
      public function isMutant() : Boolean {
         return false;
      }
      
      public function publicMode() : Boolean {
         return false;
      }
      
      public function artworkId() : int {
         return 0;
      }
      
      public function isCreature() : Boolean {
         return false;
      }
      
      public function getBone() : uint {
         return 0;
      }
      
      public function getSkin() : uint {
         return 0;
      }
      
      public function getColors() : Object {
         return null;
      }
      
      public function getSubentityColors() : Object {
         return null;
      }
      
      public function getAlignmentSide() : int {
         return 0;
      }
      
      public function getAlignmentValue() : uint {
         return 0;
      }
      
      public function getAlignmentAggressableStatus() : uint {
         return 0;
      }
      
      public function getAlignmentGrade() : uint {
         return 0;
      }
      
      public function getMaxSummonedCreature() : uint {
         return 0;
      }
      
      public function getCurrentSummonedCreature() : uint {
         return 0;
      }
      
      public function canSummon() : Boolean {
         return false;
      }
      
      public function getSpell(spellId:uint) : SpellWrapper {
         return null;
      }
      
      public function canCastThisSpell(spellId:uint, lvl:uint) : Boolean {
         return false;
      }
      
      public function canCastThisSpellOnTarget(spellId:uint, lvl:uint, pTargetId:int) : Boolean {
         return false;
      }
      
      public function getSpellModification(spellId:uint, carac:int) : int {
         return 0;
      }
      
      public function isInHisHouse() : Boolean {
         return false;
      }
      
      public function getPlayerHouses() : Object {
         return null;
      }
      
      public function currentMap() : WorldPointWrapper {
         return null;
      }
      
      public function currentSubArea() : SubArea {
         return null;
      }
      
      public function state() : uint {
         return 0;
      }
      
      public function isAlive() : Boolean {
         return false;
      }
      
      public function getFollowingPlayerId() : int {
         return 0;
      }
      
      public function getPlayerSet(objectGID:uint) : Object {
         return null;
      }
      
      public function getWeapon() : WeaponWrapper {
         return null;
      }
      
      public function getExperienceBonusPercent() : int {
         return 0;
      }
      
      public function knowSpell(pSpellId:uint) : int {
         return 0;
      }
   }
}
