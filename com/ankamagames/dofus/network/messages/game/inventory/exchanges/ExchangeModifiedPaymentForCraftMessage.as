package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeModifiedPaymentForCraftMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var onlySuccess:Boolean = false;
        public var object:ObjectItemNotInContainer;
        public static const protocolId:uint = 5832;

        public function ExchangeModifiedPaymentForCraftMessage()
        {
            this.object = new ObjectItemNotInContainer();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5832;
        }// end function

        public function initExchangeModifiedPaymentForCraftMessage(param1:Boolean = false, param2:ObjectItemNotInContainer = null) : ExchangeModifiedPaymentForCraftMessage
        {
            this.onlySuccess = param1;
            this.object = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.onlySuccess = false;
            this.object = new ObjectItemNotInContainer();
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
            this.serializeAs_ExchangeModifiedPaymentForCraftMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeModifiedPaymentForCraftMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.onlySuccess);
            this.object.serializeAs_ObjectItemNotInContainer(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeModifiedPaymentForCraftMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeModifiedPaymentForCraftMessage(param1:IDataInput) : void
        {
            this.onlySuccess = param1.readBoolean();
            this.object = new ObjectItemNotInContainer();
            this.object.deserialize(param1);
            return;
        }// end function

    }
}
