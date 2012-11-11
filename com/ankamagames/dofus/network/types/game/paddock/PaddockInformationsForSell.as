package com.ankamagames.dofus.network.types.game.paddock
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockInformationsForSell extends Object implements INetworkType
    {
        public var guildOwner:String = "";
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var subAreaId:uint = 0;
        public var nbMount:int = 0;
        public var nbObject:int = 0;
        public var price:uint = 0;
        public static const protocolId:uint = 222;

        public function PaddockInformationsForSell()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 222;
        }// end function

        public function initPaddockInformationsForSell(param1:String = "", param2:int = 0, param3:int = 0, param4:uint = 0, param5:int = 0, param6:int = 0, param7:uint = 0) : PaddockInformationsForSell
        {
            this.guildOwner = param1;
            this.worldX = param2;
            this.worldY = param3;
            this.subAreaId = param4;
            this.nbMount = param5;
            this.nbObject = param6;
            this.price = param7;
            return this;
        }// end function

        public function reset() : void
        {
            this.guildOwner = "";
            this.worldX = 0;
            this.worldY = 0;
            this.subAreaId = 0;
            this.nbMount = 0;
            this.nbObject = 0;
            this.price = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PaddockInformationsForSell(param1);
            return;
        }// end function

        public function serializeAs_PaddockInformationsForSell(param1:IDataOutput) : void
        {
            param1.writeUTF(this.guildOwner);
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
            }
            param1.writeShort(this.worldX);
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
            }
            param1.writeShort(this.worldY);
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeShort(this.subAreaId);
            param1.writeByte(this.nbMount);
            param1.writeByte(this.nbObject);
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element price.");
            }
            param1.writeInt(this.price);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockInformationsForSell(param1);
            return;
        }// end function

        public function deserializeAs_PaddockInformationsForSell(param1:IDataInput) : void
        {
            this.guildOwner = param1.readUTF();
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of PaddockInformationsForSell.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of PaddockInformationsForSell.worldY.");
            }
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of PaddockInformationsForSell.subAreaId.");
            }
            this.nbMount = param1.readByte();
            this.nbObject = param1.readByte();
            this.price = param1.readInt();
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element of PaddockInformationsForSell.price.");
            }
            return;
        }// end function

    }
}
