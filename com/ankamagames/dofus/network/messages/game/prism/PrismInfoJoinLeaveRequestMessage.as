package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PrismInfoJoinLeaveRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var join:Boolean = false;
        public static const protocolId:uint = 5844;

        public function PrismInfoJoinLeaveRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5844;
        }// end function

        public function initPrismInfoJoinLeaveRequestMessage(param1:Boolean = false) : PrismInfoJoinLeaveRequestMessage
        {
            this.join = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.join = false;
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
            this.serializeAs_PrismInfoJoinLeaveRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_PrismInfoJoinLeaveRequestMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.join);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PrismInfoJoinLeaveRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_PrismInfoJoinLeaveRequestMessage(param1:IDataInput) : void
        {
            this.join = param1.readBoolean();
            return;
        }// end function

    }
}
