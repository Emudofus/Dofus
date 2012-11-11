package flashx.textLayout.elements
{
    import flashx.textLayout.compose.*;

    public class ContainerFormattedElement extends ParagraphFormattedElement
    {

        public function ContainerFormattedElement()
        {
            return;
        }// end function

        public function get flowComposer() : IFlowComposer
        {
            return null;
        }// end function

        override function formatChanged(param1:Boolean = true) : void
        {
            var _loc_2:* = 0;
            super.formatChanged(param1);
            if (this.flowComposer)
            {
                _loc_2 = 0;
                while (_loc_2 < this.flowComposer.numControllers)
                {
                    
                    this.flowComposer.getControllerAt(_loc_2).formatChanged();
                    _loc_2++;
                }
            }
            return;
        }// end function

        function preCompose() : void
        {
            return;
        }// end function

        override function normalizeRange(param1:uint, param2:uint) : void
        {
            var _loc_3:* = null;
            super.normalizeRange(param1, param2);
            if (this.numChildren == 0)
            {
                _loc_3 = new ParagraphElement();
                if (this.canOwnFlowElement(_loc_3))
                {
                    _loc_3.replaceChildren(0, 0, new SpanElement());
                    replaceChildren(0, 0, _loc_3);
                    _loc_3.normalizeRange(0, _loc_3.textLength);
                }
            }
            return;
        }// end function

    }
}
