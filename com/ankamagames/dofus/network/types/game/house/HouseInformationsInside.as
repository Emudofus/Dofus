package com.ankamagames.dofus.network.types.game.house
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class HouseInformationsInside implements INetworkType 
    {

        public static const protocolId:uint = 218;

        public var houseId:uint = 0;
        public var modelId:uint = 0;
        public var ownerId:int = 0;
        public var ownerName:String = "";
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var price:uint = 0;
        public var isLocked:Boolean = false;


        public function getTypeId():uint
        {
            return (218);
        }

        public function initHouseInformationsInside(houseId:uint=0, modelId:uint=0, ownerId:int=0, ownerName:String="", worldX:int=0, worldY:int=0, price:uint=0, isLocked:Boolean=false):HouseInformationsInside
        {
            this.houseId = houseId;
            this.modelId = modelId;
            this.ownerId = ownerId;
            this.ownerName = ownerName;
            this.worldX = worldX;
            this.worldY = worldY;
            this.price = price;
            this.isLocked = isLocked;
            return (this);
        }

        public function reset():void
        {
            this.houseId = 0;
            this.modelId = 0;
            this.ownerId = 0;
            this.ownerName = "";
            this.worldX = 0;
            this.worldY = 0;
            this.price = 0;
            this.isLocked = false;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HouseInformationsInside(output);
        }

        public function serializeAs_HouseInformationsInside(output:ICustomDataOutput):void
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
            output.writeInt(this.ownerId);
            output.writeUTF(this.ownerName);
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
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element price.")));
            };
            output.writeInt(this.price);
            output.writeBoolean(this.isLocked);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseInformationsInside(input);
        }

        public function deserializeAs_HouseInformationsInside(input:ICustomDataInput):void
        {
            this.houseId = input.readInt();
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element of HouseInformationsInside.houseId.")));
            };
            this.modelId = input.readVarUhShort();
            if (this.modelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.modelId) + ") on element of HouseInformationsInside.modelId.")));
            };
            this.ownerId = input.readInt();
            this.ownerName = input.readUTF();
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of HouseInformationsInside.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of HouseInformationsInside.worldY.")));
            };
            this.price = input.readInt();
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element of HouseInformationsInside.price.")));
            };
            this.isLocked = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.types.game.house

