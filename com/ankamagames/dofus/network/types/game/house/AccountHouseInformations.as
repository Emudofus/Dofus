package com.ankamagames.dofus.network.types.game.house
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class AccountHouseInformations implements INetworkType 
    {

        public static const protocolId:uint = 390;

        public var houseId:uint = 0;
        public var modelId:uint = 0;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;


        public function getTypeId():uint
        {
            return (390);
        }

        public function initAccountHouseInformations(houseId:uint=0, modelId:uint=0, worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0):AccountHouseInformations
        {
            this.houseId = houseId;
            this.modelId = modelId;
            this.worldX = worldX;
            this.worldY = worldY;
            this.mapId = mapId;
            this.subAreaId = subAreaId;
            return (this);
        }

        public function reset():void
        {
            this.houseId = 0;
            this.modelId = 0;
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AccountHouseInformations(output);
        }

        public function serializeAs_AccountHouseInformations(output:ICustomDataOutput):void
        {
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element houseId.")));
            };
            output.writeInt(this.houseId);
            if (this.modelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.modelId) + ") on element modelId.")));
            };
            output.writeVarShort(this.modelId);
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
            output.writeVarShort(this.subAreaId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AccountHouseInformations(input);
        }

        public function deserializeAs_AccountHouseInformations(input:ICustomDataInput):void
        {
            this.houseId = input.readInt();
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element of AccountHouseInformations.houseId.")));
            };
            this.modelId = input.readVarUhShort();
            if (this.modelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.modelId) + ") on element of AccountHouseInformations.modelId.")));
            };
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of AccountHouseInformations.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of AccountHouseInformations.worldY.")));
            };
            this.mapId = input.readInt();
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of AccountHouseInformations.subAreaId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.house

