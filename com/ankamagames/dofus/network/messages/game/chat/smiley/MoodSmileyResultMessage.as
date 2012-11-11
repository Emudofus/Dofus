package com.ankamagames.dofus.network.messages.game.chat.smiley
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class MoodSmileyResultMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var resultCode:uint = 1;
        public var smileyId:int = 0;
        public static const protocolId:uint = 6196;

        public function MoodSmileyResultMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6196;
        }// end function

        public function initMoodSmileyResultMessage(param1:uint = 1, param2:int = 0) : MoodSmileyResultMessage
        {
            this.resultCode = param1;
            this.smileyId = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.resultCode = 1;
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
            this.serializeAs_MoodSmileyResultMessage(param1);
            return;
        }// end function

        public function serializeAs_MoodSmileyResultMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.resultCode);
            param1.writeByte(this.smileyId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_MoodSmileyResultMessage(param1);
            return;
        }// end function

        public function deserializeAs_MoodSmileyResultMessage(param1:IDataInput) : void
        {
            this.resultCode = param1.readByte();
            if (this.resultCode < 0)
            {
                throw new Error("Forbidden value (" + this.resultCode + ") on element of MoodSmileyResultMessage.resultCode.");
            }
            this.smileyId = param1.readByte();
            return;
        }// end function

    }
}
