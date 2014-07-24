package d2network
{
   public class CharacterMinimalPlusLookInformations extends CharacterMinimalInformations
   {
      
      public function CharacterMinimalPlusLookInformations() {
         super();
      }
      
      public function get entityLook() : EntityLook {
         return new EntityLook();
      }
   }
}
