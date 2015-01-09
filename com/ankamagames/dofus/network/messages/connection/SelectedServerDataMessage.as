package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;

    [Trusted]
    public class SelectedServerDataMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 42;

        private var _isInitialized:Boolean = false;
        public var serverId:uint = 0;
        public var address:String = "";
        public var port:uint = 0;
        public var ssl:Boolean = false;
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

        public function initSelectedServerDataMessage(serverId:uint=0, address:String="", port:uint=0, ssl:Boolean=false, canCreateNewCharacter:Boolean=false, ticket:String=""):SelectedServerDataMessage
        {
            this.serverId = serverId;
            this.address = address;
            this.port = port;
            this.ssl = ssl;
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
            this.ssl = false;
            this.canCreateNewCharacter = false;
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
            this.serializeAs_SelectedServerDataMessage(output);
        }

        public function serializeAs_SelectedServerDataMessage(output:ICustomDataOutput):void
        {
            var _box0:uint;
            _box0 = BooleanByteWrapper.setFlag(_box0, 0, this.ssl);
            _box0 = BooleanByteWrapper.setFlag(_box0, 1, this.canCreateNewCharacter);
            output.writeByte(_box0);
            if (this.serverId < 0)
            {
                throw (new Error((("Forbidden value (" + this.serverId) + ") on element serverId.")));
            };
            output.writeVarShort(this.serverId);
            output.writeUTF(this.address);
            if ((((this.port < 0)) || ((this.port > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.port) + ") on element port.")));
            };
            output.writeShort(this.port);
            output.writeUTF(this.ticket);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SelectedServerDataMessage(input);
        }

        public function deserializeAs_SelectedServerDataMessage(input:ICustomDataInput):void
        {
            var _box0:uint = input.readByte();
            this.ssl = BooleanByteWrapper.getFlag(_box0, 0);
            this.canCreateNewCharacter = BooleanByteWrapper.getFlag(_box0, 1);
            this.serverId = input.readVarUhShort();
            if (this.serverId < 0)
            {
                throw (new Error((("Forbidden value (" + this.serverId) + ") on element of SelectedServerDataMessage.serverId.")));
            };
            this.address = input.readUTF();
            this.port = input.readUnsignedShort();
            if ((((this.port < 0)) || ((this.port > 0xFFFF))))
            {
                throw (new Error((("Forbidden value (" + this.port) + ") on element of SelectedServerDataMessage.port.")));
            };
            this.ticket = input.readUTF();
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

