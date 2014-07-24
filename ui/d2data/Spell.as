package d2data
{
   public class Spell extends Object
   {
      
      public function Spell() {
         super();
      }
      
      public function get id() : int {
         return new int();
      }
      
      public function get nameId() : uint {
         return new uint();
      }
      
      public function get descriptionId() : uint {
         return new uint();
      }
      
      public function get typeId() : uint {
         return new uint();
      }
      
      public function get scriptParams() : String {
         return new String();
      }
      
      public function get scriptParamsCritical() : String {
         return new String();
      }
      
      public function get scriptId() : int {
         return new int();
      }
      
      public function get scriptIdCritical() : int {
         return new int();
      }
      
      public function get iconId() : uint {
         return new uint();
      }
      
      public function get spellLevels() : Object {
         return new Object();
      }
      
      public function get useParamCache() : Boolean {
         return new Boolean();
      }
      
      public function get verbose_cast() : Boolean {
         return new Boolean();
      }
      
      public function get name() : String {
         return null;
      }
      
      public function get description() : String {
         return null;
      }
      
      public function get type() : SpellType {
         return null;
      }
   }
}
