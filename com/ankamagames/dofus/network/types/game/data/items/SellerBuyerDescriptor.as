package com.ankamagames.dofus.network.types.game.data.items
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class SellerBuyerDescriptor extends Object implements INetworkType
    {
        public var quantities:Vector.<uint>;
        public var types:Vector.<uint>;
        public var taxPercentage:Number = 0;
        public var maxItemLevel:uint = 0;
        public var maxItemPerAccount:uint = 0;
        public var npcContextualId:int = 0;
        public var unsoldDelay:uint = 0;
        public static const protocolId:uint = 121;

        public function SellerBuyerDescriptor()
        {
            this.quantities = new Vector.<uint>;
            this.types = new Vector.<uint>;
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 121;
        }// end function

        public function initSellerBuyerDescriptor(param1:Vector.<uint> = null, param2:Vector.<uint> = null, param3:Number = 0, param4:uint = 0, param5:uint = 0, param6:int = 0, param7:uint = 0) : SellerBuyerDescriptor
        {
            this.quantities = param1;
            this.types = param2;
            this.taxPercentage = param3;
            this.maxItemLevel = param4;
            this.maxItemPerAccount = param5;
            this.npcContextualId = param6;
            this.unsoldDelay = param7;
            return this;
        }// end function

        public function reset() : void
        {
            this.quantities = new Vector.<uint>;
            this.types = new Vector.<uint>;
            this.taxPercentage = 0;
            this.maxItemLevel = 0;
            this.maxItemPerAccount = 0;
            this.npcContextualId = 0;
            this.unsoldDelay = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_SellerBuyerDescriptor(param1);
            return;
        }// end function

        public function serializeAs_SellerBuyerDescriptor(param1:IDataOutput) : void
        {
            param1.writeShort(this.quantities.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.quantities.length)
            {
                
                if (this.quantities[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.quantities[_loc_2] + ") on element 1 (starting at 1) of quantities.");
                }
                param1.writeInt(this.quantities[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            param1.writeShort(this.types.length);
            var _loc_3:* = 0;
            while (_loc_3 < this.types.length)
            {
                
                if (this.types[_loc_3] < 0)
                {
                    throw new Error("Forbidden value (" + this.types[_loc_3] + ") on element 2 (starting at 1) of types.");
                }
                param1.writeInt(this.types[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            param1.writeFloat(this.taxPercentage);
            if (this.maxItemLevel < 0)
            {
                throw new Error("Forbidden value (" + this.maxItemLevel + ") on element maxItemLevel.");
            }
            param1.writeInt(this.maxItemLevel);
            if (this.maxItemPerAccount < 0)
            {
                throw new Error("Forbidden value (" + this.maxItemPerAccount + ") on element maxItemPerAccount.");
            }
            param1.writeInt(this.maxItemPerAccount);
            param1.writeInt(this.npcContextualId);
            if (this.unsoldDelay < 0)
            {
                throw new Error("Forbidden value (" + this.unsoldDelay + ") on element unsoldDelay.");
            }
            param1.writeShort(this.unsoldDelay);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_SellerBuyerDescriptor(param1);
            return;
        }// end function

        public function deserializeAs_SellerBuyerDescriptor(param1:IDataInput) : void
        {
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_6 = param1.readInt();
                if (_loc_6 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_6 + ") on elements of quantities.");
                }
                this.quantities.push(_loc_6);
                _loc_3 = _loc_3 + 1;
            }
            var _loc_4:* = param1.readUnsignedShort();
            var _loc_5:* = 0;
            while (_loc_5 < _loc_4)
            {
                
                _loc_7 = param1.readInt();
                if (_loc_7 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_7 + ") on elements of types.");
                }
                this.types.push(_loc_7);
                _loc_5 = _loc_5 + 1;
            }
            this.taxPercentage = param1.readFloat();
            this.maxItemLevel = param1.readInt();
            if (this.maxItemLevel < 0)
            {
                throw new Error("Forbidden value (" + this.maxItemLevel + ") on element of SellerBuyerDescriptor.maxItemLevel.");
            }
            this.maxItemPerAccount = param1.readInt();
            if (this.maxItemPerAccount < 0)
            {
                throw new Error("Forbidden value (" + this.maxItemPerAccount + ") on element of SellerBuyerDescriptor.maxItemPerAccount.");
            }
            this.npcContextualId = param1.readInt();
            this.unsoldDelay = param1.readShort();
            if (this.unsoldDelay < 0)
            {
                throw new Error("Forbidden value (" + this.unsoldDelay + ") on element of SellerBuyerDescriptor.unsoldDelay.");
            }
            return;
        }// end function

    }
}
