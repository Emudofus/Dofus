package d2data
{
   public class Shortcut extends Object
   {
      
      public function Shortcut() {
         super();
      }
      
      public function get defaultBind() : Bind {
         return new Bind();
      }
      
      public function get unicID() : uint {
         return 0;
      }
      
      public function get name() : String {
         return null;
      }
      
      public function get description() : String {
         return null;
      }
      
      public function get tooltipContent() : String {
         return null;
      }
      
      public function get textfieldEnabled() : Boolean {
         return false;
      }
      
      public function get bindable() : Boolean {
         return false;
      }
      
      public function get category() : Object {
         return null;
      }
      
      public function get visible() : Boolean {
         return false;
      }
      
      public function get required() : Boolean {
         return false;
      }
      
      public function get holdKeys() : Boolean {
         return false;
      }
      
      public function get disable() : Boolean {
         return false;
      }
   }
}
