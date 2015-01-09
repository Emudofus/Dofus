package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SymbioticObjectAssociatedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6527;

        private var _isInitialized:Boolean = false;
        public var hostUID:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6527);
        }

        public function initSymbioticObjectAssociatedMessage(hostUID:uint=0):SymbioticObjectAssociatedMessage
        {
            this.hostUID = hostUID;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.hostUID = 0;
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
            this.serializeAs_SymbioticObjectAssociatedMessage(output);
        }

        public function serializeAs_SymbioticObjectAssociatedMessage(output:ICustomDataOutput):void
        {
            if (this.hostUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.hostUID) + ") on element hostUID.")));
            };
            output.writeVarInt(this.hostUID);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SymbioticObjectAssociatedMessage(input);
        }

        public function deserializeAs_SymbioticObjectAssociatedMessage(input:ICustomDataInput):void
        {
            this.hostUID = input.readVarUhInt();
            if (this.hostUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.hostUID) + ") on element of SymbioticObjectAssociatedMessage.hostUID.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

