package d2components
{
   public class StateContainer extends GraphicContainer
   {
      
      public function StateContainer() {
         super();
      }
      
      public function get changingStateData() : Object {
         return null;
      }
      
      public function set changingStateData(value:Object) : void {
      }
      
      public function set state(newState:*) : void {
      }
      
      public function get state() : * {
         return null;
      }
      
      public function get lockedProperties() : String {
         return null;
      }
      
      public function set lockedProperties(s:String) : void {
      }
   }
}
