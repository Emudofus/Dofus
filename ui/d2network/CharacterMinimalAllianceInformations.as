package d2network
{
   public class CharacterMinimalAllianceInformations extends CharacterMinimalGuildInformations
   {
      
      public function CharacterMinimalAllianceInformations() {
         super();
      }
      
      public function get alliance() : BasicAllianceInformations {
         return new BasicAllianceInformations();
      }
   }
}
