package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeWaitingResultMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5786;

        private var _isInitialized:Boolean = false;
        public var bwait:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5786);
        }

        public function initExchangeWaitingResultMessage(bwait:Boolean=false):ExchangeWaitingResultMessage
        {
            this.bwait = bwait;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.bwait = false;
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
            this.serializeAs_ExchangeWaitingResultMessage(output);
        }

        public function serializeAs_ExchangeWaitingResultMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.bwait);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeWaitingResultMessage(input);
        }

        public function deserializeAs_ExchangeWaitingResultMessage(input:ICustomDataInput):void
        {
            this.bwait = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

