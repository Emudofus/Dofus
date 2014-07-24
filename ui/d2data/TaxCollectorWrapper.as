package d2data
{
   import d2network.BasicGuildInformations;
   import d2network.EntityLook;
   import d2network.AdditionalTaxCollectorInformations;
   
   public class TaxCollectorWrapper extends Object
   {
      
      public function TaxCollectorWrapper() {
         super();
      }
      
      public function get uniqueId() : int {
         return new int();
      }
      
      public function get guild() : BasicGuildInformations {
         return new BasicGuildInformations();
      }
      
      public function get firstName() : String {
         return new String();
      }
      
      public function get lastName() : String {
         return new String();
      }
      
      public function get entityLook() : EntityLook {
         return new EntityLook();
      }
      
      public function get additionalInformation() : AdditionalTaxCollectorInformations {
         return new AdditionalTaxCollectorInformations();
      }
      
      public function get mapWorldX() : int {
         return new int();
      }
      
      public function get mapWorldY() : int {
         return new int();
      }
      
      public function get subareaId() : int {
         return new int();
      }
      
      public function get state() : int {
         return new int();
      }
      
      public function get fightTime() : Number {
         return new Number();
      }
      
      public function get waitTimeForPlacement() : Number {
         return new Number();
      }
      
      public function get nbPositionPerTeam() : uint {
         return new uint();
      }
      
      public function get kamas() : int {
         return new int();
      }
      
      public function get experience() : int {
         return new int();
      }
      
      public function get pods() : int {
         return new int();
      }
      
      public function get itemsValue() : int {
         return new int();
      }
   }
}
