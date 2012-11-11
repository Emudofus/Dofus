package com.ankamagames.atouin.messages
{
    import com.ankamagames.jerakine.messages.*;

    public class MapMessage extends Object implements Message
    {
        private var _id:uint;
        private var _transitionType:String;
        public var renderRequestId:uint;

        public function MapMessage()
        {
            return;
        }// end function

        public function get id() : uint
        {
            return this._id;
        }// end function

        public function set id(param1:uint) : void
        {
            this._id = param1;
            return;
        }// end function

        public function get transitionType() : String
        {
            return this._transitionType;
        }// end function

        public function set transitionType(param1:String) : void
        {
            this._transitionType = param1;
            return;
        }// end function

    }
}
