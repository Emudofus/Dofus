package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismInfoInValidMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var reason:uint = 0;
        public static const protocolId:uint = 5859;

        public function PrismInfoInValidMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5859;
        }// end function

        public function initPrismInfoInValidMessage(param1:uint = 0) : PrismInfoInValidMessage
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
            this.serializeAs_PrismInfoInValidMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismInfoInValidMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.reason);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismInfoInValidMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismInfoInValidMessage(param1:IDataInput) : void
        {
            this.reason = param1.readByte();
            if (this.reason < 0)
            {
                throw new Error("Forbidden value (" + this.reason + ") on element of PrismInfoInValidMessage.reason.");
            }
            return;
        }// end function

    }
}
