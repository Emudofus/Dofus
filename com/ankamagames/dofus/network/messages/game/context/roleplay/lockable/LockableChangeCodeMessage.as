package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LockableChangeCodeMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var code:String = "";
        public static const protocolId:uint = 5666;

        public function LockableChangeCodeMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5666;
        }// end function

        public function initLockableChangeCodeMessage(param1:String = "") : LockableChangeCodeMessage
        {
            this.code = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.code = "";
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
            this.serializeAs_LockableChangeCodeMessage(param1);
            return;
        }// end function

        public function serializeAs_LockableChangeCodeMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.code);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LockableChangeCodeMessage(param1);
            return;
        }// end function

        public function deserializeAs_LockableChangeCodeMessage(param1:IDataInput) : void
        {
            this.code = param1.readUTF();
            return;
        }// end function

    }
}
