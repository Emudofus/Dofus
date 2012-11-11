package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeRemovedPaymentForCraftMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var onlySuccess:Boolean = false;
        public var objectUID:uint = 0;
        public static const protocolId:uint = 6031;

        public function ExchangeRemovedPaymentForCraftMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6031;
        }// end function

        public function initExchangeRemovedPaymentForCraftMessage(param1:Boolean = false, param2:uint = 0) : ExchangeRemovedPaymentForCraftMessage
        {
            this.onlySuccess = param1;
            this.objectUID = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.onlySuccess = false;
            this.objectUID = 0;
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
            this.serializeAs_ExchangeRemovedPaymentForCraftMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeRemovedPaymentForCraftMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.onlySuccess);
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
            }
            param1.writeInt(this.objectUID);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeRemovedPaymentForCraftMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeRemovedPaymentForCraftMessage(param1:IDataInput) : void
        {
            this.onlySuccess = param1.readBoolean();
            this.objectUID = param1.readInt();
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element of ExchangeRemovedPaymentForCraftMessage.objectUID.");
            }
            return;
        }// end function

    }
}
