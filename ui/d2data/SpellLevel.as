package d2data
{
   public class SpellLevel extends Object
   {
      
      public function SpellLevel() {
         super();
      }
      
      public function get id() : uint {
         return new uint();
      }
      
      public function get spellId() : uint {
         return new uint();
      }
      
      public function get grade() : uint {
         return new uint();
      }
      
      public function get spellBreed() : uint {
         return new uint();
      }
      
      public function get apCost() : uint {
         return new uint();
      }
      
      public function get minRange() : uint {
         return new uint();
      }
      
      public function get range() : uint {
         return new uint();
      }
      
      public function get castInLine() : Boolean {
         return new Boolean();
      }
      
      public function get castInDiagonal() : Boolean {
         return new Boolean();
      }
      
      public function get castTestLos() : Boolean {
         return new Boolean();
      }
      
      public function get criticalHitProbability() : uint {
         return new uint();
      }
      
      public function get criticalFailureProbability() : uint {
         return new uint();
      }
      
      public function get needFreeCell() : Boolean {
         return new Boolean();
      }
      
      public function get needTakenCell() : Boolean {
         return new Boolean();
      }
      
      public function get needFreeTrapCell() : Boolean {
         return new Boolean();
      }
      
      public function get rangeCanBeBoosted() : Boolean {
         return new Boolean();
      }
      
      public function get maxStack() : int {
         return new int();
      }
      
      public function get maxCastPerTurn() : uint {
         return new uint();
      }
      
      public function get maxCastPerTarget() : uint {
         return new uint();
      }
      
      public function get minCastInterval() : uint {
         return new uint();
      }
      
      public function get initialCooldown() : uint {
         return new uint();
      }
      
      public function get globalCooldown() : int {
         return new int();
      }
      
      public function get minPlayerLevel() : uint {
         return new uint();
      }
      
      public function get criticalFailureEndsTurn() : Boolean {
         return new Boolean();
      }
      
      public function get hideEffects() : Boolean {
         return new Boolean();
      }
      
      public function get hidden() : Boolean {
         return new Boolean();
      }
      
      public function get statesRequired() : Object {
         return new Object();
      }
      
      public function get statesForbidden() : Object {
         return new Object();
      }
      
      public function get effects() : Object {
         return new Object();
      }
      
      public function get criticalEffect() : Object {
         return new Object();
      }
      
      public function get spell() : Spell {
         return null;
      }
      
      public function get minimalRange() : uint {
         return 0;
      }
      
      public function get maximalRange() : uint {
         return 0;
      }
      
      public function get castZoneInLine() : Boolean {
         return false;
      }
      
      public function get castZoneInDiagonal() : Boolean {
         return false;
      }
      
      public function get spellZoneEffects() : Object {
         return null;
      }
      
      public function get canSummon() : Boolean {
         return false;
      }
      
      public function get canBomb() : Boolean {
         return false;
      }
   }
}
