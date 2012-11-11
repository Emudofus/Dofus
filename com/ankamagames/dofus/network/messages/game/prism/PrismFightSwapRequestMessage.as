package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismFightSwapRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var targetId:uint = 0;
        public static const protocolId:uint = 5901;

        public function PrismFightSwapRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5901;
        }// end function

        public function initPrismFightSwapRequestMessage(param1:uint = 0) : PrismFightSwapRequestMessage
        {
            this.targetId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.targetId = 0;
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
            this.serializeAs_PrismFightSwapRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismFightSwapRequestMessage(param1:IDataOutput) : void
        {
            if (this.targetId < 0)
            {
                throw new Error("Forbidden value (" + this.targetId + ") on element targetId.");
            }
            param1.writeInt(this.targetId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismFightSwapRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismFightSwapRequestMessage(param1:IDataInput) : void
        {
            this.targetId = param1.readInt();
            if (this.targetId < 0)
            {
                throw new Error("Forbidden value (" + this.targetId + ") on element of PrismFightSwapRequestMessage.targetId.");
            }
            return;
        }// end function

    }
}
