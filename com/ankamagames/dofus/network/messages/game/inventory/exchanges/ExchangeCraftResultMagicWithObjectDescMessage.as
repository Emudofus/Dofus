package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.dofus.network.types.game.data.items.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeCraftResultMagicWithObjectDescMessage extends ExchangeCraftResultWithObjectDescMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var magicPoolStatus:int = 0;
        public static const protocolId:uint = 6188;

        public function ExchangeCraftResultMagicWithObjectDescMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6188;
        }// end function

        public function initExchangeCraftResultMagicWithObjectDescMessage(param1:uint = 0, param2:ObjectItemNotInContainer = null, param3:int = 0) : ExchangeCraftResultMagicWithObjectDescMessage
        {
            super.initExchangeCraftResultWithObjectDescMessage(param1, param2);
            this.magicPoolStatus = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.magicPoolStatus = 0;
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
            this.serializeAs_ExchangeCraftResultMagicWithObjectDescMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeCraftResultMagicWithObjectDescMessage(param1:IDataOutput) : void
        {
            super.serializeAs_ExchangeCraftResultWithObjectDescMessage(param1);
            param1.writeByte(this.magicPoolStatus);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeCraftResultMagicWithObjectDescMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeCraftResultMagicWithObjectDescMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.magicPoolStatus = param1.readByte();
            return;
        }// end function

    }
}
