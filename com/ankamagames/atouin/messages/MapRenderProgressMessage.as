package com.ankamagames.atouin.messages
{

    public class MapRenderProgressMessage extends MapMessage
    {
        private var _percent:Number = 0;

        public function MapRenderProgressMessage(param1:Number)
        {
            this._percent = param1;
            return;
        }// end function

        public function get percent() : Number
        {
            return this._percent;
        }// end function

    }
}
