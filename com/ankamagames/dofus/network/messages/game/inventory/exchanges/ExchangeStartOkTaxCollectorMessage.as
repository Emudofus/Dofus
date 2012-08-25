package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeStartOkTaxCollectorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var collectorId:int = 0;
        public var objectsInfos:Vector.<ObjectItem>;
        public var goldInfo:uint = 0;
        public static const protocolId:uint = 5780;

        public function ExchangeStartOkTaxCollectorMessage()
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
            return 5780;
        }// end function

        public function initExchangeStartOkTaxCollectorMessage(param1:int = 0, param2:Vector.<ObjectItem> = null, param3:uint = 0) : ExchangeStartOkTaxCollectorMessage
        {
            this.collectorId = param1;
            this.objectsInfos = param2;
            this.goldInfo = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.collectorId = 0;
            this.objectsInfos = new Vector.<ObjectItem>;
            this.goldInfo = 0;
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
            this.serializeAs_ExchangeStartOkTaxCollectorMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeStartOkTaxCollectorMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.collectorId);
            param1.writeShort(this.objectsInfos.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.objectsInfos.length)
            {
                
                (this.objectsInfos[_loc_2] as ObjectItem).serializeAs_ObjectItem(param1);
                _loc_2 = _loc_2 + 1;
            }
            if (this.goldInfo < 0)
            {
                throw new Error("Forbidden value (" + this.goldInfo + ") on element goldInfo.");
            }
            param1.writeInt(this.goldInfo);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeStartOkTaxCollectorMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeStartOkTaxCollectorMessage(param1:IDataInput) : void
        {
            var _loc_4:ObjectItem = null;
            this.collectorId = param1.readInt();
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new ObjectItem();
                _loc_4.deserialize(param1);
                this.objectsInfos.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            this.goldInfo = param1.readInt();
            if (this.goldInfo < 0)
            {
                throw new Error("Forbidden value (" + this.goldInfo + ") on element of ExchangeStartOkTaxCollectorMessage.goldInfo.");
            }
            return;
        }// end function

    }
}
