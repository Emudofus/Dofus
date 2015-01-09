package com.ankamagames.dofus.network.types.game.house
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    public class HouseInformations implements INetworkType 
    {

        public static const protocolId:uint = 111;

        public var houseId:uint = 0;
        public var doorsOnMap:Vector.<uint>;
        public var ownerName:String = "";
        public var isOnSale:Boolean = false;
        public var isSaleLocked:Boolean = false;
        public var modelId:uint = 0;

        public function HouseInformations()
        {
            this.doorsOnMap = new Vector.<uint>();
            super();
        }

        public function getTypeId():uint
        {
            return (111);
        }

        public function initHouseInformations(houseId:uint=0, doorsOnMap:Vector.<uint>=null, ownerName:String="", isOnSale:Boolean=false, isSaleLocked:Boolean=false, modelId:uint=0):HouseInformations
        {
            this.houseId = houseId;
            this.doorsOnMap = doorsOnMap;
            this.ownerName = ownerName;
            this.isOnSale = isOnSale;
            this.isSaleLocked = isSaleLocked;
            this.modelId = modelId;
            return (this);
        }

        public function reset():void
        {
            this.houseId = 0;
            this.doorsOnMap = new Vector.<uint>();
            this.ownerName = "";
            this.isOnSale = false;
            this.isSaleLocked = false;
            this.modelId = 0;
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_HouseInformations(output);
        }

        public function serializeAs_HouseInformations(output:ICustomDataOutput):void
        {
            var _box0:uint;
            _box0 = BooleanByteWrapper.setFlag(_box0, 0, this.isOnSale);
            _box0 = BooleanByteWrapper.setFlag(_box0, 1, this.isSaleLocked);
            output.writeByte(_box0);
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element houseId.")));
            };
            output.writeInt(this.houseId);
            output.writeShort(this.doorsOnMap.length);
            var _i2:uint;
            while (_i2 < this.doorsOnMap.length)
            {
                if (this.doorsOnMap[_i2] < 0)
                {
                    throw (new Error((("Forbidden value (" + this.doorsOnMap[_i2]) + ") on element 2 (starting at 1) of doorsOnMap.")));
                };
                output.writeInt(this.doorsOnMap[_i2]);
                _i2++;
            };
            output.writeUTF(this.ownerName);
            if (this.modelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.modelId) + ") on element modelId.")));
            };
            output.writeVarShort(this.modelId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_HouseInformations(input);
        }

        public function deserializeAs_HouseInformations(input:ICustomDataInput):void
        {
            var _val2:uint;
            var _box0:uint = input.readByte();
            this.isOnSale = BooleanByteWrapper.getFlag(_box0, 0);
            this.isSaleLocked = BooleanByteWrapper.getFlag(_box0, 1);
            this.houseId = input.readInt();
            if (this.houseId < 0)
            {
                throw (new Error((("Forbidden value (" + this.houseId) + ") on element of HouseInformations.houseId.")));
            };
            var _doorsOnMapLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _doorsOnMapLen)
            {
                _val2 = input.readInt();
                if (_val2 < 0)
                {
                    throw (new Error((("Forbidden value (" + _val2) + ") on elements of doorsOnMap.")));
                };
                this.doorsOnMap.push(_val2);
                _i2++;
            };
            this.ownerName = input.readUTF();
            this.modelId = input.readVarUhShort();
            if (this.modelId < 0)
            {
                throw (new Error((("Forbidden value (" + this.modelId) + ") on element of HouseInformations.modelId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.house

