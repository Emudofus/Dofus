package flashx.textLayout.elements
{

    final public class DivElement extends ContainerFormattedElement
    {

        public function DivElement()
        {
            return;
        }// end function

        override protected function get abstract() : Boolean
        {
            return false;
        }// end function

        override function get defaultTypeName() : String
        {
            return "div";
        }// end function

    }
}
