package flashx.textLayout.events
{
    import flash.events.*;
    import flashx.textLayout.elements.*;

    public class FlowElementEventDispatcher extends EventDispatcher
    {
        var _listenerCount:int = 0;
        var _element:FlowElement;

        public function FlowElementEventDispatcher(param1:FlowElement)
        {
            this._element = param1;
            super(null);
            return;
        }// end function

        override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
        {
            var _loc_6:* = null;
            super.addEventListener(param1, param2, param3, param4, param5);
            var _loc_7:* = this;
            var _loc_8:* = this._listenerCount + 1;
            _loc_7._listenerCount = _loc_8;
            if (this._listenerCount == 1)
            {
                _loc_6 = this._element.getTextFlow();
                if (_loc_6)
                {
                    _loc_6.incInteractiveObjectCount();
                }
            }
            this._element.modelChanged(ModelChange.ELEMENT_MODIFIED, this._element, 0, this._element.textLength);
            return;
        }// end function

        override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
        {
            var _loc_4:* = null;
            super.removeEventListener(param1, param2, param3);
            var _loc_5:* = this;
            var _loc_6:* = this._listenerCount - 1;
            _loc_5._listenerCount = _loc_6;
            if (this._listenerCount == 0)
            {
                _loc_4 = this._element.getTextFlow();
                if (_loc_4)
                {
                    _loc_4.decInteractiveObjectCount();
                }
            }
            this._element.modelChanged(ModelChange.ELEMENT_MODIFIED, this._element, 0, this._element.textLength);
            return;
        }// end function

    }
}
