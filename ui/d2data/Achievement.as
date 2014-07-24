package d2data
{
   public class Achievement extends Object
   {
      
      public function Achievement() {
         super();
      }
      
      public function get id() : uint {
         return new uint();
      }
      
      public function get nameId() : uint {
         return new uint();
      }
      
      public function get categoryId() : uint {
         return new uint();
      }
      
      public function get descriptionId() : uint {
         return new uint();
      }
      
      public function get iconId() : uint {
         return new uint();
      }
      
      public function get points() : uint {
         return new uint();
      }
      
      public function get level() : uint {
         return new uint();
      }
      
      public function get order() : uint {
         return new uint();
      }
      
      public function get kamasRatio() : Number {
         return new Number();
      }
      
      public function get experienceRatio() : Number {
         return new Number();
      }
      
      public function get kamasScaleWithPlayerLevel() : Boolean {
         return new Boolean();
      }
      
      public function get objectiveIds() : Object {
         return new Object();
      }
      
      public function get rewardIds() : Object {
         return new Object();
      }
      
      public function get name() : String {
         return null;
      }
      
      public function get description() : String {
         return null;
      }
      
      public function get category() : AchievementCategory {
         return null;
      }
   }
}
