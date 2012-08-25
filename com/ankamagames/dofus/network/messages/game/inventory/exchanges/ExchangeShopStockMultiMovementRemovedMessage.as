package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeShopStockMultiMovementRemovedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectIdList:Vector.<uint>;
        public static const protocolId:uint = 6037;

        public function ExchangeShopStockMultiMovementRemovedMessage()
        {
            this.objectIdList = new Vector.<uint>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6037;
        }// end function

        public function initExchangeShopStockMultiMovementRemovedMessage(param1:Vector.<uint> = null) : ExchangeShopStockMultiMovementRemovedMessage
        {
            this.objectIdList = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectIdList = new Vector.<uint>;
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
            this.serializeAs_ExchangeShopStockMultiMovementRemovedMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeShopStockMultiMovementRemovedMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.objectIdList.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.objectIdList.length)
            {
                
                if (this.objectIdList[_loc_2] < 0)
                {
                    throw new Error("Forbidden value (" + this.objectIdList[_loc_2] + ") on element 1 (starting at 1) of objectIdList.");
                }
                param1.writeInt(this.objectIdList[_loc_2]);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeShopStockMultiMovementRemovedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeShopStockMultiMovementRemovedMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readInt();
                if (_loc_4 < 0)
                {
                    throw new Error("Forbidden value (" + _loc_4 + ") on elements of objectIdList.");
                }
                this.objectIdList.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
