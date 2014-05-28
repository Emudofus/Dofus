package d2network
{
   public class IgnoredOnlineInformations extends IgnoredInformations
   {
      
      public function IgnoredOnlineInformations() {
         super();
      }
      
      public function get playerId() : uint {
         return new uint();
      }
      
      public function get playerName() : String {
         return new String();
      }
      
      public function get breed() : int {
         return new int();
      }
      
      public function get sex() : Boolean {
         return new Boolean();
      }
   }
}
