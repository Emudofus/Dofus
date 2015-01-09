package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.connection.GameServerInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class ServersListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 30;

        private var _isInitialized:Boolean = false;
        public var servers:Vector.<GameServerInformations>;

        public function ServersListMessage()
        {
            this.servers = new Vector.<GameServerInformations>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (30);
        }

        public function initServersListMessage(servers:Vector.<GameServerInformations>=null):ServersListMessage
        {
            this.servers = servers;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.servers = new Vector.<GameServerInformations>();
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
            this.serializeAs_ServersListMessage(output);
        }

        public function serializeAs_ServersListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.servers.length);
            var _i1:uint;
            while (_i1 < this.servers.length)
            {
                (this.servers[_i1] as GameServerInformations).serializeAs_GameServerInformations(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ServersListMessage(input);
        }

        public function deserializeAs_ServersListMessage(input:ICustomDataInput):void
        {
            var _item1:GameServerInformations;
            var _serversLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _serversLen)
            {
                _item1 = new GameServerInformations();
                _item1.deserialize(input);
                this.servers.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

