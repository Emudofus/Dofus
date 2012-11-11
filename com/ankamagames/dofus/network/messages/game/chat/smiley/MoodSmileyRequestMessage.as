package com.ankamagames.dofus.network.messages.game.chat.smiley
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MoodSmileyRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var smileyId:int = 0;
        public static const protocolId:uint = 6192;

        public function MoodSmileyRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6192;
        }// end function

        public function initMoodSmileyRequestMessage(param1:int = 0) : MoodSmileyRequestMessage
        {
            this.smileyId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.smileyId = 0;
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
            this.serializeAs_MoodSmileyRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_MoodSmileyRequestMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.smileyId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MoodSmileyRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_MoodSmileyRequestMessage(param1:IDataInput) : void
        {
            this.smileyId = param1.readByte();
            return;
        }// end function

    }
}
