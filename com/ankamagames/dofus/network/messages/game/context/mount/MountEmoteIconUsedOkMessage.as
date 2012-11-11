package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MountEmoteIconUsedOkMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var mountId:int = 0;
        public var reactionType:uint = 0;
        public static const protocolId:uint = 5978;

        public function MountEmoteIconUsedOkMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5978;
        }// end function

        public function initMountEmoteIconUsedOkMessage(param1:int = 0, param2:uint = 0) : MountEmoteIconUsedOkMessage
        {
            this.mountId = param1;
            this.reactionType = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.mountId = 0;
            this.reactionType = 0;
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
            this.serializeAs_MountEmoteIconUsedOkMessage(param1);
            return;
        }// end function

        public function serializeAs_MountEmoteIconUsedOkMessage(param1:IDataOutput) : void
        {
            param1.writeInt(this.mountId);
            if (this.reactionType < 0)
            {
                throw new Error("Forbidden value (" + this.reactionType + ") on element reactionType.");
            }
            param1.writeByte(this.reactionType);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MountEmoteIconUsedOkMessage(param1);
            return;
        }// end function

        public function deserializeAs_MountEmoteIconUsedOkMessage(param1:IDataInput) : void
        {
            this.mountId = param1.readInt();
            this.reactionType = param1.readByte();
            if (this.reactionType < 0)
            {
                throw new Error("Forbidden value (" + this.reactionType + ") on element of MountEmoteIconUsedOkMessage.reactionType.");
            }
            return;
        }// end function

    }
}
