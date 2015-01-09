package com.ankamagames.dofus.network.types.game.data.items
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class ObjectItemToSellInHumanVendorShop extends Item implements INetworkType 
    {

        public static const protocolId:uint = 359;

        public var objectGID:uint = 0;
        public var effects:Vector.<ObjectEffect>;
        public var objectUID:uint = 0;
        public var quantity:uint = 0;
        public var objectPrice:uint = 0;
        public var publicPrice:uint = 0;

        public function ObjectItemToSellInHumanVendorShop()
        {
            this.effects = new Vector.<ObjectEffect>();
            super();
        }

        override public function getTypeId():uint
        {
            return (359);
        }

        public function initObjectItemToSellInHumanVendorShop(objectGID:uint=0, effects:Vector.<ObjectEffect>=null, objectUID:uint=0, quantity:uint=0, objectPrice:uint=0, publicPrice:uint=0):ObjectItemToSellInHumanVendorShop
        {
            this.objectGID = objectGID;
            this.effects = effects;
            this.objectUID = objectUID;
            this.quantity = quantity;
            this.objectPrice = objectPrice;
            this.publicPrice = publicPrice;
            return (this);
        }

        override public function reset():void
        {
            this.objectGID = 0;
            this.effects = new Vector.<ObjectEffect>();
            this.objectUID = 0;
            this.quantity = 0;
            this.objectPrice = 0;
            this.publicPrice = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectItemToSellInHumanVendorShop(output);
        }

        public function serializeAs_ObjectItemToSellInHumanVendorShop(output:ICustomDataOutput):void
        {
            super.serializeAs_Item(output);
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element objectGID.")));
            };
            output.writeVarShort(this.objectGID);
            output.writeShort(this.effects.length);
            var _i2:uint;
            while (_i2 < this.effects.length)
            {
                output.writeShort((this.effects[_i2] as ObjectEffect).getTypeId());
                (this.effects[_i2] as ObjectEffect).serialize(output);
                _i2++;
            };
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element objectUID.")));
            };
            output.writeVarInt(this.objectUID);
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element quantity.")));
            };
            output.writeVarInt(this.quantity);
            if (this.objectPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectPrice) + ") on element objectPrice.")));
            };
            output.writeVarInt(this.objectPrice);
            if (this.publicPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.publicPrice) + ") on element publicPrice.")));
            };
            output.writeVarInt(this.publicPrice);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectItemToSellInHumanVendorShop(input);
        }

        public function deserializeAs_ObjectItemToSellInHumanVendorShop(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:ObjectEffect;
            super.deserialize(input);
            this.objectGID = input.readVarUhShort();
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element of ObjectItemToSellInHumanVendorShop.objectGID.")));
            };
            var _effectsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _effectsLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(ObjectEffect, _id2);
                _item2.deserialize(input);
                this.effects.push(_item2);
                _i2++;
            };
            this.objectUID = input.readVarUhInt();
            if (this.objectUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of ObjectItemToSellInHumanVendorShop.objectUID.")));
            };
            this.quantity = input.readVarUhInt();
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element of ObjectItemToSellInHumanVendorShop.quantity.")));
            };
            this.objectPrice = input.readVarUhInt();
            if (this.objectPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectPrice) + ") on element of ObjectItemToSellInHumanVendorShop.objectPrice.")));
            };
            this.publicPrice = input.readVarUhInt();
            if (this.publicPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.publicPrice) + ") on element of ObjectItemToSellInHumanVendorShop.publicPrice.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.data.items

