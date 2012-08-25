package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeStartedMountStockMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectsInfos:Vector.<ObjectItem>;
        public static const protocolId:uint = 5984;

        public function ExchangeStartedMountStockMessage()
        {
            this.objectsInfos = new Vector.<ObjectItem>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5984;
        }// end function

        public function initExchangeStartedMountStockMessage(param1:Vector.<ObjectItem> = null) : ExchangeStartedMountStockMessage
        {
            this.objectsInfos = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectsInfos = new Vector.<ObjectItem>;
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
            this.serializeAs_ExchangeStartedMountStockMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeStartedMountStockMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.objectsInfos.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.objectsInfos.length)
            {
                
                (this.objectsInfos[_loc_2] as ObjectItem).serializeAs_ObjectItem(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeStartedMountStockMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeStartedMountStockMessage(param1:IDataInput) : void
        {
            var _loc_4:ObjectItem = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItem();
                _loc_4.deserialize(param1);
                this.objectsInfos.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
