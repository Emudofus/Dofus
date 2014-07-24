package d2api
{
   import d2data.FighterInformations;
   import d2data.EffectsWrapper;
   import d2data.Spell;
   import d2data.EffectsListWrapper;
   import d2network.CharacterCharacteristicsInformations;
   
   public class FightApi extends Object
   {
      
      public function FightApi() {
         super();
      }
      
      public function destroy() : void {
      }
      
      public function getFighterInformations(fighterId:int) : FighterInformations {
         return null;
      }
      
      public function getFighterName(fighterId:int) : String {
         return null;
      }
      
      public function getFighterLevel(fighterId:int) : uint {
         return 0;
      }
      
      public function getFighters() : Object {
         return null;
      }
      
      public function getMonsterId(id:int) : int {
         return 0;
      }
      
      public function getDeadFighters() : Object {
         return null;
      }
      
      public function getFightType() : uint {
         return 0;
      }
      
      public function getBuffList(targetId:int) : Object {
         return null;
      }
      
      public function getBuffById(buffId:uint, playerId:int) : Object {
         return null;
      }
      
      public function createEffectsWrapper(spell:Spell, effects:Object, name:String) : EffectsWrapper {
         return null;
      }
      
      public function getCastingSpellBuffEffects(targetId:int, castingSpellId:uint) : EffectsWrapper {
         return null;
      }
      
      public function getAllBuffEffects(targetId:int) : EffectsListWrapper {
         return null;
      }
      
      public function isCastingSpell() : Boolean {
         return false;
      }
      
      public function cancelSpell() : void {
      }
      
      public function getChallengeList() : Object {
         return null;
      }
      
      public function getCurrentPlayedFighterId() : int {
         return 0;
      }
      
      public function getCurrentPlayedCharacteristicsInformations() : CharacterCharacteristicsInformations {
         return null;
      }
      
      public function preFightIsActive() : Boolean {
         return false;
      }
      
      public function isWaitingBeforeFight() : Boolean {
         return false;
      }
      
      public function isFightLeader() : Boolean {
         return false;
      }
      
      public function isSpectator() : Boolean {
         return false;
      }
      
      public function isDematerializated() : Boolean {
         return false;
      }
      
      public function getTurnsCount() : int {
         return 0;
      }
      
      public function getFighterStatus(fighterId:uint) : int {
         return 0;
      }
      
      public function isMouseOverFighter(fighterId:int) : Boolean {
         return false;
      }
   }
}
