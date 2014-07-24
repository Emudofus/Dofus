package d2data
{
   public class Area extends Object
   {
      
      public function Area() {
         super();
      }
      
      public function get id() : int {
         return new int();
      }
      
      public function get nameId() : uint {
         return new uint();
      }
      
      public function get superAreaId() : int {
         return new int();
      }
      
      public function get containHouses() : Boolean {
         return new Boolean();
      }
      
      public function get containPaddocks() : Boolean {
         return new Boolean();
      }
      
      public function get bounds() : Object {
         return new Object();
      }
      
      public function get name() : String {
         return null;
      }
      
      public function get superArea() : SuperArea {
         return null;
      }
      
      public function get hasVisibleSubAreas() : Boolean {
         return false;
      }
   }
}
