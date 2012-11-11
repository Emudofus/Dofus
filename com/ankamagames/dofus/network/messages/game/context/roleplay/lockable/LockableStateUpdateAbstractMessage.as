package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LockableStateUpdateAbstractMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var locked:Boolean = false;
        public static const protocolId:uint = 5671;

        public function LockableStateUpdateAbstractMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5671;
        }// end function

        public function initLockableStateUpdateAbstractMessage(param1:Boolean = false) : LockableStateUpdateAbstractMessage
        {
            this.locked = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.locked = false;
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
            this.serializeAs_LockableStateUpdateAbstractMessage(param1);
            return;
        }// end function

        public function serializeAs_LockableStateUpdateAbstractMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.locked);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LockableStateUpdateAbstractMessage(param1);
            return;
        }// end function

        public function deserializeAs_LockableStateUpdateAbstractMessage(param1:IDataInput) : void
        {
            this.locked = param1.readBoolean();
            return;
        }// end function

    }
}
