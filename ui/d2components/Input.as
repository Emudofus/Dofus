package d2components
{
   public class Input extends Label
   {
      
      public function Input() {
         super();
      }
      
      public function get imeActive() : Boolean {
         return new Boolean();
      }
      
      public function set imeActive(v:Boolean) : void {
      }
      
      public function get focusEventHandlerPriority() : Boolean {
         return new Boolean();
      }
      
      public function set focusEventHandlerPriority(v:Boolean) : void {
      }
      
      public function get lastTextOnInput() : String {
         return null;
      }
      
      public function get maxChars() : uint {
         return 0;
      }
      
      public function set maxChars(nValue:uint) : void {
      }
      
      public function set numberMax(nValue:uint) : void {
      }
      
      public function get password() : Boolean {
         return false;
      }
      
      public function set password(bValue:Boolean) : void {
      }
      
      public function get numberAutoFormat() : Boolean {
         return false;
      }
      
      public function set numberAutoFormat(bValue:Boolean) : void {
      }
      
      public function get numberSeparator() : String {
         return null;
      }
      
      public function set numberSeparator(bValue:String) : void {
      }
      
      public function get restrictChars() : String {
         return null;
      }
      
      public function set restrictChars(sValue:String) : void {
      }
      
      public function get haveFocus() : Boolean {
         return false;
      }
      
      public function blur() : void {
      }
      
      public function setSelection(start:int, end:int) : void {
      }
      
      public function removeSpace(spaced:String) : String {
         return null;
      }
   }
}
