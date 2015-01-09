package com.ankamagames.dofus.network.messages.game.pvp
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class UpdateSelfAgressableStatusMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6456;

        private var _isInitialized:Boolean = false;
        public var status:uint = 0;
        public var probationTime:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6456);
        }

        public function initUpdateSelfAgressableStatusMessage(status:uint=0, probationTime:uint=0):UpdateSelfAgressableStatusMessage
        {
            this.status = status;
            this.probationTime = probationTime;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.status = 0;
            this.probationTime = 0;
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
            this.serializeAs_UpdateSelfAgressableStatusMessage(output);
        }

        public function serializeAs_UpdateSelfAgressableStatusMessage(output:IDataOutput):void
        {
            output.writeByte(this.status);
            if (this.probationTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.probationTime) + ") on element probationTime.")));
            };
            output.writeInt(this.probationTime);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_UpdateSelfAgressableStatusMessage(input);
        }

        public function deserializeAs_UpdateSelfAgressableStatusMessage(input:IDataInput):void
        {
            this.status = input.readByte();
            if (this.status < 0)
            {
                throw (new Error((("Forbidden value (" + this.status) + ") on element of UpdateSelfAgressableStatusMessage.status.")));
            };
            this.probationTime = input.readInt();
            if (this.probationTime < 0)
            {
                throw (new Error((("Forbidden value (" + this.probationTime) + ") on element of UpdateSelfAgressableStatusMessage.probationTime.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.pvp

