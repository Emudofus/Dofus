package d2network
{
   public class HumanOptionAlliance extends HumanOption
   {
      
      public function HumanOptionAlliance() {
         super();
      }
      
      public function get allianceInformations() : AllianceInformations {
         return new AllianceInformations();
      }
      
      public function get aggressable() : uint {
         return new uint();
      }
   }
}
