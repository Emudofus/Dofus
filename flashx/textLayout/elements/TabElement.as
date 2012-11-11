package flashx.textLayout.elements
{

    final public class TabElement extends SpecialCharacterElement
    {

        public function TabElement()
        {
            this.text = "\t";
            return;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "tab";
        }// end function

    }
}
