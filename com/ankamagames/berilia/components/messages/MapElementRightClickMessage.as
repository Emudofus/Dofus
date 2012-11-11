package com.ankamagames.berilia.components.messages
{
    import com.ankamagames.berilia.types.data.*;
    import com.ankamagames.berilia.types.graphic.*;

    public class MapElementRightClickMessage extends ComponentMessage
    {
        private var _targetedElement:MapElement;

        public function MapElementRightClickMessage(param1:GraphicContainer, param2:MapElement)
        {
            super(param1);
            this._targetedElement = param2;
            _target = param1;
            return;
        }// end function

        public function get targetedElement() : MapElement
        {
            return this._targetedElement;
        }// end function

    }
}
