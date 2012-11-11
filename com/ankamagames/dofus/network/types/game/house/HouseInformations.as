package com.ankamagames.dofus.network.types.game.house
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import com.ankamagames.jerakine.network.utils.*;
    import flash.utils.*;

    public class HouseInformations extends Object implements INetworkType
    {
        public var houseId:uint = 0;
        public var doorsOnMap:Vector.<uint>;
        public var ownerName:String = "";
        public var isOnSale:Boolean = false;
        public var isSaleLocked:Boolean = false;
        public var modelId:uint = 0;
        public static const protocolId:uint = 111;

        public function HouseInformations()
        {
            this.doorsOnMap = new Vector.<uint>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 111;
        }// end function

        public function initHouseInformations(param1:uint = 0, param2:Vector.<uint> = null, param3:String = "", param4:Boolean = false, param5:Boolean = false, param6:uint = 0) : HouseInformations
        {
            this.houseId = param1;
            this.doorsOnMap = param2;
            this.ownerName = param3;
            this.isOnSale = param4;
            this.isSaleLocked = param5;
            this.modelId = param6;
            return this;
        }// end function

        public function reset() : void
        {
            this.houseId = 0;
            this.doorsOnMap = new Vector.<uint>;
            this.ownerName = "";
            this.isOnSale = false;
            this.isSaleLocked = false;
            this.modelId = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_HouseInformations(param1);
            return;
        }// end function

        public function serializeAs_HouseInformations(param1:IDataOutput) : void
        {
            var _loc_2:* = 0;
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 0, this.isOnSale);
            _loc_2 = BooleanByteWrapper.setFlag(_loc_2, 1, this.isSaleLocked);
            param1.writeByte(_loc_2);
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
            }
            param1.writeInt(this.houseId);
            param1.writeShort(this.doorsOnMap.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.doorsOnMap.length)
            {
                
                if (this.doorsOnMap[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.doorsOnMap[_loc_3] + ") on element 2 (starting at 1) of doorsOnMap.");
                }
                param1.writeInt(this.doorsOnMap[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeUTF(this.ownerName);
            if (this.modelId < 0)
            {
                throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
            }
            param1.writeShort(this.modelId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_HouseInformations(param1);
            return;
        }// end function

        public function deserializeAs_HouseInformations(param1:IDataInput) : void
        {
            var _loc_5:* = 0;
            var _loc_2:* = param1.readByte();
            this.isOnSale = BooleanByteWrapper.getFlag(_loc_2, 0);
            this.isSaleLocked = BooleanByteWrapper.getFlag(_loc_2, 1);
            this.houseId = param1.readInt();
            if (this.houseId < 0)
            {
                throw new Error("Forbidden value (" + this.houseId + ") on element of HouseInformations.houseId.");
            }
            var _loc_3:* = param1.readUnsignedShort();
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3)
            {
                
                _loc_5 = param1.readInt();
                if (_loc_5 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_5 + ") on elements of doorsOnMap.");
                }
                this.doorsOnMap.push(_loc_5);
                _loc_4 = _loc_4 + 1;
            }
            this.ownerName = param1.readUTF();
            this.modelId = param1.readShort();
            if (this.modelId < 0)
            {
                throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformations.modelId.");
            }
            return;
        }// end function

    }
}
