package com.ankamagames.berilia.components.messages
{
    import com.ankamagames.jerakine.interfaces.*;
    import flash.display.*;

    public class DropMessage extends ComponentMessage
    {
        private var _source:ISlotDataHolder;

        public function DropMessage(param1:InteractiveObject, param2:ISlotDataHolder)
        {
            super(param1);
            this._source = param2;
            return;
        }// end function

        public function get source() : ISlotDataHolder
        {
            return this._source;
        }// end function

    }
}
