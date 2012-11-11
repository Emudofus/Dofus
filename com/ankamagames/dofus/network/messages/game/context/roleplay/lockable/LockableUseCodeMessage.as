package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LockableUseCodeMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var code:String = "";
        public static const protocolId:uint = 5667;

        public function LockableUseCodeMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5667;
        }// end function

        public function initLockableUseCodeMessage(param1:String = "") : LockableUseCodeMessage
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
            this.serializeAs_LockableUseCodeMessage(param1);
            return;
        }// end function

        public function serializeAs_LockableUseCodeMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.code);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LockableUseCodeMessage(param1);
            return;
        }// end function

        public function deserializeAs_LockableUseCodeMessage(param1:IDataInput) : void
        {
            this.code = param1.readUTF();
            return;
        }// end function

    }
}
