package d2data
{
   public class SpellWrapper extends Object
   {
      
      public function SpellWrapper() {
         super();
      }
      
      public function get position() : uint {
         return new uint();
      }
      
      public function get id() : uint {
         return new uint();
      }
      
      public function get spellLevel() : int {
         return new int();
      }
      
      public function get effects() : Object {
         return new Object();
      }
      
      public function get criticalEffect() : Object {
         return new Object();
      }
      
      public function get gfxId() : int {
         return new int();
      }
      
      public function get playerId() : int {
         return new int();
      }
      
      public function get versionNum() : int {
         return new int();
      }
      
      public function get actualCooldown() : uint {
         return 0;
      }
      
      public function get spellLevelInfos() : SpellLevel {
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
      
      public function get hideEffects() : Boolean {
         return false;
      }
      
      public function get backGroundIconUri() : Object {
         return null;
      }
      
      public function get iconUri() : Object {
         return null;
      }
      
      public function get fullSizeIconUri() : Object {
         return null;
      }
      
      public function get errorIconUri() : Object {
         return null;
      }
      
      public function get info1() : String {
         return null;
      }
      
      public function get startTime() : int {
         return 0;
      }
      
      public function get endTime() : int {
         return 0;
      }
      
      public function get timer() : int {
         return 0;
      }
      
      public function get active() : Boolean {
         return false;
      }
      
      public function get spell() : Spell {
         return null;
      }
      
      public function get spellId() : uint {
         return 0;
      }
      
      public function get playerCriticalRate() : int {
         return 0;
      }
      
      public function get playerCriticalFailureRate() : int {
         return 0;
      }
      
      public function get maximalRangeWithBoosts() : int {
         return 0;
      }
   }
}
