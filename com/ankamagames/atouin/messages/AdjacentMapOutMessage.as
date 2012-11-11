package com.ankamagames.atouin.messages
{
    import com.ankamagames.jerakine.messages.*;
    import flash.display.*;

    public class AdjacentMapOutMessage extends Object implements Message
    {
        private var _nDirection:uint;
        private var _spZone:DisplayObject;

        public function AdjacentMapOutMessage(param1:uint, param2:DisplayObject)
        {
            this._nDirection = param1;
            this._spZone = param2;
            return;
        }// end function

        public function get direction() : uint
        {
            return this._nDirection;
        }// end function

        public function get zone() : DisplayObject
        {
            return this._spZone;
        }// end function

    }
}
