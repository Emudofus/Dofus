package com.ankamagames.dofus.network.messages.game.chat.channel
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ChannelEnablingMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var channel:uint = 0;
        public var enable:Boolean = false;
        public static const protocolId:uint = 890;

        public function ChannelEnablingMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 890;
        }// end function

        public function initChannelEnablingMessage(param1:uint = 0, param2:Boolean = false) : ChannelEnablingMessage
        {
            this.channel = param1;
            this.enable = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.channel = 0;
            this.enable = false;
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
            this.serializeAs_ChannelEnablingMessage(param1);
            return;
        }// end function

        public function serializeAs_ChannelEnablingMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.channel);
            param1.writeBoolean(this.enable);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ChannelEnablingMessage(param1);
            return;
        }// end function

        public function deserializeAs_ChannelEnablingMessage(param1:IDataInput) : void
        {
            this.channel = param1.readByte();
            if (this.channel < 0)
            {
                throw new Error("Forbidden value (" + this.channel + ") on element of ChannelEnablingMessage.channel.");
            }
            this.enable = param1.readBoolean();
            return;
        }// end function

    }
}
