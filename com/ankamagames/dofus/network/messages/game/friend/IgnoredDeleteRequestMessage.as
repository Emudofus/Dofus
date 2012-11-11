package com.ankamagames.dofus.network.messages.game.friend
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class IgnoredDeleteRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var name:String = "";
        public var session:Boolean = false;
        public static const protocolId:uint = 5680;

        public function IgnoredDeleteRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5680;
        }// end function

        public function initIgnoredDeleteRequestMessage(param1:String = "", param2:Boolean = false) : IgnoredDeleteRequestMessage
        {
            this.name = param1;
            this.session = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.name = "";
            this.session = false;
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
            this.serializeAs_IgnoredDeleteRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_IgnoredDeleteRequestMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.name);
            param1.writeBoolean(this.session);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_IgnoredDeleteRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_IgnoredDeleteRequestMessage(param1:IDataInput) : void
        {
            this.name = param1.readUTF();
            this.session = param1.readBoolean();
            return;
        }// end function

    }
}
