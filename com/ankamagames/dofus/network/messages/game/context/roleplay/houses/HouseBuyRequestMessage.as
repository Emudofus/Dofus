package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class HouseBuyRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5738;

        private var _isInitialized:Boolean = false;
        public var proposedPrice:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5738);
        }

        public function initHouseBuyRequestMessage(proposedPrice:uint=0):HouseBuyRequestMessage
        {
            this.proposedPrice = proposedPrice;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.proposedPrice = 0;
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
            this.serializeAs_HouseBuyRequestMessage(output);
        }

        public function serializeAs_HouseBuyRequestMessage(output:ICustomDataOutput):void
        {
            if (this.proposedPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.proposedPrice) + ") on element proposedPrice.")));
            };
            output.writeVarInt(this.proposedPrice);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseBuyRequestMessage(input);
        }

        public function deserializeAs_HouseBuyRequestMessage(input:ICustomDataInput):void
        {
            this.proposedPrice = input.readVarUhInt();
            if (this.proposedPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.proposedPrice) + ") on element of HouseBuyRequestMessage.proposedPrice.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses

