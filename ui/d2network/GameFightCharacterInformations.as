package d2network
{
   public class GameFightCharacterInformations extends GameFightFighterNamedInformations
   {
      
      public function GameFightCharacterInformations() {
         super();
      }
      
      public function get level() : uint {
         return new uint();
      }
      
      public function get alignmentInfos() : ActorAlignmentInformations {
         return new ActorAlignmentInformations();
      }
      
      public function get breed() : int {
         return new int();
      }
   }
}
