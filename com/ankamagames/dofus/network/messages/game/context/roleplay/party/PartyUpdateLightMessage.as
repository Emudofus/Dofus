package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class PartyUpdateLightMessage extends AbstractPartyEventMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6054;

        private var _isInitialized:Boolean = false;
        public var id:uint = 0;
        public var lifePoints:uint = 0;
        public var maxLifePoints:uint = 0;
        public var prospecting:uint = 0;
        public var regenRate:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6054);
        }

        public function initPartyUpdateLightMessage(partyId:uint=0, id:uint=0, lifePoints:uint=0, maxLifePoints:uint=0, prospecting:uint=0, regenRate:uint=0):PartyUpdateLightMessage
        {
            super.initAbstractPartyEventMessage(partyId);
            this.id = id;
            this.lifePoints = lifePoints;
            this.maxLifePoints = maxLifePoints;
            this.prospecting = prospecting;
            this.regenRate = regenRate;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.id = 0;
            this.lifePoints = 0;
            this.maxLifePoints = 0;
            this.prospecting = 0;
            this.regenRate = 0;
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_PartyUpdateLightMessage(output);
        }

        public function serializeAs_PartyUpdateLightMessage(output:IDataOutput):void
        {
            super.serializeAs_AbstractPartyEventMessage(output);
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element id.")));
            };
            output.writeInt(this.id);
            if (this.lifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePoints) + ") on element lifePoints.")));
            };
            output.writeInt(this.lifePoints);
            if (this.maxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxLifePoints) + ") on element maxLifePoints.")));
            };
            output.writeInt(this.maxLifePoints);
            if (this.prospecting < 0)
            {
                throw (new Error((("Forbidden value (" + this.prospecting) + ") on element prospecting.")));
            };
            output.writeShort(this.prospecting);
            if ((((this.regenRate < 0)) || ((this.regenRate > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.regenRate) + ") on element regenRate.")));
            };
            output.writeByte(this.regenRate);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PartyUpdateLightMessage(input);
        }

        public function deserializeAs_PartyUpdateLightMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.id = input.readInt();
            if (this.id < 0)
            {
                throw (new Error((("Forbidden value (" + this.id) + ") on element of PartyUpdateLightMessage.id.")));
            };
            this.lifePoints = input.readInt();
            if (this.lifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePoints) + ") on element of PartyUpdateLightMessage.lifePoints.")));
            };
            this.maxLifePoints = input.readInt();
            if (this.maxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxLifePoints) + ") on element of PartyUpdateLightMessage.maxLifePoints.")));
            };
            this.prospecting = input.readShort();
            if (this.prospecting < 0)
            {
                throw (new Error((("Forbidden value (" + this.prospecting) + ") on element of PartyUpdateLightMessage.prospecting.")));
            };
            this.regenRate = input.readUnsignedByte();
            if ((((this.regenRate < 0)) || ((this.regenRate > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.regenRate) + ") on element of PartyUpdateLightMessage.regenRate.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party

