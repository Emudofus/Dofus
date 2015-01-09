package com.ankamagames.dofus.network.messages.game.context.roleplay.party.companion
{
    import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyUpdateLightMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PartyCompanionUpdateLightMessage extends PartyUpdateLightMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6472;

        private var _isInitialized:Boolean = false;
        public var indexId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6472);
        }

        public function initPartyCompanionUpdateLightMessage(partyId:uint=0, id:uint=0, lifePoints:uint=0, maxLifePoints:uint=0, prospecting:uint=0, regenRate:uint=0, indexId:uint=0):PartyCompanionUpdateLightMessage
        {
            super.initPartyUpdateLightMessage(partyId, id, lifePoints, maxLifePoints, prospecting, regenRate);
            this.indexId = indexId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.indexId = 0;
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartyCompanionUpdateLightMessage(output);
        }

        public function serializeAs_PartyCompanionUpdateLightMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_PartyUpdateLightMessage(output);
            if (this.indexId < 0)
            {
                throw (new Error((("Forbidden value (" + this.indexId) + ") on element indexId.")));
            };
            output.writeByte(this.indexId);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyCompanionUpdateLightMessage(input);
        }

        public function deserializeAs_PartyCompanionUpdateLightMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.indexId = input.readByte();
            if (this.indexId < 0)
            {
                throw (new Error((("Forbidden value (" + this.indexId) + ") on element of PartyCompanionUpdateLightMessage.indexId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.party.companion

