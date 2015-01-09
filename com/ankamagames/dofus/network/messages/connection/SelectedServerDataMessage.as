package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class SelectedServerDataMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 42;

        private var _isInitialized:Boolean = false;
        public var serverId:int = 0;
        public var address:String = "";
        public var port:uint = 0;
        public var canCreateNewCharacter:Boolean = false;
        public var ticket:String = "";


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (42);
        }

        public function initSelectedServerDataMessage(serverId:int=0, address:String="", port:uint=0, canCreateNewCharacter:Boolean=false, ticket:String=""):SelectedServerDataMessage
        {
            this.serverId = serverId;
            this.address = address;
            this.port = port;
            this.canCreateNewCharacter = canCreateNewCharacter;
            this.ticket = ticket;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.serverId = 0;
            this.address = "";
            this.port = 0;
            this.canCreateNewCharacter = false;
            this.ticket = "";
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_SelectedServerDataMessage(output);
        }

        public function serializeAs_SelectedServerDataMessage(output:IDataOutput):void
        {
            output.writeShort(this.serverId);
            output.writeUTF(this.address);
            if ((((this.port < 0)) || ((this.port > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.port) + ") on element port.")));
            };
            output.writeShort(this.port);
            output.writeBoolean(this.canCreateNewCharacter);
            output.writeUTF(this.ticket);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_SelectedServerDataMessage(input);
        }

        public function deserializeAs_SelectedServerDataMessage(input:IDataInput):void
        {
            this.serverId = input.readShort();
            this.address = input.readUTF();
            this.port = input.readUnsignedShort();
            if ((((this.port < 0)) || ((this.port > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.port) + ") on element of SelectedServerDataMessage.port.")));
            };
            this.canCreateNewCharacter = input.readBoolean();
            this.ticket = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

