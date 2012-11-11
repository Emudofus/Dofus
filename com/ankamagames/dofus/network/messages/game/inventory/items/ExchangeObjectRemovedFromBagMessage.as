package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeObjectRemovedFromBagMessage extends ExchangeObjectMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var objectUID:uint = 0;
        public static const protocolId:uint = 6010;

        public function ExchangeObjectRemovedFromBagMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6010;
        }// end function

        public function initExchangeObjectRemovedFromBagMessage(param1:Boolean = false, param2:uint = 0) : ExchangeObjectRemovedFromBagMessage
        {
            super.initExchangeObjectMessage(param1);
            this.objectUID = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_ExchangeObjectRemovedFromBagMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeObjectRemovedFromBagMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeObjectMessage(param1);
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
            }
            param1.writeInt(this.objectUID);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeObjectRemovedFromBagMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeObjectRemovedFromBagMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.objectUID = param1.readInt();
            if (this.objectUID < 0)
            {
                throw new Error("Forbidden value (" + this.objectUID + ") on element of ExchangeObjectRemovedFromBagMessage.objectUID.");
            }
            return;
        }// end function

    }
}
