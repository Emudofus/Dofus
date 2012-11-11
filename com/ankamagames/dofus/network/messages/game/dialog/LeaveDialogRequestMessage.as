package com.ankamagames.dofus.network.messages.game.dialog
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LeaveDialogRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var dialogType:uint = 0;
        public static const protocolId:uint = 5501;

        public function LeaveDialogRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5501;
        }// end function

        public function initLeaveDialogRequestMessage(param1:uint = 0) : LeaveDialogRequestMessage
        {
            this.dialogType = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.dialogType = 0;
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
            this.serializeAs_LeaveDialogRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_LeaveDialogRequestMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.dialogType);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LeaveDialogRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_LeaveDialogRequestMessage(param1:IDataInput) : void
        {
            this.dialogType = param1.readByte();
            if (this.dialogType < 0)
            {
                throw new Error("Forbidden value (" + this.dialogType + ") on element of LeaveDialogRequestMessage.dialogType.");
            }
            return;
        }// end function

    }
}
