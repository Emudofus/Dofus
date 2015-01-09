package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class TaxCollectorLootInformations extends TaxCollectorComplementaryInformations implements INetworkType 
    {

        public static const protocolId:uint = 372;

        public var kamas:uint = 0;
        public var experience:Number = 0;
        public var pods:uint = 0;
        public var itemsValue:uint = 0;


        override public function getTypeId():uint
        {
            return (372);
        }

        public function initTaxCollectorLootInformations(kamas:uint=0, experience:Number=0, pods:uint=0, itemsValue:uint=0):TaxCollectorLootInformations
        {
            this.kamas = kamas;
            this.experience = experience;
            this.pods = pods;
            this.itemsValue = itemsValue;
            return (this);
        }

        override public function reset():void
        {
            this.kamas = 0;
            this.experience = 0;
            this.pods = 0;
            this.itemsValue = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_TaxCollectorLootInformations(output);
        }

        public function serializeAs_TaxCollectorLootInformations(output:ICustomDataOutput):void
        {
            super.serializeAs_TaxCollectorComplementaryInformations(output);
            if (this.kamas < 0)
            {
                throw (new Error((("Forbidden value (" + this.kamas) + ") on element kamas.")));
            };
            output.writeVarInt(this.kamas);
            if ((((this.experience < 0)) || ((this.experience > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experience) + ") on element experience.")));
            };
            output.writeVarLong(this.experience);
            if (this.pods < 0)
            {
                throw (new Error((("Forbidden value (" + this.pods) + ") on element pods.")));
            };
            output.writeVarInt(this.pods);
            if (this.itemsValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.itemsValue) + ") on element itemsValue.")));
            };
            output.writeVarInt(this.itemsValue);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_TaxCollectorLootInformations(input);
        }

        public function deserializeAs_TaxCollectorLootInformations(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.kamas = input.readVarUhInt();
            if (this.kamas < 0)
            {
                throw (new Error((("Forbidden value (" + this.kamas) + ") on element of TaxCollectorLootInformations.kamas.")));
            };
            this.experience = input.readVarUhLong();
            if ((((this.experience < 0)) || ((this.experience > 9007199254740992))))
            {
                throw (new Error((("Forbidden value (" + this.experience) + ") on element of TaxCollectorLootInformations.experience.")));
            };
            this.pods = input.readVarUhInt();
            if (this.pods < 0)
            {
                throw (new Error((("Forbidden value (" + this.pods) + ") on element of TaxCollectorLootInformations.pods.")));
            };
            this.itemsValue = input.readVarUhInt();
            if (this.itemsValue < 0)
            {
                throw (new Error((("Forbidden value (" + this.itemsValue) + ") on element of TaxCollectorLootInformations.itemsValue.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.guild.tax

