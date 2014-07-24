package d2network
{
   public class MonsterInGroupInformations extends MonsterInGroupLightInformations
   {
      
      public function MonsterInGroupInformations() {
         super();
      }
      
      public function get look() : EntityLook {
         return new EntityLook();
      }
   }
}
