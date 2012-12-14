package flashx.textLayout.edit
{

    public class Mark extends Object
    {
        private var _position:int;

        public function Mark(param1:int = 0)
        {
            this._position = param1;
            return;
        }// end function

        public function get position() : int
        {
            return this._position;
        }// end function

        public function set position(param1:int) : void
        {
            this._position = param1;
            return;
        }// end function

    }
}
