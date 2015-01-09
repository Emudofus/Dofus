package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.jerakine.network.INetworkType;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class TaxCollectorBasicInformations implements INetworkType 
    {

        public static const protocolId:uint = 96;

        public var firstNameId:uint = 0;
        public var lastNameId:uint = 0;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;


        public function getTypeId():uint
        {
            return (96);
        }

        public function initTaxCollectorBasicInformations(firstNameId:uint=0, lastNameId:uint=0, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0):TaxCollectorBasicInformations
        {
            this.firstNameId = firstNameId;
            this.lastNameId = lastNameId;
            this.worldX = worldX;
            this.worldY = worldY;
            this.mapId = mapId;
            this.subAreaId = subAreaId;
            return (this);
        }

        public function reset():void
        {
            this.firstNameId = 0;
            this.lastNameId = 0;
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_TaxCollectorBasicInformations(output);
        }

        public function serializeAs_TaxCollectorBasicInformations(output:IDataOutput):void
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
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element worldX.")));
            };
            output.writeShort(this.worldX);
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element worldY.")));
            };
            output.writeShort(this.worldY);
            output.writeInt(this.mapId);
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeShort(this.subAreaId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TaxCollectorBasicInformations(input);
        }

        public function deserializeAs_TaxCollectorBasicInformations(input:IDataInput):void
        {
            this.firstNameId = input.readShort();
            if (this.firstNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.firstNameId) + ") on element of TaxCollectorBasicInformations.firstNameId.")));
            };
            this.lastNameId = input.readShort();
            if (this.lastNameId < 0)
            {
                throw (new Error((("Forbidden value (" + this.lastNameId) + ") on element of TaxCollectorBasicInformations.lastNameId.")));
            };
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of TaxCollectorBasicInformations.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of TaxCollectorBasicInformations.worldY.")));
            };
            this.mapId = input.readInt();
            this.subAreaId = input.readShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of TaxCollectorBasicInformations.subAreaId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.guild.tax

