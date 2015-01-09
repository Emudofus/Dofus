package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeReplayCountModifiedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6023;

        private var _isInitialized:Boolean = false;
        public var count:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6023);
        }

        public function initExchangeReplayCountModifiedMessage(count:int=0):ExchangeReplayCountModifiedMessage
        {
            this.count = count;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.count = 0;
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
            this.serializeAs_ExchangeReplayCountModifiedMessage(output);
        }

        public function serializeAs_ExchangeReplayCountModifiedMessage(output:ICustomDataOutput):void
        {
            output.writeVarInt(this.count);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeReplayCountModifiedMessage(input);
        }

        public function deserializeAs_ExchangeReplayCountModifiedMessage(input:ICustomDataInput):void
        {
            this.count = input.readVarInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

