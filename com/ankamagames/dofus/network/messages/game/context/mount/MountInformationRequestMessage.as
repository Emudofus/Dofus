package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MountInformationRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var id:Number = 0;
        public var time:Number = 0;
        public static const protocolId:uint = 5972;

        public function MountInformationRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5972;
        }// end function

        public function initMountInformationRequestMessage(param1:Number = 0, param2:Number = 0) : MountInformationRequestMessage
        {
            this.id = param1;
            this.time = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.id = 0;
            this.time = 0;
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
            this.serializeAs_MountInformationRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_MountInformationRequestMessage(param1:IDataOutput) : void
        {
            param1.writeDouble(this.id);
            param1.writeDouble(this.time);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MountInformationRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_MountInformationRequestMessage(param1:IDataInput) : void
        {
            this.id = param1.readDouble();
            this.time = param1.readDouble();
            return;
        }// end function

    }
}
