package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MountEquipedErrorMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var errorType:uint = 0;
        public static const protocolId:uint = 5963;

        public function MountEquipedErrorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5963;
        }// end function

        public function initMountEquipedErrorMessage(param1:uint = 0) : MountEquipedErrorMessage
        {
            this.errorType = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.errorType = 0;
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
            this.serializeAs_MountEquipedErrorMessage(param1);
            return;
        }// end function

        public function serializeAs_MountEquipedErrorMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.errorType);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MountEquipedErrorMessage(param1);
            return;
        }// end function

        public function deserializeAs_MountEquipedErrorMessage(param1:IDataInput) : void
        {
            this.errorType = param1.readByte();
            if (this.errorType < 0)
            {
                throw new Error("Forbidden value (" + this.errorType + ") on element of MountEquipedErrorMessage.errorType.");
            }
            return;
        }// end function

    }
}
