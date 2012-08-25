package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeStartOkHumanVendorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var sellerId:uint = 0;
        public var objectsInfos:Vector.<ObjectItemToSellInHumanVendorShop>;
        public static const protocolId:uint = 5767;

        public function ExchangeStartOkHumanVendorMessage()
        {
            this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5767;
        }// end function

        public function initExchangeStartOkHumanVendorMessage(param1:uint = 0, param2:Vector.<ObjectItemToSellInHumanVendorShop> = null) : ExchangeStartOkHumanVendorMessage
        {
            this.sellerId = param1;
            this.objectsInfos = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.sellerId = 0;
            this.objectsInfos = new Vector.<ObjectItemToSellInHumanVendorShop>;
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
            this.serializeAs_ExchangeStartOkHumanVendorMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeStartOkHumanVendorMessage(param1:IDataOutput) : void
        {
            if (this.sellerId < 0)
            {
                throw new Error("Forbidden value (" + this.sellerId + ") on element sellerId.");
            }
            param1.writeInt(this.sellerId);
            param1.writeShort(this.objectsInfos.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.objectsInfos.length)
            {
                
                (this.objectsInfos[_loc_2] as ObjectItemToSellInHumanVendorShop).serializeAs_ObjectItemToSellInHumanVendorShop(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeStartOkHumanVendorMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeStartOkHumanVendorMessage(param1:IDataInput) : void
        {
            var _loc_4:ObjectItemToSellInHumanVendorShop = null;
            this.sellerId = param1.readInt();
            if (this.sellerId < 0)
            {
                throw new Error("Forbidden value (" + this.sellerId + ") on element of ExchangeStartOkHumanVendorMessage.sellerId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItemToSellInHumanVendorShop();
                _loc_4.deserialize(param1);
                this.objectsInfos.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
