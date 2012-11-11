package com.ankamagames.dofus.network.messages.game.context.roleplay.emote
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class EmotePlayAbstractMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var emoteId:uint = 0;
        public var emoteStartTime:Number = 0;
        public static const protocolId:uint = 5690;

        public function EmotePlayAbstractMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5690;
        }// end function

        public function initEmotePlayAbstractMessage(param1:uint = 0, param2:Number = 0) : EmotePlayAbstractMessage
        {
            this.emoteId = param1;
            this.emoteStartTime = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.emoteId = 0;
            this.emoteStartTime = 0;
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
            this.serializeAs_EmotePlayAbstractMessage(param1);
            return;
        }// end function

        public function serializeAs_EmotePlayAbstractMessage(param1:IDataOutput) : void
        {
            if (this.emoteId < 0)
            {
                throw new Error("Forbidden value (" + this.emoteId + ") on element emoteId.");
            }
            param1.writeByte(this.emoteId);
            param1.writeDouble(this.emoteStartTime);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_EmotePlayAbstractMessage(param1);
            return;
        }// end function

        public function deserializeAs_EmotePlayAbstractMessage(param1:IDataInput) : void
        {
            this.emoteId = param1.readByte();
            if (this.emoteId < 0)
            {
                throw new Error("Forbidden value (" + this.emoteId + ") on element of EmotePlayAbstractMessage.emoteId.");
            }
            this.emoteStartTime = param1.readDouble();
            return;
        }// end function

    }
}
