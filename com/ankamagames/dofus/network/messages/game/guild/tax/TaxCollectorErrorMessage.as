package com.ankamagames.dofus.network.messages.game.guild.tax
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class TaxCollectorErrorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var reason:int = 0;
        public static const protocolId:uint = 5634;

        public function TaxCollectorErrorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5634;
        }// end function

        public function initTaxCollectorErrorMessage(param1:int = 0) : TaxCollectorErrorMessage
        {
            this.reason = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.reason = 0;
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
            this.serializeAs_TaxCollectorErrorMessage(param1);
            return;
        }// end function

        public function serializeAs_TaxCollectorErrorMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.reason);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_TaxCollectorErrorMessage(param1);
            return;
        }// end function

        public function deserializeAs_TaxCollectorErrorMessage(param1:IDataInput) : void
        {
            this.reason = param1.readByte();
            return;
        }// end function

    }
}
