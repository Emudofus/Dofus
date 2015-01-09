package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class BasicAckMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6362;

        private var _isInitialized:Boolean = false;
        public var seq:uint = 0;
        public var lastPacketId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6362);
        }

        public function initBasicAckMessage(seq:uint=0, lastPacketId:uint=0):BasicAckMessage
        {
            this.seq = seq;
            this.lastPacketId = lastPacketId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.seq = 0;
            this.lastPacketId = 0;
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_BasicAckMessage(output);
        }

        public function serializeAs_BasicAckMessage(output:ICustomDataOutput):void
        {
            if (this.seq < 0)
            {
                throw (new Error((("Forbidden value (" + this.seq) + ") on element seq.")));
            };
            output.writeVarInt(this.seq);
            if (this.lastPacketId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastPacketId) + ") on element lastPacketId.")));
            };
            output.writeVarShort(this.lastPacketId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_BasicAckMessage(input);
        }

        public function deserializeAs_BasicAckMessage(input:ICustomDataInput):void
        {
            this.seq = input.readVarUhInt();
            if (this.seq < 0)
            {
                throw (new Error((("Forbidden value (" + this.seq) + ") on element of BasicAckMessage.seq.")));
            };
            this.lastPacketId = input.readVarUhShort();
            if (this.lastPacketId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastPacketId) + ") on element of BasicAckMessage.lastPacketId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

