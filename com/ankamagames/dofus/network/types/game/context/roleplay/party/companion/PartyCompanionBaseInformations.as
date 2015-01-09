package com.ankamagames.dofus.network.types.game.context.roleplay.party.companion
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.look.EntityLook;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class PartyCompanionBaseInformations implements INetworkType 
    {

        public static const protocolId:uint = 453;

        public var indexId:uint = 0;
        public var companionGenericId:uint = 0;
        public var entityLook:EntityLook;

        public function PartyCompanionBaseInformations()
        {
            this.entityLook = new EntityLook();
            super();
        }

        public function getTypeId():uint
        {
            return (453);
        }

        public function initPartyCompanionBaseInformations(indexId:uint=0, companionGenericId:uint=0, entityLook:EntityLook=null):PartyCompanionBaseInformations
        {
            this.indexId = indexId;
            this.companionGenericId = companionGenericId;
            this.entityLook = entityLook;
            return (this);
        }

        public function reset():void
        {
            this.indexId = 0;
            this.companionGenericId = 0;
            this.entityLook = new EntityLook();
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PartyCompanionBaseInformations(output);
        }

        public function serializeAs_PartyCompanionBaseInformations(output:ICustomDataOutput):void
        {
            if (this.indexId < 0)
            {
                throw (new Error((("Forbidden value (" + this.indexId) + ") on element indexId.")));
            };
            output.writeByte(this.indexId);
            if (this.companionGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.companionGenericId) + ") on element companionGenericId.")));
            };
            output.writeByte(this.companionGenericId);
            this.entityLook.serializeAs_EntityLook(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PartyCompanionBaseInformations(input);
        }

        public function deserializeAs_PartyCompanionBaseInformations(input:ICustomDataInput):void
        {
            this.indexId = input.readByte();
            if (this.indexId < 0)
            {
                throw (new Error((("Forbidden value (" + this.indexId) + ") on element of PartyCompanionBaseInformations.indexId.")));
            };
            this.companionGenericId = input.readByte();
            if (this.companionGenericId < 0)
            {
                throw (new Error((("Forbidden value (" + this.companionGenericId) + ") on element of PartyCompanionBaseInformations.companionGenericId.")));
            };
            this.entityLook = new EntityLook();
            this.entityLook.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.party.companion

