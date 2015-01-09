package com.ankamagames.dofus.network.types.game.context.roleplay.party.companion
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class PartyCompanionMemberInformations extends PartyCompanionBaseInformations implements INetworkType 
    {

        public static const protocolId:uint = 452;

        public var initiative:uint = 0;
        public var lifePoints:uint = 0;
        public var maxLifePoints:uint = 0;
        public var prospecting:uint = 0;
        public var regenRate:uint = 0;


        override public function getTypeId():uint
        {
            return (452);
        }

        public function initPartyCompanionMemberInformations(indexId:uint=0, companionGenericId:uint=0, entityLook:EntityLook=null, initiative:uint=0, lifePoints:uint=0, maxLifePoints:uint=0, prospecting:uint=0, regenRate:uint=0):PartyCompanionMemberInformations
        {
            super.initPartyCompanionBaseInformations(indexId, companionGenericId, entityLook);
            this.initiative = initiative;
            this.lifePoints = lifePoints;
            this.maxLifePoints = maxLifePoints;
            this.prospecting = prospecting;
            this.regenRate = regenRate;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.initiative = 0;
            this.lifePoints = 0;
            this.maxLifePoints = 0;
            this.prospecting = 0;
            this.regenRate = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartyCompanionMemberInformations(output);
        }

        public function serializeAs_PartyCompanionMemberInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_PartyCompanionBaseInformations(output);
            if (this.initiative < 0)
            {
                throw (new Error((("Forbidden value (" + this.initiative) + ") on element initiative.")));
            };
            output.writeVarShort(this.initiative);
            if (this.lifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePoints) + ") on element lifePoints.")));
            };
            output.writeVarInt(this.lifePoints);
            if (this.maxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxLifePoints) + ") on element maxLifePoints.")));
            };
            output.writeVarInt(this.maxLifePoints);
            if (this.prospecting < 0)
            {
                throw (new Error((("Forbidden value (" + this.prospecting) + ") on element prospecting.")));
            };
            output.writeVarShort(this.prospecting);
            if ((((this.regenRate < 0)) || ((this.regenRate > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.regenRate) + ") on element regenRate.")));
            };
            output.writeByte(this.regenRate);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyCompanionMemberInformations(input);
        }

        public function deserializeAs_PartyCompanionMemberInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.initiative = input.readVarUhShort();
            if (this.initiative < 0)
            {
                throw (new Error((("Forbidden value (" + this.initiative) + ") on element of PartyCompanionMemberInformations.initiative.")));
            };
            this.lifePoints = input.readVarUhInt();
            if (this.lifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.lifePoints) + ") on element of PartyCompanionMemberInformations.lifePoints.")));
            };
            this.maxLifePoints = input.readVarUhInt();
            if (this.maxLifePoints < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxLifePoints) + ") on element of PartyCompanionMemberInformations.maxLifePoints.")));
            };
            this.prospecting = input.readVarUhShort();
            if (this.prospecting < 0)
            {
                throw (new Error((("Forbidden value (" + this.prospecting) + ") on element of PartyCompanionMemberInformations.prospecting.")));
            };
            this.regenRate = input.readUnsignedByte();
            if ((((this.regenRate < 0)) || ((this.regenRate > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.regenRate) + ") on element of PartyCompanionMemberInformations.regenRate.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.party.companion

