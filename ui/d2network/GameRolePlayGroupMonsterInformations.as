package d2network
{
   public class GameRolePlayGroupMonsterInformations extends GameRolePlayActorInformations
   {
      
      public function GameRolePlayGroupMonsterInformations() {
         super();
      }
      
      public function get staticInfos() : GroupMonsterStaticInformations {
         return new GroupMonsterStaticInformations();
      }
      
      public function get ageBonus() : int {
         return new int();
      }
      
      public function get lootShare() : int {
         return new int();
      }
      
      public function get alignmentSide() : int {
         return new int();
      }
      
      public function get keyRingBonus() : Boolean {
         return new Boolean();
      }
      
      public function get hasHardcoreDrop() : Boolean {
         return new Boolean();
      }
      
      public function get hasAVARewardToken() : Boolean {
         return new Boolean();
      }
   }
}
