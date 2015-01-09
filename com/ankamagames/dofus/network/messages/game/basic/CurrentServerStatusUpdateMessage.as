package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class CurrentServerStatusUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6525;

        private var _isInitialized:Boolean = false;
        public var status:uint = 1;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6525);
        }

        public function initCurrentServerStatusUpdateMessage(status:uint=1):CurrentServerStatusUpdateMessage
        {
            this.status = status;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.status = 1;
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
            this.serializeAs_CurrentServerStatusUpdateMessage(output);
        }

        public function serializeAs_CurrentServerStatusUpdateMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.status);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_CurrentServerStatusUpdateMessage(input);
        }

        public function deserializeAs_CurrentServerStatusUpdateMessage(input:ICustomDataInput):void
        {
            this.status = input.readByte();
            if (this.status < 0)
            {
                throw (new Error((("Forbidden value (" + this.status) + ") on element of CurrentServerStatusUpdateMessage.status.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

