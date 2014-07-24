package d2network
{
   public class GameRolePlayCharacterInformations extends GameRolePlayHumanoidInformations
   {
      
      public function GameRolePlayCharacterInformations() {
         super();
      }
      
      public function get alignmentInfos() : ActorAlignmentInformations {
         return new ActorAlignmentInformations();
      }
   }
}
