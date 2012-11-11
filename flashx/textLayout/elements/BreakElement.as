package flashx.textLayout.elements
{

    final public class BreakElement extends SpecialCharacterElement
    {

        public function BreakElement()
        {
            this.text = " ";
            return;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "br";
        }// end function

    }
}
