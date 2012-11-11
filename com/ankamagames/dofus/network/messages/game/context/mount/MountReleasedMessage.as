package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MountReleasedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mountId:Number = 0;
        public static const protocolId:uint = 6308;

        public function MountReleasedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6308;
        }// end function

        public function initMountReleasedMessage(param1:Number = 0) : MountReleasedMessage
        {
            this.mountId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mountId = 0;
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
            this.serializeAs_MountReleasedMessage(param1);
            return;
        }// end function

        public function serializeAs_MountReleasedMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.mountId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MountReleasedMessage(param1);
            return;
        }// end function

        public function deserializeAs_MountReleasedMessage(param1:IDataInput) : void
        {
            this.mountId = param1.readDouble();
            return;
        }// end function

    }
}
