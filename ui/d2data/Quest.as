package d2data
{
   public class Quest extends Object
   {
      
      public function Quest() {
         super();
      }
      
      public function get id() : uint {
         return new uint();
      }
      
      public function get nameId() : uint {
         return new uint();
      }
      
      public function get stepIds() : Object {
         return new Object();
      }
      
      public function get categoryId() : uint {
         return new uint();
      }
      
      public function get isRepeatable() : Boolean {
         return new Boolean();
      }
      
      public function get repeatType() : uint {
         return new uint();
      }
      
      public function get repeatLimit() : uint {
         return new uint();
      }
      
      public function get isDungeonQuest() : Boolean {
         return new Boolean();
      }
      
      public function get levelMin() : uint {
         return new uint();
      }
      
      public function get levelMax() : uint {
         return new uint();
      }
      
      public function get name() : String {
         return null;
      }
      
      public function get steps() : Object {
         return null;
      }
      
      public function get category() : QuestCategory {
         return null;
      }
   }
}
