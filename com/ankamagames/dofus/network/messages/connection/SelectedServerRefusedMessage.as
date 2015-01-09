package com.ankamagames.dofus.network.messages.connection
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class SelectedServerRefusedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 41;

        private var _isInitialized:Boolean = false;
        public var serverId:uint = 0;
        public var error:uint = 1;
        public var serverStatus:uint = 1;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (41);
        }

        public function initSelectedServerRefusedMessage(serverId:uint=0, error:uint=1, serverStatus:uint=1):SelectedServerRefusedMessage
        {
            this.serverId = serverId;
            this.error = error;
            this.serverStatus = serverStatus;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.serverId = 0;
            this.error = 1;
            this.serverStatus = 1;
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
            this.serializeAs_SelectedServerRefusedMessage(output);
        }

        public function serializeAs_SelectedServerRefusedMessage(output:ICustomDataOutput):void
        {
            if (this.serverId < 0)
            {
                throw (new Error((("Forbidden value (" + this.serverId) + ") on element serverId.")));
            };
            output.writeVarShort(this.serverId);
            output.writeByte(this.error);
            output.writeByte(this.serverStatus);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_SelectedServerRefusedMessage(input);
        }

        public function deserializeAs_SelectedServerRefusedMessage(input:ICustomDataInput):void
        {
            this.serverId = input.readVarUhShort();
            if (this.serverId < 0)
            {
                throw (new Error((("Forbidden value (" + this.serverId) + ") on element of SelectedServerRefusedMessage.serverId.")));
            };
            this.error = input.readByte();
            if (this.error < 0)
            {
                throw (new Error((("Forbidden value (" + this.error) + ") on element of SelectedServerRefusedMessage.error.")));
            };
            this.serverStatus = input.readByte();
            if (this.serverStatus < 0)
            {
                throw (new Error((("Forbidden value (" + this.serverStatus) + ") on element of SelectedServerRefusedMessage.serverStatus.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.connection

