package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeStartedWithPodsMessage extends ExchangeStartedMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var firstCharacterId:int = 0;
        public var firstCharacterCurrentWeight:uint = 0;
        public var firstCharacterMaxWeight:uint = 0;
        public var secondCharacterId:int = 0;
        public var secondCharacterCurrentWeight:uint = 0;
        public var secondCharacterMaxWeight:uint = 0;
        public static const protocolId:uint = 6129;

        public function ExchangeStartedWithPodsMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6129;
        }// end function

        public function initExchangeStartedWithPodsMessage(param1:int = 0, param2:int = 0, param3:uint = 0, param4:uint = 0, param5:int = 0, param6:uint = 0, param7:uint = 0) : ExchangeStartedWithPodsMessage
        {
            super.initExchangeStartedMessage(param1);
            this.firstCharacterId = param2;
            this.firstCharacterCurrentWeight = param3;
            this.firstCharacterMaxWeight = param4;
            this.secondCharacterId = param5;
            this.secondCharacterCurrentWeight = param6;
            this.secondCharacterMaxWeight = param7;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.firstCharacterId = 0;
            this.firstCharacterCurrentWeight = 0;
            this.firstCharacterMaxWeight = 0;
            this.secondCharacterId = 0;
            this.secondCharacterCurrentWeight = 0;
            this.secondCharacterMaxWeight = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ExchangeStartedWithPodsMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeStartedWithPodsMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeStartedMessage(param1);
            param1.writeInt(this.firstCharacterId);
            if (this.firstCharacterCurrentWeight < 0)
            {
                throw new Error("Forbidden value (" + this.firstCharacterCurrentWeight + ") on element firstCharacterCurrentWeight.");
            }
            param1.writeInt(this.firstCharacterCurrentWeight);
            if (this.firstCharacterMaxWeight < 0)
            {
                throw new Error("Forbidden value (" + this.firstCharacterMaxWeight + ") on element firstCharacterMaxWeight.");
            }
            param1.writeInt(this.firstCharacterMaxWeight);
            param1.writeInt(this.secondCharacterId);
            if (this.secondCharacterCurrentWeight < 0)
            {
                throw new Error("Forbidden value (" + this.secondCharacterCurrentWeight + ") on element secondCharacterCurrentWeight.");
            }
            param1.writeInt(this.secondCharacterCurrentWeight);
            if (this.secondCharacterMaxWeight < 0)
            {
                throw new Error("Forbidden value (" + this.secondCharacterMaxWeight + ") on element secondCharacterMaxWeight.");
            }
            param1.writeInt(this.secondCharacterMaxWeight);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeStartedWithPodsMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeStartedWithPodsMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.firstCharacterId = param1.readInt();
            this.firstCharacterCurrentWeight = param1.readInt();
            if (this.firstCharacterCurrentWeight < 0)
            {
                throw new Error("Forbidden value (" + this.firstCharacterCurrentWeight + ") on element of ExchangeStartedWithPodsMessage.firstCharacterCurrentWeight.");
            }
            this.firstCharacterMaxWeight = param1.readInt();
            if (this.firstCharacterMaxWeight < 0)
            {
                throw new Error("Forbidden value (" + this.firstCharacterMaxWeight + ") on element of ExchangeStartedWithPodsMessage.firstCharacterMaxWeight.");
            }
            this.secondCharacterId = param1.readInt();
            this.secondCharacterCurrentWeight = param1.readInt();
            if (this.secondCharacterCurrentWeight < 0)
            {
                throw new Error("Forbidden value (" + this.secondCharacterCurrentWeight + ") on element of ExchangeStartedWithPodsMessage.secondCharacterCurrentWeight.");
            }
            this.secondCharacterMaxWeight = param1.readInt();
            if (this.secondCharacterMaxWeight < 0)
            {
                throw new Error("Forbidden value (" + this.secondCharacterMaxWeight + ") on element of ExchangeStartedWithPodsMessage.secondCharacterMaxWeight.");
            }
            return;
        }// end function

    }
}
