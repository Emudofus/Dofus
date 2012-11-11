package com.ankamagames.dofus.network.messages.game.packs
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PackRestrictedSubAreaMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;
        public static const protocolId:uint = 6186;

        public function PackRestrictedSubAreaMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6186;
        }// end function

        public function initPackRestrictedSubAreaMessage(param1:uint = 0) : PackRestrictedSubAreaMessage
        {
            this.subAreaId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.subAreaId = 0;
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
            this.serializeAs_PackRestrictedSubAreaMessage(param1);
            return;
        }// end function

        public function serializeAs_PackRestrictedSubAreaMessage(param1:IDataOutput) : void
        {
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
            }
            param1.writeInt(this.subAreaId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PackRestrictedSubAreaMessage(param1);
            return;
        }// end function

        public function deserializeAs_PackRestrictedSubAreaMessage(param1:IDataInput) : void
        {
            this.subAreaId = param1.readInt();
            if (this.subAreaId < 0)
            {
                throw new Error("Forbidden value (" + this.subAreaId + ") on element of PackRestrictedSubAreaMessage.subAreaId.");
            }
            return;
        }// end function

    }
}
