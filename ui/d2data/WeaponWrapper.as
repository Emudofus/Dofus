package d2data
{
   public class WeaponWrapper extends ItemWrapper
   {
      
      public function WeaponWrapper() {
         super();
      }
      
      public function get apCost() : int {
         return new int();
      }
      
      public function get minRange() : int {
         return new int();
      }
      
      public function get range() : int {
         return new int();
      }
      
      public function get maxCastPerTurn() : uint {
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
      
      public function get criticalHitProbability() : int {
         return new int();
      }
      
      public function get criticalHitBonus() : int {
         return new int();
      }
      
      public function get criticalFailureProbability() : int {
         return new int();
      }
   }
}
