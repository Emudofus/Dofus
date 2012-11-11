package com.ankamagames.dofus.internalDatacenter.communication
{
    import com.ankamagames.jerakine.interfaces.*;

    public class BasicChatSentence extends Object implements IDataCenter
    {
        private var _id:uint;
        private var _baseMsg:String;
        private var _msg:String;
        private var _channel:uint;
        private var _timestamp:Number;
        private var _fingerprint:String;

        public function BasicChatSentence(param1:uint, param2:String, param3:String, param4:uint = 0, param5:Number = 0, param6:String = "")
        {
            this._id = param1;
            this._baseMsg = param2;
            this._msg = param3;
            this._channel = param4;
            this._timestamp = param5;
            this._fingerprint = param6;
            return;
        }// end function

        public function get id() : uint
        {
            return this._id;
        }// end function

        public function get baseMsg() : String
        {
            return this._baseMsg;
        }// end function

        public function get msg() : String
        {
            return this._msg;
        }// end function

        public function get channel() : uint
        {
            return this._channel;
        }// end function

        public function get timestamp() : Number
        {
            return this._timestamp;
        }// end function

        public function get fingerprint() : String
        {
            return this._fingerprint;
        }// end function

    }
}
