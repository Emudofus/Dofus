package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.dofus.network.types.game.mount.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeMountPaddockAddMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mountDescription:MountClientData;
        public static const protocolId:uint = 6049;

        public function ExchangeMountPaddockAddMessage()
        {
            this.mountDescription = new MountClientData();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6049;
        }// end function

        public function initExchangeMountPaddockAddMessage(param1:MountClientData = null) : ExchangeMountPaddockAddMessage
        {
            this.mountDescription = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mountDescription = new MountClientData();
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
            this.serializeAs_ExchangeMountPaddockAddMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeMountPaddockAddMessage(param1:IDataOutput) : void
        {
            this.mountDescription.serializeAs_MountClientData(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeMountPaddockAddMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeMountPaddockAddMessage(param1:IDataInput) : void
        {
            this.mountDescription = new MountClientData();
            this.mountDescription.deserialize(param1);
            return;
        }// end function

    }
}
