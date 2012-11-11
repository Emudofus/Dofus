package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LockableShowCodeDialogMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var changeOrUse:Boolean = false;
        public var codeSize:uint = 0;
        public static const protocolId:uint = 5740;

        public function LockableShowCodeDialogMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5740;
        }// end function

        public function initLockableShowCodeDialogMessage(param1:Boolean = false, param2:uint = 0) : LockableShowCodeDialogMessage
        {
            this.changeOrUse = param1;
            this.codeSize = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.changeOrUse = false;
            this.codeSize = 0;
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
            this.serializeAs_LockableShowCodeDialogMessage(param1);
            return;
        }// end function

        public function serializeAs_LockableShowCodeDialogMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.changeOrUse);
            if (this.codeSize < 0)
            {
                throw new Error("Forbidden value (" + this.codeSize + ") on element codeSize.");
            }
            param1.writeByte(this.codeSize);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LockableShowCodeDialogMessage(param1);
            return;
        }// end function

        public function deserializeAs_LockableShowCodeDialogMessage(param1:IDataInput) : void
        {
            this.changeOrUse = param1.readBoolean();
            this.codeSize = param1.readByte();
            if (this.codeSize < 0)
            {
                throw new Error("Forbidden value (" + this.codeSize + ") on element of LockableShowCodeDialogMessage.codeSize.");
            }
            return;
        }// end function

    }
}
