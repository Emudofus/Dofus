package com.ankamagames.dofus.network.messages.game.context.roleplay.lockable
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class LockableStateUpdateHouseDoorMessage extends LockableStateUpdateAbstractMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var houseId:int = 0;
        public static const protocolId:uint = 5668;

        public function LockableStateUpdateHouseDoorMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return super.isInitialized && this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5668;
        }// end function

        public function initLockableStateUpdateHouseDoorMessage(param1:Boolean = false, param2:int = 0) : LockableStateUpdateHouseDoorMessage
        {
            super.initLockableStateUpdateAbstractMessage(param1);
            this.houseId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.houseId = 0;
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
            this.serializeAs_LockableStateUpdateHouseDoorMessage(param1);
            return;
        }// end function

        public function serializeAs_LockableStateUpdateHouseDoorMessage(param1:IDataOutput) : void
        {
            super.serializeAs_LockableStateUpdateAbstractMessage(param1);
            param1.writeInt(this.houseId);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_LockableStateUpdateHouseDoorMessage(param1);
            return;
        }// end function

        public function deserializeAs_LockableStateUpdateHouseDoorMessage(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.houseId = param1.readInt();
            return;
        }// end function

    }
}
