package d2network
{
   public class CharacterMinimalGuildInformations extends CharacterMinimalPlusLookInformations
   {
      
      public function CharacterMinimalGuildInformations() {
         super();
      }
      
      public function get guild() : BasicGuildInformations {
         return new BasicGuildInformations();
      }
   }
}
