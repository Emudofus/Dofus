package d2network
{
   public class GameContextActorInformations extends Object
   {
      
      public function GameContextActorInformations() {
         super();
      }
      
      public function get contextualId() : int {
         return new int();
      }
      
      public function get look() : EntityLook {
         return new EntityLook();
      }
      
      public function get disposition() : EntityDispositionInformations {
         return new EntityDispositionInformations();
      }
   }
}
