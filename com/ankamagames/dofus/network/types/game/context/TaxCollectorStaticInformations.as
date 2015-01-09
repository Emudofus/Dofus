package com.ankamagames.dofus.network.types.game.context
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    public class TaxCollectorStaticInformations implements INetworkType 
    {

        public static const protocolId:uint = 147;

        public var firstNameId:uint = 0;
        public var lastNameId:uint = 0;
        public var guildIdentity:GuildInformations;

        public function TaxCollectorStaticInformations()
        {
            this.guildIdentity = new GuildInformations();
            super();
        }

        public function getTypeId():uint
        {
            return (147);
        }

        public function initTaxCollectorStaticInformations(firstNameId:uint=0, lastNameId:uint=0, guildIdentity:GuildInformations=null):TaxCollectorStaticInformations
        {
            this.firstNameId = firstNameId;
            this.lastNameId = lastNameId;
            this.guildIdentity = guildIdentity;
            return (this);
        }

        public function reset():void
        {
            this.firstNameId = 0;
            this.lastNameId = 0;
            this.guildIdentity = new GuildInformations();
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_TaxCollectorStaticInformations(output);
        }

        public function serializeAs_TaxCollectorStaticInformations(output:IDataOutput):void
        {
            if (this.firstNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.firstNameId) + ") on element firstNameId.")));
            };
            output.writeShort(this.firstNameId);
            if (this.lastNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastNameId) + ") on element lastNameId.")));
            };
            output.writeShort(this.lastNameId);
            this.guildIdentity.serializeAs_GuildInformations(output);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TaxCollectorStaticInformations(input);
        }

        public function deserializeAs_TaxCollectorStaticInformations(input:IDataInput):void
        {
            this.firstNameId = input.readShort();
            if (this.firstNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.firstNameId) + ") on element of TaxCollectorStaticInformations.firstNameId.")));
            };
            this.lastNameId = input.readShort();
            if (this.lastNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastNameId) + ") on element of TaxCollectorStaticInformations.lastNameId.")));
            };
            this.guildIdentity = new GuildInformations();
            this.guildIdentity.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.types.game.context

