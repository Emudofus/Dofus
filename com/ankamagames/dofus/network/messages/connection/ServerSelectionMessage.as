package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ServerSelectionMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 40;

        private var _isInitialized:Boolean = false;
        public var serverId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (40);
        }

        public function initServerSelectionMessage(serverId:uint=0):ServerSelectionMessage
        {
            this.serverId = serverId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.serverId = 0;
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
            this.serializeAs_ServerSelectionMessage(output);
        }

        public function serializeAs_ServerSelectionMessage(output:ICustomDataOutput):void
        {
            if (this.serverId < 0)
            {
                throw (new Error((("Forbidden value (" + this.serverId) + ") on element serverId.")));
            };
            output.writeVarShort(this.serverId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ServerSelectionMessage(input);
        }

        public function deserializeAs_ServerSelectionMessage(input:ICustomDataInput):void
        {
            this.serverId = input.readVarUhShort();
            if (this.serverId < 0)
            {
                throw (new Error((("Forbidden value (" + this.serverId) + ") on element of ServerSelectionMessage.serverId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

