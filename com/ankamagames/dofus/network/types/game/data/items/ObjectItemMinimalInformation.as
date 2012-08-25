package com.ankamagames.dofus.network.types.game.data.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ObjectItemMinimalInformation extends Item implements INetworkType
    {
        public var objectGID:uint = 0;
        public var powerRate:int = 0;
        public var overMax:Boolean = false;
        public var effects:Vector.<ObjectEffect>;
        public static const protocolId:uint = 124;

        public function ObjectItemMinimalInformation()
        {
            this.effects = new Vector.<ObjectEffect>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 124;
        }// end function

        public function initObjectItemMinimalInformation(param1:uint = 0, param2:int = 0, param3:Boolean = false, param4:Vector.<ObjectEffect> = null) : ObjectItemMinimalInformation
        {
            this.objectGID = param1;
            this.powerRate = param2;
            this.overMax = param3;
            this.effects = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectGID = 0;
            this.powerRate = 0;
            this.overMax = false;
            this.effects = new Vector.<ObjectEffect>;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ObjectItemMinimalInformation(param1);
            return;
        }// end function

        public function serializeAs_ObjectItemMinimalInformation(param1:IDataOutput) : void
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
            var _loc_2:uint = 0;
            while (_loc_2 < this.effects.length)
            {
                
                param1.writeShort((this.effects[_loc_2] as ObjectEffect).getTypeId());
                (this.effects[_loc_2] as ObjectEffect).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ObjectItemMinimalInformation(param1);
            return;
        }// end function

        public function deserializeAs_ObjectItemMinimalInformation(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:ObjectEffect = null;
            super.deserialize(param1);
            this.objectGID = param1.readShort();
            if (this.objectGID < 0)
            {
                throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemMinimalInformation.objectGID.");
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
            return;
        }// end function

    }
}
