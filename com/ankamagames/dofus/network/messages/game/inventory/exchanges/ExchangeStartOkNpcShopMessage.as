package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeStartOkNpcShopMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var npcSellerId:int = 0;
        public var tokenId:uint = 0;
        public var objectsInfos:Vector.<ObjectItemToSellInNpcShop>;
        public static const protocolId:uint = 5761;

        public function ExchangeStartOkNpcShopMessage()
        {
            this.objectsInfos = new Vector.<ObjectItemToSellInNpcShop>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5761;
        }// end function

        public function initExchangeStartOkNpcShopMessage(param1:int = 0, param2:uint = 0, param3:Vector.<ObjectItemToSellInNpcShop> = null) : ExchangeStartOkNpcShopMessage
        {
            this.npcSellerId = param1;
            this.tokenId = param2;
            this.objectsInfos = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.npcSellerId = 0;
            this.tokenId = 0;
            this.objectsInfos = new Vector.<ObjectItemToSellInNpcShop>;
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
            this.serializeAs_ExchangeStartOkNpcShopMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeStartOkNpcShopMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.npcSellerId);
            if (this.tokenId < 0)
            {
                throw new Error("Forbidden value (" + this.tokenId + ") on element tokenId.");
            }
            param1.writeInt(this.tokenId);
            param1.writeShort(this.objectsInfos.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.objectsInfos.length)
            {
                
                (this.objectsInfos[_loc_2] as ObjectItemToSellInNpcShop).serializeAs_ObjectItemToSellInNpcShop(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeStartOkNpcShopMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeStartOkNpcShopMessage(param1:IDataInput) : void
        {
            var _loc_4:ObjectItemToSellInNpcShop = null;
            this.npcSellerId = param1.readInt();
            this.tokenId = param1.readInt();
            if (this.tokenId < 0)
            {
                throw new Error("Forbidden value (" + this.tokenId + ") on element of ExchangeStartOkNpcShopMessage.tokenId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItemToSellInNpcShop();
                _loc_4.deserialize(param1);
                this.objectsInfos.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
