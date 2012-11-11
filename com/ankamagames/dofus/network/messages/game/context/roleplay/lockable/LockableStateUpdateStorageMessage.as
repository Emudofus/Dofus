package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LockableStateUpdateStorageMessage extends LockableStateUpdateAbstractMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mapId:int = 0;
        public var elementId:uint = 0;
        public static const protocolId:uint = 5669;

        public function LockableStateUpdateStorageMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5669;
        }// end function

        public function initLockableStateUpdateStorageMessage(param1:Boolean = false, param2:int = 0, param3:uint = 0) : LockableStateUpdateStorageMessage
        {
            super.initLockableStateUpdateAbstractMessage(param1);
            this.mapId = param2;
            this.elementId = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.mapId = 0;
            this.elementId = 0;
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

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_LockableStateUpdateStorageMessage(param1);
            return;
        }// end function

        public function serializeAs_LockableStateUpdateStorageMessage(param1:IDataOutput) : void
        {
            super.serializeAs_LockableStateUpdateAbstractMessage(param1);
            param1.writeInt(this.mapId);
            if (this.elementId < 0)
            {
                throw new Error("Forbidden value (" + this.elementId + ") on element elementId.");
            }
            param1.writeInt(this.elementId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LockableStateUpdateStorageMessage(param1);
            return;
        }// end function

        public function deserializeAs_LockableStateUpdateStorageMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.mapId = param1.readInt();
            this.elementId = param1.readInt();
            if (this.elementId < 0)
            {
                throw new Error("Forbidden value (" + this.elementId + ") on element of LockableStateUpdateStorageMessage.elementId.");
            }
            return;
        }// end function

    }
}
