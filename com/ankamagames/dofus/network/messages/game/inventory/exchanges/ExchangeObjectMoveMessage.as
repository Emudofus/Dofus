package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeObjectMoveMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;
        public var quantity:int = 0;
        public static const protocolId:uint = 5518;

        public function ExchangeObjectMoveMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5518;
        }// end function

        public function initExchangeObjectMoveMessage(param1:uint = 0, param2:int = 0) : ExchangeObjectMoveMessage
        {
            this.objectUID = param1;
            this.quantity = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.objectUID = 0;
            this.quantity = 0;
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
            this.serializeAs_ExchangeObjectMoveMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeObjectMoveMessage(param1:IDataOutput) : void
        {
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
            }
            param1.writeInt(this.objectUID);
            param1.writeInt(this.quantity);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeObjectMoveMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeObjectMoveMessage(param1:IDataInput) : void
        {
            this.objectUID = param1.readInt();
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element of ExchangeObjectMoveMessage.objectUID.");
            }
            this.quantity = param1.readInt();
            return;
        }// end function

    }
}
