package com.ankamagames.dofus.network.types.game.prism
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismSubAreaInformation extends Object implements INetworkType
    {
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var mapId:int = 0;
        public var subAreaId:uint = 0;
        public var alignment:uint = 0;
        public var isInFight:Boolean = false;
        public var isFightable:Boolean = false;
        public static const protocolId:uint = 142;

        public function PrismSubAreaInformation()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 142;
        }// end function

        public function initPrismSubAreaInformation(param1:int = 0, param2:int = 0, param3:int = 0, param4:uint = 0, param5:uint = 0, param6:Boolean = false, param7:Boolean = false) : PrismSubAreaInformation
        {
            this.worldX = param1;
            this.worldY = param2;
            this.mapId = param3;
            this.subAreaId = param4;
            this.alignment = param5;
            this.isInFight = param6;
            this.isFightable = param7;
            return this;
        }// end function

        public function reset() : void
        {
            this.worldX = 0;
            this.worldY = 0;
            this.mapId = 0;
            this.subAreaId = 0;
            this.alignment = 0;
            this.isInFight = false;
            this.isFightable = false;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PrismSubAreaInformation(param1);
            return;
        }// end function

        public function serializeAs_PrismSubAreaInformation(param1:IDataOutput) : void
        {
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
            param1.writeInt(this.mapId);
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeShort(this.subAreaId);
            if (this.alignment < 0)
            {
                throw new Error("Forbidden value (" + this.alignment + ") on element alignment.");
            }
            param1.writeByte(this.alignment);
            param1.writeBoolean(this.isInFight);
            param1.writeBoolean(this.isFightable);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismSubAreaInformation(param1);
            return;
        }// end function

        public function deserializeAs_PrismSubAreaInformation(param1:IDataInput) : void
        {
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of PrismSubAreaInformation.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of PrismSubAreaInformation.worldY.");
            }
            this.mapId = param1.readInt();
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismSubAreaInformation.subAreaId.");
            }
            this.alignment = param1.readByte();
            if (this.alignment < 0)
            {
                throw new Error("Forbidden value (" + this.alignment + ") on element of PrismSubAreaInformation.alignment.");
            }
            this.isInFight = param1.readBoolean();
            this.isFightable = param1.readBoolean();
            return;
        }// end function

    }
}
