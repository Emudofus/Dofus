package com.ankamagames.dofus.network.messages.game.approach
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class AuthenticationTicketMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 110;

        private var _isInitialized:Boolean = false;
        public var lang:String = "";
        public var ticket:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (110);
        }

        public function initAuthenticationTicketMessage(lang:String="", ticket:String=""):AuthenticationTicketMessage
        {
            this.lang = lang;
            this.ticket = ticket;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.lang = "";
            this.ticket = "";
            this._isInitialized = false;
        }

        override public function pack(output:ICustomDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(new CustomDataWrapper(data));
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:ICustomDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_AuthenticationTicketMessage(output);
        }

        public function serializeAs_AuthenticationTicketMessage(output:ICustomDataOutput):void
        {
            output.writeUTF(this.lang);
            output.writeUTF(this.ticket);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_AuthenticationTicketMessage(input);
        }

        public function deserializeAs_AuthenticationTicketMessage(input:ICustomDataInput):void
        {
            this.lang = input.readUTF();
            this.ticket = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.approach

