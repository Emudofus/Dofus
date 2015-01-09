package com.ankamagames.atouin.messages
{
    import com.ankamagames.jerakine.messages.Message;

    public class MapMessage implements Message 
    {

        private var _id:uint;
        private var _transitionType:String;
        public var renderRequestId:uint;


        public function get id():uint
        {
            return (this._id);
        }

        public function set id(nValue:uint):void
        {
            this._id = nValue;
        }

        public function get transitionType():String
        {
            return (this._transitionType);
        }

        public function set transitionType(sValue:String):void
        {
            this._transitionType = sValue;
        }


    }
}//package com.ankamagames.atouin.messages

