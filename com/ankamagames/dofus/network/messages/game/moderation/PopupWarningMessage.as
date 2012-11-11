package com.ankamagames.dofus.network.messages.game.moderation
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PopupWarningMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var lockDuration:uint = 0;
        public var author:String = "";
        public var content:String = "";
        public static const protocolId:uint = 6134;

        public function PopupWarningMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6134;
        }// end function

        public function initPopupWarningMessage(param1:uint = 0, param2:String = "", param3:String = "") : PopupWarningMessage
        {
            this.lockDuration = param1;
            this.author = param2;
            this.content = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.lockDuration = 0;
            this.author = "";
            this.content = "";
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
            this.serializeAs_PopupWarningMessage(param1);
            return;
        }// end function

        public function serializeAs_PopupWarningMessage(param1:IDataOutput) : void
        {
            if (this.lockDuration < 0 || this.lockDuration > 255)
            {
                throw new Error("Forbidden value (" + this.lockDuration + ") on element lockDuration.");
            }
            param1.writeByte(this.lockDuration);
            param1.writeUTF(this.author);
            param1.writeUTF(this.content);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PopupWarningMessage(param1);
            return;
        }// end function

        public function deserializeAs_PopupWarningMessage(param1:IDataInput) : void
        {
            this.lockDuration = param1.readUnsignedByte();
            if (this.lockDuration < 0 || this.lockDuration > 255)
            {
                throw new Error("Forbidden value (" + this.lockDuration + ") on element of PopupWarningMessage.lockDuration.");
            }
            this.author = param1.readUTF();
            this.content = param1.readUTF();
            return;
        }// end function

    }
}
