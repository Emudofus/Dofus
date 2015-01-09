package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.connection.GameServerInformations;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ServerStatusUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 50;

        private var _isInitialized:Boolean = false;
        public var server:GameServerInformations;

        public function ServerStatusUpdateMessage()
        {
            this.server = new GameServerInformations();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (50);
        }

        public function initServerStatusUpdateMessage(server:GameServerInformations=null):ServerStatusUpdateMessage
        {
            this.server = server;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.server = new GameServerInformations();
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
            this.serializeAs_ServerStatusUpdateMessage(output);
        }

        public function serializeAs_ServerStatusUpdateMessage(output:ICustomDataOutput):void
        {
            this.server.serializeAs_GameServerInformations(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ServerStatusUpdateMessage(input);
        }

        public function deserializeAs_ServerStatusUpdateMessage(input:ICustomDataInput):void
        {
            this.server = new GameServerInformations();
            this.server.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

