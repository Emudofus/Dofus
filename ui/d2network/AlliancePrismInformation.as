package d2network
{
   public class AlliancePrismInformation extends PrismInformation
   {
      
      public function AlliancePrismInformation() {
         super();
      }
      
      public function get alliance() : AllianceInformations {
         return new AllianceInformations();
      }
   }
}
