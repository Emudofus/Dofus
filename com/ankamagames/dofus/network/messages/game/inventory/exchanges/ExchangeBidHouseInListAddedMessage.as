package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.data.items.effects.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeBidHouseInListAddedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var itemUID:int = 0;
        public var objGenericId:int = 0;
        public var powerRate:int = 0;
        public var overMax:Boolean = false;
        public var effects:Vector.<ObjectEffect>;
        public var prices:Vector.<uint>;
        public static const protocolId:uint = 5949;

        public function ExchangeBidHouseInListAddedMessage()
        {
            this.effects = new Vector.<ObjectEffect>;
            this.prices = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5949;
        }// end function

        public function initExchangeBidHouseInListAddedMessage(param1:int = 0, param2:int = 0, param3:int = 0, param4:Boolean = false, param5:Vector.<ObjectEffect> = null, param6:Vector.<uint> = null) : ExchangeBidHouseInListAddedMessage
        {
            this.itemUID = param1;
            this.objGenericId = param2;
            this.powerRate = param3;
            this.overMax = param4;
            this.effects = param5;
            this.prices = param6;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.itemUID = 0;
            this.objGenericId = 0;
            this.powerRate = 0;
            this.overMax = false;
            this.effects = new Vector.<ObjectEffect>;
            this.prices = new Vector.<uint>;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ExchangeBidHouseInListAddedMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeBidHouseInListAddedMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.itemUID);
            param1.writeInt(this.objGenericId);
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
                    throw new Error("Forbidden value (" + this.prices[_loc_3] + ") on element 6 (starting at 1) of prices.");
                }
                param1.writeInt(this.prices[_loc_3]);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeBidHouseInListAddedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeBidHouseInListAddedMessage(param1:IDataInput) : void
        {
            var _loc_6:uint = 0;
            var _loc_7:ObjectEffect = null;
            var _loc_8:uint = 0;
            this.itemUID = param1.readInt();
            this.objGenericId = param1.readInt();
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
