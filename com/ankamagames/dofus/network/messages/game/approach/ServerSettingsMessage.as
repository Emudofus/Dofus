package com.ankamagames.dofus.network.messages.game.approach
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ServerSettingsMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var lang:String = "";
        public var community:uint = 0;
        public static const protocolId:uint = 6340;

        public function ServerSettingsMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6340;
        }// end function

        public function initServerSettingsMessage(param1:String = "", param2:uint = 0) : ServerSettingsMessage
        {
            this.lang = param1;
            this.community = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.lang = "";
            this.community = 0;
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
            this.serializeAs_ServerSettingsMessage(param1);
            return;
        }// end function

        public function serializeAs_ServerSettingsMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.lang);
            if (this.community < 0)
            {
                throw new Error("Forbidden value (" + this.community + ") on element community.");
            }
            param1.writeByte(this.community);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ServerSettingsMessage(param1);
            return;
        }// end function

        public function deserializeAs_ServerSettingsMessage(param1:IDataInput) : void
        {
            this.lang = param1.readUTF();
            this.community = param1.readByte();
            if (this.community < 0)
            {
                throw new Error("Forbidden value (" + this.community + ") on element of ServerSettingsMessage.community.");
            }
            return;
        }// end function

    }
}
