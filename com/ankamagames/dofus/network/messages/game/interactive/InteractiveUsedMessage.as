package com.ankamagames.dofus.network.messages.game.interactive
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InteractiveUsedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var entityId:uint = 0;
        public var elemId:uint = 0;
        public var skillId:uint = 0;
        public var duration:uint = 0;
        public static const protocolId:uint = 5745;

        public function InteractiveUsedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5745;
        }// end function

        public function initInteractiveUsedMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0, param4:uint = 0) : InteractiveUsedMessage
        {
            this.entityId = param1;
            this.elemId = param2;
            this.skillId = param3;
            this.duration = param4;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.entityId = 0;
            this.elemId = 0;
            this.skillId = 0;
            this.duration = 0;
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
            this.serializeAs_InteractiveUsedMessage(param1);
            return;
        }// end function

        public function serializeAs_InteractiveUsedMessage(param1:IDataOutput) : void
        {
            if (this.entityId < 0)
            {
                throw new Error("Forbidden value (" + this.entityId + ") on element entityId.");
            }
            param1.writeInt(this.entityId);
            if (this.elemId < 0)
            {
                throw new Error("Forbidden value (" + this.elemId + ") on element elemId.");
            }
            param1.writeInt(this.elemId);
            if (this.skillId < 0)
            {
                throw new Error("Forbidden value (" + this.skillId + ") on element skillId.");
            }
            param1.writeShort(this.skillId);
            if (this.duration < 0)
            {
                throw new Error("Forbidden value (" + this.duration + ") on element duration.");
            }
            param1.writeShort(this.duration);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InteractiveUsedMessage(param1);
            return;
        }// end function

        public function deserializeAs_InteractiveUsedMessage(param1:IDataInput) : void
        {
            this.entityId = param1.readInt();
            if (this.entityId < 0)
            {
                throw new Error("Forbidden value (" + this.entityId + ") on element of InteractiveUsedMessage.entityId.");
            }
            this.elemId = param1.readInt();
            if (this.elemId < 0)
            {
                throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUsedMessage.elemId.");
            }
            this.skillId = param1.readShort();
            if (this.skillId < 0)
            {
                throw new Error("Forbidden value (" + this.skillId + ") on element of InteractiveUsedMessage.skillId.");
            }
            this.duration = param1.readShort();
            if (this.duration < 0)
            {
                throw new Error("Forbidden value (" + this.duration + ") on element of InteractiveUsedMessage.duration.");
            }
            return;
        }// end function

    }
}
