package com.ankamagames.dofus.network.types.game.data.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectItemToSellInHumanVendorShop extends Item implements INetworkType
    {
        public var objectGID:uint = 0;
        public var powerRate:int = 0;
        public var overMax:Boolean = false;
        public var effects:Vector.<ObjectEffect>;
        public var objectUID:uint = 0;
        public var quantity:uint = 0;
        public var objectPrice:uint = 0;
        public var publicPrice:uint = 0;
        public static const protocolId:uint = 359;

        public function ObjectItemToSellInHumanVendorShop()
        {
            this.effects = new Vector.<ObjectEffect>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 359;
        }// end function

        public function initObjectItemToSellInHumanVendorShop(param1:uint = 0, param2:int = 0, param3:Boolean = false, param4:Vector.<ObjectEffect> = null, param5:uint = 0, param6:uint = 0, param7:uint = 0, param8:uint = 0) : ObjectItemToSellInHumanVendorShop
        {
            this.objectGID = param1;
            this.powerRate = param2;
            this.overMax = param3;
            this.effects = param4;
            this.objectUID = param5;
            this.quantity = param6;
            this.objectPrice = param7;
            this.publicPrice = param8;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectGID = 0;
            this.powerRate = 0;
            this.overMax = false;
            this.effects = new Vector.<ObjectEffect>;
            this.objectUID = 0;
            this.quantity = 0;
            this.objectPrice = 0;
            this.publicPrice = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectItemToSellInHumanVendorShop(param1);
            return;
        }// end function

        public function serializeAs_ObjectItemToSellInHumanVendorShop(param1:IDataOutput) : void
        {
            super.serializeAs_Item(param1);
            if (this.objectGID < 0)
            {
                throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
            }
            param1.writeShort(this.objectGID);
            param1.writeShort(this.powerRate);
            param1.writeBoolean(this.overMax);
            param1.writeShort(this.effects.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.effects.length)
            {
                
                param1.writeShort((this.effects[_loc_2] as ObjectEffect).getTypeId());
                (this.effects[_loc_2] as ObjectEffect).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
            }
            param1.writeInt(this.objectUID);
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
            }
            param1.writeInt(this.quantity);
            if (this.objectPrice < 0)
            {
                throw new Error("Forbidden value (" + this.objectPrice + ") on element objectPrice.");
            }
            param1.writeInt(this.objectPrice);
            if (this.publicPrice < 0)
            {
                throw new Error("Forbidden value (" + this.publicPrice + ") on element publicPrice.");
            }
            param1.writeInt(this.publicPrice);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectItemToSellInHumanVendorShop(param1);
            return;
        }// end function

        public function deserializeAs_ObjectItemToSellInHumanVendorShop(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            super.deserialize(param1);
            this.objectGID = param1.readShort();
            if (this.objectGID < 0)
            {
                throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemToSellInHumanVendorShop.objectGID.");
            }
            this.powerRate = param1.readShort();
            this.overMax = param1.readBoolean();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(ObjectEffect, _loc_4);
                _loc_5.deserialize(param1);
                this.effects.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            this.objectUID = param1.readInt();
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItemToSellInHumanVendorShop.objectUID.");
            }
            this.quantity = param1.readInt();
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemToSellInHumanVendorShop.quantity.");
            }
            this.objectPrice = param1.readInt();
            if (this.objectPrice < 0)
            {
                throw new Error("Forbidden value (" + this.objectPrice + ") on element of ObjectItemToSellInHumanVendorShop.objectPrice.");
            }
            this.publicPrice = param1.readInt();
            if (this.publicPrice < 0)
            {
                throw new Error("Forbidden value (" + this.publicPrice + ") on element of ObjectItemToSellInHumanVendorShop.publicPrice.");
            }
            return;
        }// end function

    }
}
