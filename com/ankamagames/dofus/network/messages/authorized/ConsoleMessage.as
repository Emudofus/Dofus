package com.ankamagames.dofus.network.messages.authorized
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ConsoleMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var type:uint = 0;
        public var content:String = "";
        public static const protocolId:uint = 75;

        public function ConsoleMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 75;
        }// end function

        public function initConsoleMessage(param1:uint = 0, param2:String = "") : ConsoleMessage
        {
            this.type = param1;
            this.content = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.type = 0;
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
            this.serializeAs_ConsoleMessage(param1);
            return;
        }// end function

        public function serializeAs_ConsoleMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.type);
            param1.writeUTF(this.content);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ConsoleMessage(param1);
            return;
        }// end function

        public function deserializeAs_ConsoleMessage(param1:IDataInput) : void
        {
            this.type = param1.readByte();
            if (this.type < 0)
            {
                throw new Error("Forbidden value (" + this.type + ") on element of ConsoleMessage.type.");
            }
            this.content = param1.readUTF();
            return;
        }// end function

    }
}
