package com.ankamagames.dofus.network.messages.game.approach
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AuthenticationTicketMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var lang:String = "";
        public var ticket:String = "";
        public static const protocolId:uint = 110;

        public function AuthenticationTicketMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 110;
        }// end function

        public function initAuthenticationTicketMessage(param1:String = "", param2:String = "") : AuthenticationTicketMessage
        {
            this.lang = param1;
            this.ticket = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.lang = "";
            this.ticket = "";
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
            this.serializeAs_AuthenticationTicketMessage(param1);
            return;
        }// end function

        public function serializeAs_AuthenticationTicketMessage(param1:IDataOutput) : void
        {
            param1.writeUTF(this.lang);
            param1.writeUTF(this.ticket);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AuthenticationTicketMessage(param1);
            return;
        }// end function

        public function deserializeAs_AuthenticationTicketMessage(param1:IDataInput) : void
        {
            this.lang = param1.readUTF();
            this.ticket = param1.readUTF();
            return;
        }// end function

    }
}
