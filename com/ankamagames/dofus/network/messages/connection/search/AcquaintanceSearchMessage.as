package com.ankamagames.dofus.network.messages.connection.search
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AcquaintanceSearchMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var nickname:String = "";
        public static const protocolId:uint = 6144;

        public function AcquaintanceSearchMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6144;
        }// end function

        public function initAcquaintanceSearchMessage(param1:String = "") : AcquaintanceSearchMessage
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
            this.serializeAs_AcquaintanceSearchMessage(param1);
            return;
        }// end function

        public function serializeAs_AcquaintanceSearchMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.nickname);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AcquaintanceSearchMessage(param1);
            return;
        }// end function

        public function deserializeAs_AcquaintanceSearchMessage(param1:IDataInput) : void
        {
            this.nickname = param1.readUTF();
            return;
        }// end function

    }
}
