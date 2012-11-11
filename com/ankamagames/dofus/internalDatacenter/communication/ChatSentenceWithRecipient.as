package com.ankamagames.dofus.internalDatacenter.communication
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.interfaces.*;

    public class ChatSentenceWithRecipient extends ChatSentenceWithSource implements IDataCenter
    {
        private var _receiverName:String;
        private var _receiverId:uint;

        public function ChatSentenceWithRecipient(param1:uint, param2:String, param3:String, param4:uint = 0, param5:Number = 0, param6:String = "", param7:uint = 0, param8:String = "", param9:String = "", param10:uint = 0, param11:Vector.<ItemWrapper> = null)
        {
            super(param1, param2, param3, param4, param5, param6, param7, param8, param11);
            this._receiverName = param9;
            this._receiverId = param10;
            return;
        }// end function

        public function get receiverName() : String
        {
            return this._receiverName;
        }// end function

        public function get receiverId() : uint
        {
            return this._receiverId;
        }// end function

    }
}
