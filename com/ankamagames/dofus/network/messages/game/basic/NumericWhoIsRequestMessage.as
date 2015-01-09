package com.ankamagames.dofus.network.messages.game.basic
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class NumericWhoIsRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6298;

        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6298);
        }

        public function initNumericWhoIsRequestMessage(playerId:uint=0):NumericWhoIsRequestMessage
        {
            this.playerId = playerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.playerId = 0;
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
            this.serializeAs_NumericWhoIsRequestMessage(output);
        }

        public function serializeAs_NumericWhoIsRequestMessage(output:IDataOutput):void
        {
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeInt(this.playerId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_NumericWhoIsRequestMessage(input);
        }

        public function deserializeAs_NumericWhoIsRequestMessage(input:IDataInput):void
        {
            this.playerId = input.readInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of NumericWhoIsRequestMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.basic

