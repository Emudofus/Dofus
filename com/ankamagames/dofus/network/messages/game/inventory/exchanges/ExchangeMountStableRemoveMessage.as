package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeMountStableRemoveMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mountId:Number = 0;
        public static const protocolId:uint = 5964;

        public function ExchangeMountStableRemoveMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5964;
        }// end function

        public function initExchangeMountStableRemoveMessage(param1:Number = 0) : ExchangeMountStableRemoveMessage
        {
            this.mountId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mountId = 0;
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
            this.serializeAs_ExchangeMountStableRemoveMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeMountStableRemoveMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.mountId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeMountStableRemoveMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeMountStableRemoveMessage(param1:IDataInput) : void
        {
            this.mountId = param1.readDouble();
            return;
        }// end function

    }
}
