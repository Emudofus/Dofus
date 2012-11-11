package com.ankamagames.dofus.internalDatacenter.communication
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class ChatSentenceWithSource extends BasicChatSentence implements IDataCenter
    {
        private var _senderId:uint;
        private var _senderName:String;
        private var _objects:Vector.<ItemWrapper>;
        private var _admin:Boolean;

        public function ChatSentenceWithSource(param1:uint, param2:String, param3:String, param4:uint = 0, param5:Number = 0, param6:String = "", param7:uint = 0, param8:String = "", param9:Vector.<ItemWrapper> = null, param10:Boolean = false)
        {
            super(param1, param2, param3, param4, param5, param6);
            this._senderId = param7;
            this._senderName = param8;
            this._objects = param9;
            this._admin = param10;
            return;
        }// end function

        public function get senderId() : uint
        {
            return this._senderId;
        }// end function

        public function get senderName() : String
        {
            return this._senderName;
        }// end function

        public function get objects() : Vector.<ItemWrapper>
        {
            return this._objects;
        }// end function

        public function get admin() : Boolean
        {
            return this._admin;
        }// end function

    }
}
