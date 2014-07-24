package d2data
{
   public class Server extends Object
   {
      
      public function Server() {
         super();
      }
      
      public function get id() : int {
         return new int();
      }
      
      public function get nameId() : uint {
         return new uint();
      }
      
      public function get commentId() : uint {
         return new uint();
      }
      
      public function get openingDate() : Number {
         return new Number();
      }
      
      public function get language() : String {
         return new String();
      }
      
      public function get populationId() : int {
         return new int();
      }
      
      public function get gameTypeId() : uint {
         return new uint();
      }
      
      public function get communityId() : int {
         return new int();
      }
      
      public function get restrictedToLanguages() : Object {
         return new Object();
      }
      
      public function get name() : String {
         return null;
      }
      
      public function get comment() : String {
         return null;
      }
      
      public function get gameType() : ServerGameType {
         return null;
      }
      
      public function get community() : ServerCommunity {
         return null;
      }
      
      public function get population() : ServerPopulation {
         return null;
      }
   }
}
