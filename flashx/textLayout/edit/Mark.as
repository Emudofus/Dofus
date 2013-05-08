package flashx.textLayout.edit
{


   public class Mark extends Object
   {
         

      public function Mark(value:int=0) {
         super();
         this._position=value;
      }



      private var _position:int;

      public function get position() : int {
         return this._position;
      }

      public function set position(value:int) : void {
         this._position=value;
      }
   }

}