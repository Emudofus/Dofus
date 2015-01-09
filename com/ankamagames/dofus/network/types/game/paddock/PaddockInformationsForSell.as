package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.jerakine.network.INetworkType;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class PaddockInformationsForSell implements INetworkType 
    {

        public static const protocolId:uint = 222;

        public var guildOwner:String = "";
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var subAreaId:uint = 0;
        public var nbMount:int = 0;
        public var nbObject:int = 0;
        public var price:uint = 0;


        public function getTypeId():uint
        {
            return (222);
        }

        public function initPaddockInformationsForSell(guildOwner:String="", worldX:int=0, worldY:int=0, subAreaId:uint=0, nbMount:int=0, nbObject:int=0, price:uint=0):PaddockInformationsForSell
        {
            this.guildOwner = guildOwner;
            this.worldX = worldX;
            this.worldY = worldY;
            this.subAreaId = subAreaId;
            this.nbMount = nbMount;
            this.nbObject = nbObject;
            this.price = price;
            return (this);
        }

        public function reset():void
        {
            this.guildOwner = "";
            this.worldX = 0;
            this.worldY = 0;
            this.subAreaId = 0;
            this.nbMount = 0;
            this.nbObject = 0;
            this.price = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_PaddockInformationsForSell(output);
        }

        public function serializeAs_PaddockInformationsForSell(output:ICustomDataOutput):void
        {
            output.writeUTF(this.guildOwner);
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
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeVarShort(this.subAreaId);
            output.writeByte(this.nbMount);
            output.writeByte(this.nbObject);
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element price.")));
            };
            output.writeVarInt(this.price);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PaddockInformationsForSell(input);
        }

        public function deserializeAs_PaddockInformationsForSell(input:ICustomDataInput):void
        {
            this.guildOwner = input.readUTF();
            this.worldX = input.readShort();
            if ((((this.worldX < -255)) || ((this.worldX > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldX) + ") on element of PaddockInformationsForSell.worldX.")));
            };
            this.worldY = input.readShort();
            if ((((this.worldY < -255)) || ((this.worldY > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.worldY) + ") on element of PaddockInformationsForSell.worldY.")));
            };
            this.subAreaId = input.readVarUhShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PaddockInformationsForSell.subAreaId.")));
            };
            this.nbMount = input.readByte();
            this.nbObject = input.readByte();
            this.price = input.readVarUhInt();
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element of PaddockInformationsForSell.price.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.paddock

