package com.ankamagames.dofus.network.types.game.data.items
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class ObjectItemNotInContainer extends Item implements INetworkType 
    {

        public static const protocolId:uint = 134;

        public var objectGID:uint = 0;
        public var effects:Vector.<ObjectEffect>;
        public var objectUID:uint = 0;
        public var quantity:uint = 0;

        public function ObjectItemNotInContainer()
        {
            this.effects = new Vector.<ObjectEffect>();
            super();
        }

        override public function getTypeId():uint
        {
            return (134);
        }

        public function initObjectItemNotInContainer(objectGID:uint=0, effects:Vector.<ObjectEffect>=null, objectUID:uint=0, quantity:uint=0):ObjectItemNotInContainer
        {
            this.objectGID = objectGID;
            this.effects = effects;
            this.objectUID = objectUID;
            this.quantity = quantity;
            return (this);
        }

        override public function reset():void
        {
            this.objectGID = 0;
            this.effects = new Vector.<ObjectEffect>();
            this.objectUID = 0;
            this.quantity = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ObjectItemNotInContainer(output);
        }

        public function serializeAs_ObjectItemNotInContainer(output:ICustomDataOutput):void
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
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ObjectItemNotInContainer(input);
        }

        public function deserializeAs_ObjectItemNotInContainer(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:ObjectEffect;
            super.deserialize(input);
            this.objectGID = input.readVarUhShort();
            if (this.objectGID < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectGID) + ") on element of ObjectItemNotInContainer.objectGID.")));
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
                throw (new Error((("Forbidden value (" + this.objectUID) + ") on element of ObjectItemNotInContainer.objectUID.")));
            };
            this.quantity = input.readVarUhInt();
            if (this.quantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.quantity) + ") on element of ObjectItemNotInContainer.quantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.data.items

