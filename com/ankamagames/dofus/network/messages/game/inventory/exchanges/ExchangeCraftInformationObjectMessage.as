package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeCraftInformationObjectMessage extends ExchangeCraftResultWithObjectIdMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;
        public static const protocolId:uint = 5794;

        public function ExchangeCraftInformationObjectMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5794;
        }// end function

        public function initExchangeCraftInformationObjectMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ExchangeCraftInformationObjectMessage
        {
            super.initExchangeCraftResultWithObjectIdMessage(param1, param2);
            this.playerId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.playerId = 0;
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
            this.serializeAs_ExchangeCraftInformationObjectMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeCraftInformationObjectMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeCraftResultWithObjectIdMessage(param1);
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            param1.writeInt(this.playerId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeCraftInformationObjectMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeCraftInformationObjectMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.playerId = param1.readInt();
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element of ExchangeCraftInformationObjectMessage.playerId.");
            }
            return;
        }// end function

    }
}
