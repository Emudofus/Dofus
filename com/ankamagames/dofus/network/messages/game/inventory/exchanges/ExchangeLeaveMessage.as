package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.dofus.network.messages.game.dialog.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ExchangeLeaveMessage extends LeaveDialogMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var success:Boolean = false;
        public static const protocolId:uint = 5628;

        public function ExchangeLeaveMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5628;
        }// end function

        public function initExchangeLeaveMessage(param1:uint = 0, param2:Boolean = false) : ExchangeLeaveMessage
        {
            super.initLeaveDialogMessage(param1);
            this.success = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.success = false;
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
            this.serializeAs_ExchangeLeaveMessage(param1);
            return;
        }// end function

        public function serializeAs_ExchangeLeaveMessage(param1:IDataOutput) : void
        {
            super.serializeAs_LeaveDialogMessage(param1);
            param1.writeBoolean(this.success);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ExchangeLeaveMessage(param1);
            return;
        }// end function

        public function deserializeAs_ExchangeLeaveMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.success = param1.readBoolean();
            return;
        }// end function

    }
}
