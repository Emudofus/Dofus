package d2data
{
   public class QuestStep extends Object
   {
      
      public function QuestStep() {
         super();
      }
      
      public function get id() : uint {
         return new uint();
      }
      
      public function get questId() : uint {
         return new uint();
      }
      
      public function get nameId() : uint {
         return new uint();
      }
      
      public function get descriptionId() : uint {
         return new uint();
      }
      
      public function get dialogId() : int {
         return new int();
      }
      
      public function get optimalLevel() : uint {
         return new uint();
      }
      
      public function get duration() : Number {
         return new Number();
      }
      
      public function get kamasScaleWithPlayerLevel() : Boolean {
         return new Boolean();
      }
      
      public function get kamasRatio() : Number {
         return new Number();
      }
      
      public function get xpRatio() : Number {
         return new Number();
      }
      
      public function get experienceReward() : uint {
         return 0;
      }
      
      public function get kamasReward() : uint {
         return 0;
      }
      
      public function get itemsReward() : Object {
         return null;
      }
      
      public function get emotesReward() : Object {
         return null;
      }
      
      public function get jobsReward() : Object {
         return null;
      }
      
      public function get spellsReward() : Object {
         return null;
      }
      
      public function get objectiveIds() : Object {
         return new Object();
      }
      
      public function get rewardsIds() : Object {
         return new Object();
      }
      
      public function get name() : String {
         return null;
      }
      
      public function get description() : String {
         return null;
      }
      
      public function get dialog() : String {
         return null;
      }
      
      public function get objectives() : Object {
         return null;
      }
   }
}
