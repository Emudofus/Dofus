package com.ankamagames.dofus.network.types.game.data.items
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class BidExchangerObjectInfo extends Object implements INetworkType
    {
        public var objectUID:uint = 0;
        public var powerRate:int = 0;
        public var overMax:Boolean = false;
        public var effects:Vector.<ObjectEffect>;
        public var prices:Vector.<uint>;
        public static const protocolId:uint = 122;

        public function BidExchangerObjectInfo()
        {
            this.effects = new Vector.<ObjectEffect>;
            this.prices = new Vector.<uint>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 122;
        }// end function

        public function initBidExchangerObjectInfo(param1:uint = 0, param2:int = 0, param3:Boolean = false, param4:Vector.<ObjectEffect> = null, param5:Vector.<uint> = null) : BidExchangerObjectInfo
        {
            this.objectUID = param1;
            this.powerRate = param2;
            this.overMax = param3;
            this.effects = param4;
            this.prices = param5;
            return this;
        }// end function

        public function reset() : void
        {
            this.objectUID = 0;
            this.powerRate = 0;
            this.overMax = false;
            this.effects = new Vector.<ObjectEffect>;
            this.prices = new Vector.<uint>;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_BidExchangerObjectInfo(param1);
            return;
        }// end function

        public function serializeAs_BidExchangerObjectInfo(param1:IDataOutput) : void
        {
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
            }
            param1.writeInt(this.objectUID);
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
            param1.writeShort(this.prices.length);
            var _loc_3:uint = 0;
            while (_loc_3 < this.prices.length)
            {
                
                if (this.prices[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.prices[_loc_3] + ") on element 5 (starting at 1) of prices.");
                }
                param1.writeInt(this.prices[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_BidExchangerObjectInfo(param1);
            return;
        }// end function

        public function deserializeAs_BidExchangerObjectInfo(param1:IDataInput) : void
        {
            var _loc_6:uint = 0;
            var _loc_7:ObjectEffect = null;
            var _loc_8:uint = 0;
            this.objectUID = param1.readInt();
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element of BidExchangerObjectInfo.objectUID.");
            }
            this.powerRate = param1.readShort();
            this.overMax = param1.readBoolean();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readUnsignedShort();
                _loc_7 = ProtocolTypeManager.getInstance(ObjectEffect, _loc_6);
                _loc_7.deserialize(param1);
                this.effects.push(_loc_7);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:uint = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_8 = param1.readInt();
                if (_loc_8 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_8 + ") on elements of prices.");
                }
                this.prices.push(_loc_8);
                _loc_5 = _loc_5 + 1;
            }
            return;
        }// end function

    }
}
