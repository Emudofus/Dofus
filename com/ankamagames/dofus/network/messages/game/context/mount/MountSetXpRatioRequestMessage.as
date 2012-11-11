package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MountSetXpRatioRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var xpRatio:uint = 0;
        public static const protocolId:uint = 5989;

        public function MountSetXpRatioRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5989;
        }// end function

        public function initMountSetXpRatioRequestMessage(param1:uint = 0) : MountSetXpRatioRequestMessage
        {
            this.xpRatio = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.xpRatio = 0;
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
            this.serializeAs_MountSetXpRatioRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_MountSetXpRatioRequestMessage(param1:IDataOutput) : void
        {
            if (this.xpRatio < 0)
            {
                throw new Error("Forbidden value (" + this.xpRatio + ") on element xpRatio.");
            }
            param1.writeByte(this.xpRatio);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MountSetXpRatioRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_MountSetXpRatioRequestMessage(param1:IDataInput) : void
        {
            this.xpRatio = param1.readByte();
            if (this.xpRatio < 0)
            {
                throw new Error("Forbidden value (" + this.xpRatio + ") on element of MountSetXpRatioRequestMessage.xpRatio.");
            }
            return;
        }// end function

    }
}
