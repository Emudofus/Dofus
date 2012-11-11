package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.dofus.network.messages.game.inventory.exchanges.*;
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeObjectModifiedMessage extends ExchangeObjectMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var object:ObjectItem;
        public static const protocolId:uint = 5519;

        public function ExchangeObjectModifiedMessage()
        {
            this.object = new ObjectItem();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5519;
        }// end function

        public function initExchangeObjectModifiedMessage(param1:Boolean = false, param2:ObjectItem = null) : ExchangeObjectModifiedMessage
        {
            super.initExchangeObjectMessage(param1);
            this.object = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.object = new ObjectItem();
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
            this.serializeAs_ExchangeObjectModifiedMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeObjectModifiedMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeObjectMessage(param1);
            this.object.serializeAs_ObjectItem(param1);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeObjectModifiedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeObjectModifiedMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.object = new ObjectItem();
            this.object.deserialize(param1);
            return;
        }// end function

    }
}
