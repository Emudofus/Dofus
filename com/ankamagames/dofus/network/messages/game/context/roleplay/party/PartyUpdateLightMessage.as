package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PartyUpdateLightMessage extends AbstractPartyEventMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var id:uint = 0;
        public var lifePoints:uint = 0;
        public var maxLifePoints:uint = 0;
        public var prospecting:uint = 0;
        public var regenRate:uint = 0;
        public static const protocolId:uint = 6054;

        public function PartyUpdateLightMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6054;
        }// end function

        public function initPartyUpdateLightMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0, param5:uint = 0, param6:uint = 0) : PartyUpdateLightMessage
        {
            super.initAbstractPartyEventMessage(param1);
            this.id = param2;
            this.lifePoints = param3;
            this.maxLifePoints = param4;
            this.prospecting = param5;
            this.regenRate = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.id = 0;
            this.lifePoints = 0;
            this.maxLifePoints = 0;
            this.prospecting = 0;
            this.regenRate = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PartyUpdateLightMessage(param1);
            return;
        }// end function

        public function serializeAs_PartyUpdateLightMessage(param1:IDataOutput) : void
        {
            super.serializeAs_AbstractPartyEventMessage(param1);
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element id.");
            }
            param1.writeInt(this.id);
            if (this.lifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.lifePoints + ") on element lifePoints.");
            }
            param1.writeInt(this.lifePoints);
            if (this.maxLifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.maxLifePoints + ") on element maxLifePoints.");
            }
            param1.writeInt(this.maxLifePoints);
            if (this.prospecting < 0)
            {
                throw new Error("Forbidden value (" + this.prospecting + ") on element prospecting.");
            }
            param1.writeShort(this.prospecting);
            if (this.regenRate < 0 || this.regenRate > 255)
            {
                throw new Error("Forbidden value (" + this.regenRate + ") on element regenRate.");
            }
            param1.writeByte(this.regenRate);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PartyUpdateLightMessage(param1);
            return;
        }// end function

        public function deserializeAs_PartyUpdateLightMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.id = param1.readInt();
            if (this.id < 0)
            {
                throw new Error("Forbidden value (" + this.id + ") on element of PartyUpdateLightMessage.id.");
            }
            this.lifePoints = param1.readInt();
            if (this.lifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.lifePoints + ") on element of PartyUpdateLightMessage.lifePoints.");
            }
            this.maxLifePoints = param1.readInt();
            if (this.maxLifePoints < 0)
            {
                throw new Error("Forbidden value (" + this.maxLifePoints + ") on element of PartyUpdateLightMessage.maxLifePoints.");
            }
            this.prospecting = param1.readShort();
            if (this.prospecting < 0)
            {
                throw new Error("Forbidden value (" + this.prospecting + ") on element of PartyUpdateLightMessage.prospecting.");
            }
            this.regenRate = param1.readUnsignedByte();
            if (this.regenRate < 0 || this.regenRate > 255)
            {
                throw new Error("Forbidden value (" + this.regenRate + ") on element of PartyUpdateLightMessage.regenRate.");
            }
            return;
        }// end function

    }
}
