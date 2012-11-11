package com.ankamagames.dofus.network.types.game.guild.tax
{
    import com.ankamagames.dofus.network.types.game.look.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorInformations extends Object implements INetworkType
    {
        public var uniqueId:int = 0;
        public var firtNameId:uint = 0;
        public var lastNameId:uint = 0;
        public var additionalInfos:AdditionalTaxCollectorInformations;
        public var worldX:int = 0;
        public var worldY:int = 0;
        public var subAreaId:uint = 0;
        public var state:int = 0;
        public var look:EntityLook;
        public var kamas:uint = 0;
        public var experience:Number = 0;
        public var pods:uint = 0;
        public var itemsValue:uint = 0;
        public static const protocolId:uint = 167;

        public function TaxCollectorInformations()
        {
            this.additionalInfos = new AdditionalTaxCollectorInformations();
            this.look = new EntityLook();
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 167;
        }// end function

        public function initTaxCollectorInformations(param1:int = 0, param2:uint = 0, param3:uint = 0, param4:AdditionalTaxCollectorInformations = null, param5:int = 0, param6:int = 0, param7:uint = 0, param8:int = 0, param9:EntityLook = null, param10:uint = 0, param11:Number = 0, param12:uint = 0, param13:uint = 0) : TaxCollectorInformations
        {
            this.uniqueId = param1;
            this.firtNameId = param2;
            this.lastNameId = param3;
            this.additionalInfos = param4;
            this.worldX = param5;
            this.worldY = param6;
            this.subAreaId = param7;
            this.state = param8;
            this.look = param9;
            this.kamas = param10;
            this.experience = param11;
            this.pods = param12;
            this.itemsValue = param13;
            return this;
        }// end function

        public function reset() : void
        {
            this.uniqueId = 0;
            this.firtNameId = 0;
            this.lastNameId = 0;
            this.additionalInfos = new AdditionalTaxCollectorInformations();
            this.worldY = 0;
            this.subAreaId = 0;
            this.state = 0;
            this.look = new EntityLook();
            this.experience = 0;
            this.pods = 0;
            this.itemsValue = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_TaxCollectorInformations(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorInformations(param1:IDataOutput) : void
        {
            param1.writeInt(this.uniqueId);
            if (this.firtNameId < 0)
            {
                throw new Error("Forbidden value (" + this.firtNameId + ") on element firtNameId.");
            }
            param1.writeShort(this.firtNameId);
            if (this.lastNameId < 0)
            {
                throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
            }
            param1.writeShort(this.lastNameId);
            this.additionalInfos.serializeAs_AdditionalTaxCollectorInformations(param1);
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
            param1.writeByte(this.state);
            this.look.serializeAs_EntityLook(param1);
            if (this.kamas < 0)
            {
                throw new Error("Forbidden value (" + this.kamas + ") on element kamas.");
            }
            param1.writeInt(this.kamas);
            if (this.experience < 0)
            {
                throw new Error("Forbidden value (" + this.experience + ") on element experience.");
            }
            param1.writeDouble(this.experience);
            if (this.pods < 0)
            {
                throw new Error("Forbidden value (" + this.pods + ") on element pods.");
            }
            param1.writeInt(this.pods);
            if (this.itemsValue < 0)
            {
                throw new Error("Forbidden value (" + this.itemsValue + ") on element itemsValue.");
            }
            param1.writeInt(this.itemsValue);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorInformations(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorInformations(param1:IDataInput) : void
        {
            this.uniqueId = param1.readInt();
            this.firtNameId = param1.readShort();
            if (this.firtNameId < 0)
            {
                throw new Error("Forbidden value (" + this.firtNameId + ") on element of TaxCollectorInformations.firtNameId.");
            }
            this.lastNameId = param1.readShort();
            if (this.lastNameId < 0)
            {
                throw new Error("Forbidden value (" + this.lastNameId + ") on element of TaxCollectorInformations.lastNameId.");
            }
            this.additionalInfos = new AdditionalTaxCollectorInformations();
            this.additionalInfos.deserialize(param1);
            this.worldX = param1.readShort();
            if (this.worldX < -255 || this.worldX > 255)
            {
                throw new Error("Forbidden value (" + this.worldX + ") on element of TaxCollectorInformations.worldX.");
            }
            this.worldY = param1.readShort();
            if (this.worldY < -255 || this.worldY > 255)
            {
                throw new Error("Forbidden value (" + this.worldY + ") on element of TaxCollectorInformations.worldY.");
            }
            this.subAreaId = param1.readShort();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of TaxCollectorInformations.subAreaId.");
            }
            this.state = param1.readByte();
            this.look = new EntityLook();
            this.look.deserialize(param1);
            this.kamas = param1.readInt();
            if (this.kamas < 0)
            {
                throw new Error("Forbidden value (" + this.kamas + ") on element of TaxCollectorInformations.kamas.");
            }
            this.experience = param1.readDouble();
            if (this.experience < 0)
            {
                throw new Error("Forbidden value (" + this.experience + ") on element of TaxCollectorInformations.experience.");
            }
            this.pods = param1.readInt();
            if (this.pods < 0)
            {
                throw new Error("Forbidden value (" + this.pods + ") on element of TaxCollectorInformations.pods.");
            }
            this.itemsValue = param1.readInt();
            if (this.itemsValue < 0)
            {
                throw new Error("Forbidden value (" + this.itemsValue + ") on element of TaxCollectorInformations.itemsValue.");
            }
            return;
        }// end function

    }
}
