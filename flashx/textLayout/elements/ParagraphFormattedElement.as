package flashx.textLayout.elements
{

    public class ParagraphFormattedElement extends FlowGroupElement
    {

        public function ParagraphFormattedElement()
        {
            return;
        }// end function

        override public function shallowCopy(param1:int = 0, param2:int = -1) : FlowElement
        {
            return super.shallowCopy(param1, param2) as ParagraphFormattedElement;
        }// end function

    }
}
