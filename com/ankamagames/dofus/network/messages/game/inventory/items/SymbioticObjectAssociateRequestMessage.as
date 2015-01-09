package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SymbioticObjectAssociateRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6522;

        private var _isInitialized:Boolean = false;
        public var symbioteUID:uint = 0;
        public var symbiotePos:uint = 0;
        public var hostUID:uint = 0;
        public var hostPos:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6522);
        }

        public function initSymbioticObjectAssociateRequestMessage(symbioteUID:uint=0, symbiotePos:uint=0, hostUID:uint=0, hostPos:uint=0):SymbioticObjectAssociateRequestMessage
        {
            this.symbioteUID = symbioteUID;
            this.symbiotePos = symbiotePos;
            this.hostUID = hostUID;
            this.hostPos = hostPos;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.symbioteUID = 0;
            this.symbiotePos = 0;
            this.hostUID = 0;
            this.hostPos = 0;
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
            this.serializeAs_SymbioticObjectAssociateRequestMessage(output);
        }

        public function serializeAs_SymbioticObjectAssociateRequestMessage(output:ICustomDataOutput):void
        {
            if (this.symbioteUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.symbioteUID) + ") on element symbioteUID.")));
            };
            output.writeVarInt(this.symbioteUID);
            if ((((this.symbiotePos < 0)) || ((this.symbiotePos > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.symbiotePos) + ") on element symbiotePos.")));
            };
            output.writeByte(this.symbiotePos);
            if (this.hostUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.hostUID) + ") on element hostUID.")));
            };
            output.writeVarInt(this.hostUID);
            if ((((this.hostPos < 0)) || ((this.hostPos > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.hostPos) + ") on element hostPos.")));
            };
            output.writeByte(this.hostPos);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SymbioticObjectAssociateRequestMessage(input);
        }

        public function deserializeAs_SymbioticObjectAssociateRequestMessage(input:ICustomDataInput):void
        {
            this.symbioteUID = input.readVarUhInt();
            if (this.symbioteUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.symbioteUID) + ") on element of SymbioticObjectAssociateRequestMessage.symbioteUID.")));
            };
            this.symbiotePos = input.readUnsignedByte();
            if ((((this.symbiotePos < 0)) || ((this.symbiotePos > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.symbiotePos) + ") on element of SymbioticObjectAssociateRequestMessage.symbiotePos.")));
            };
            this.hostUID = input.readVarUhInt();
            if (this.hostUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.hostUID) + ") on element of SymbioticObjectAssociateRequestMessage.hostUID.")));
            };
            this.hostPos = input.readUnsignedByte();
            if ((((this.hostPos < 0)) || ((this.hostPos > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.hostPos) + ") on element of SymbioticObjectAssociateRequestMessage.hostPos.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

