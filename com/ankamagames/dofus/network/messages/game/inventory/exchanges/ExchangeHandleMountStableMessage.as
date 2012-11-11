package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeHandleMountStableMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var actionType:int = 0;
        public var rideId:uint = 0;
        public static const protocolId:uint = 5965;

        public function ExchangeHandleMountStableMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5965;
        }// end function

        public function initExchangeHandleMountStableMessage(param1:int = 0, param2:uint = 0) : ExchangeHandleMountStableMessage
        {
            this.actionType = param1;
            this.rideId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.actionType = 0;
            this.rideId = 0;
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
            this.serializeAs_ExchangeHandleMountStableMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeHandleMountStableMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.actionType);
            if (this.rideId < 0)
            {
                throw new Error("Forbidden value (" + this.rideId + ") on element rideId.");
            }
            param1.writeInt(this.rideId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeHandleMountStableMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeHandleMountStableMessage(param1:IDataInput) : void
        {
            this.actionType = param1.readByte();
            this.rideId = param1.readInt();
            if (this.rideId < 0)
            {
                throw new Error("Forbidden value (" + this.rideId + ") on element of ExchangeHandleMountStableMessage.rideId.");
            }
            return;
        }// end function

    }
}
