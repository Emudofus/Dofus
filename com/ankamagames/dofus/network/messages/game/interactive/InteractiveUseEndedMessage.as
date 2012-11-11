package com.ankamagames.dofus.network.messages.game.interactive
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InteractiveUseEndedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var elemId:uint = 0;
        public var skillId:uint = 0;
        public static const protocolId:uint = 6112;

        public function InteractiveUseEndedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6112;
        }// end function

        public function initInteractiveUseEndedMessage(param1:uint = 0, param2:uint = 0) : InteractiveUseEndedMessage
        {
            this.elemId = param1;
            this.skillId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.elemId = 0;
            this.skillId = 0;
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
            this.serializeAs_InteractiveUseEndedMessage(param1);
            return;
        }// end function

        public function serializeAs_InteractiveUseEndedMessage(param1:IDataOutput) : void
        {
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
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InteractiveUseEndedMessage(param1);
            return;
        }// end function

        public function deserializeAs_InteractiveUseEndedMessage(param1:IDataInput) : void
        {
            this.elemId = param1.readInt();
            if (this.elemId < 0)
            {
                throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUseEndedMessage.elemId.");
            }
            this.skillId = param1.readShort();
            if (this.skillId < 0)
            {
                throw new Error("Forbidden value (" + this.skillId + ") on element of InteractiveUseEndedMessage.skillId.");
            }
            return;
        }// end function

    }
}
