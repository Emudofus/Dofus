package com.ankamagames.dofus.network.messages.connection.register
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class NicknameChoiceRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var nickname:String = "";
        public static const protocolId:uint = 5639;

        public function NicknameChoiceRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5639;
        }// end function

        public function initNicknameChoiceRequestMessage(param1:String = "") : NicknameChoiceRequestMessage
        {
            this.nickname = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.nickname = "";
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_NicknameChoiceRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_NicknameChoiceRequestMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.nickname);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_NicknameChoiceRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_NicknameChoiceRequestMessage(param1:IDataInput) : void
        {
            this.nickname = param1.readUTF();
            return;
        }// end function

    }
}
