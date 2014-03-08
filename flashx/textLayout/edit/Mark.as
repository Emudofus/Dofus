package flashx.textLayout.edit
{
   public class Mark extends Object
   {
      
      public function Mark(param1:int=0) {
         super();
         this._position = param1;
      }
      
      private var _position:int;
      
      public function get position() : int {
         return this._position;
      }
      
      public function set position(param1:int) : void {
         this._position = param1;
      }
   }
}
