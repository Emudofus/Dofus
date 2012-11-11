package com.ankamagames.dofus.network.messages.game.interactive
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InteractiveUseRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var elemId:uint = 0;
        public var skillInstanceUid:uint = 0;
        public static const protocolId:uint = 5001;

        public function InteractiveUseRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5001;
        }// end function

        public function initInteractiveUseRequestMessage(param1:uint = 0, param2:uint = 0) : InteractiveUseRequestMessage
        {
            this.elemId = param1;
            this.skillInstanceUid = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.elemId = 0;
            this.skillInstanceUid = 0;
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
            this.serializeAs_InteractiveUseRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_InteractiveUseRequestMessage(param1:IDataOutput) : void
        {
            if (this.elemId < 0)
            {
                throw new Error("Forbidden value (" + this.elemId + ") on element elemId.");
            }
            param1.writeInt(this.elemId);
            if (this.skillInstanceUid < 0)
            {
                throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element skillInstanceUid.");
            }
            param1.writeInt(this.skillInstanceUid);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InteractiveUseRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_InteractiveUseRequestMessage(param1:IDataInput) : void
        {
            this.elemId = param1.readInt();
            if (this.elemId < 0)
            {
                throw new Error("Forbidden value (" + this.elemId + ") on element of InteractiveUseRequestMessage.elemId.");
            }
            this.skillInstanceUid = param1.readInt();
            if (this.skillInstanceUid < 0)
            {
                throw new Error("Forbidden value (" + this.skillInstanceUid + ") on element of InteractiveUseRequestMessage.skillInstanceUid.");
            }
            return;
        }// end function

    }
}
