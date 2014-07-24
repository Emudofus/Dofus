package d2network
{
   public class HumanInformations extends Object
   {
      
      public function HumanInformations() {
         super();
      }
      
      public function get restrictions() : ActorRestrictionsInformations {
         return new ActorRestrictionsInformations();
      }
      
      public function get sex() : Boolean {
         return new Boolean();
      }
      
      public function get options() : Object {
         return new Object();
      }
   }
}
