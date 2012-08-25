package com.ankamagames.dofus.network.types.game.data.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectItem extends Item implements INetworkType
    {
        public var position:uint = 63;
        public var objectGID:uint = 0;
        public var powerRate:int = 0;
        public var overMax:Boolean = false;
        public var effects:Vector.<ObjectEffect>;
        public var objectUID:uint = 0;
        public var quantity:uint = 0;
        public static const protocolId:uint = 37;

        public function ObjectItem()
        {
            this.effects = new Vector.<ObjectEffect>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 37;
        }// end function

        public function initObjectItem(param1:uint = 63, param2:uint = 0, param3:int = 0, param4:Boolean = false, param5:Vector.<ObjectEffect> = null, param6:uint = 0, param7:uint = 0) : ObjectItem
        {
            this.position = param1;
            this.objectGID = param2;
            this.powerRate = param3;
            this.overMax = param4;
            this.effects = param5;
            this.objectUID = param6;
            this.quantity = param7;
            return this;
        }// end function

        override public function reset() : void
        {
            this.position = 63;
            this.objectGID = 0;
            this.powerRate = 0;
            this.overMax = false;
            this.effects = new Vector.<ObjectEffect>;
            this.objectUID = 0;
            this.quantity = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectItem(param1);
            return;
        }// end function

        public function serializeAs_ObjectItem(param1:IDataOutput) : void
        {
            super.serializeAs_Item(param1);
            param1.writeByte(this.position);
            if (this.objectGID < 0)
            {
                throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
            }
            param1.writeShort(this.objectGID);
            param1.writeShort(this.powerRate);
            param1.writeBoolean(this.overMax);
            param1.writeShort(this.effects.length);
            var _loc_2:uint = 0;
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
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectItem(param1);
            return;
        }// end function

        public function deserializeAs_ObjectItem(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:ObjectEffect = null;
            super.deserialize(param1);
            this.position = param1.readUnsignedByte();
            if (this.position < 0 || this.position > 255)
            {
                throw new Error("Forbidden value (" + this.position + ") on element of ObjectItem.position.");
            }
            this.objectGID = param1.readShort();
            if (this.objectGID < 0)
            {
                throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItem.objectGID.");
            }
            this.powerRate = param1.readShort();
            this.overMax = param1.readBoolean();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
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
                throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItem.objectUID.");
            }
            this.quantity = param1.readInt();
            if (this.quantity < 0)
            {
                throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItem.quantity.");
            }
            return;
        }// end function

    }
}
