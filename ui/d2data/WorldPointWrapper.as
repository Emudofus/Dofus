package d2data
{
   public class WorldPointWrapper extends WorldPoint
   {
      
      public function WorldPointWrapper() {
         super();
      }
      
      public function get outdoorMapId() : uint {
         return new uint();
      }
      
      public function get outdoorX() : int {
         return 0;
      }
      
      public function get outdoorY() : int {
         return 0;
      }
      
      public function get topNeighbourId() : int {
         return 0;
      }
      
      public function get bottomNeighbourId() : int {
         return 0;
      }
      
      public function get leftNeighbourId() : int {
         return 0;
      }
      
      public function get rightNeighbourId() : int {
         return 0;
      }
   }
}
