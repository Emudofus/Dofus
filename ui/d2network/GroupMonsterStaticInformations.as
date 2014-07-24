package d2network
{
   public class GroupMonsterStaticInformations extends Object
   {
      
      public function GroupMonsterStaticInformations() {
         super();
      }
      
      public function get mainCreatureLightInfos() : MonsterInGroupLightInformations {
         return new MonsterInGroupLightInformations();
      }
      
      public function get underlings() : Object {
         return new Object();
      }
   }
}
