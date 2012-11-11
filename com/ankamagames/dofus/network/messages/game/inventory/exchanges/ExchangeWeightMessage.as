package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeWeightMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var currentWeight:uint = 0;
        public var maxWeight:uint = 0;
        public static const protocolId:uint = 5793;

        public function ExchangeWeightMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5793;
        }// end function

        public function initExchangeWeightMessage(param1:uint = 0, param2:uint = 0) : ExchangeWeightMessage
        {
            this.currentWeight = param1;
            this.maxWeight = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.currentWeight = 0;
            this.maxWeight = 0;
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
            this.serializeAs_ExchangeWeightMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeWeightMessage(param1:IDataOutput) : void
        {
            if (this.currentWeight < 0)
            {
                throw new Error("Forbidden value (" + this.currentWeight + ") on element currentWeight.");
            }
            param1.writeInt(this.currentWeight);
            if (this.maxWeight < 0)
            {
                throw new Error("Forbidden value (" + this.maxWeight + ") on element maxWeight.");
            }
            param1.writeInt(this.maxWeight);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeWeightMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeWeightMessage(param1:IDataInput) : void
        {
            this.currentWeight = param1.readInt();
            if (this.currentWeight < 0)
            {
                throw new Error("Forbidden value (" + this.currentWeight + ") on element of ExchangeWeightMessage.currentWeight.");
            }
            this.maxWeight = param1.readInt();
            if (this.maxWeight < 0)
            {
                throw new Error("Forbidden value (" + this.maxWeight + ") on element of ExchangeWeightMessage.maxWeight.");
            }
            return;
        }// end function

    }
}
