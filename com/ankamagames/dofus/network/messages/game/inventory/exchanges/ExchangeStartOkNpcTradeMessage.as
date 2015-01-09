package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeStartOkNpcTradeMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5785;

        private var _isInitialized:Boolean = false;
        public var npcId:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5785);
        }

        public function initExchangeStartOkNpcTradeMessage(npcId:int=0):ExchangeStartOkNpcTradeMessage
        {
            this.npcId = npcId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.npcId = 0;
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
            this.serializeAs_ExchangeStartOkNpcTradeMessage(output);
        }

        public function serializeAs_ExchangeStartOkNpcTradeMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.npcId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeStartOkNpcTradeMessage(input);
        }

        public function deserializeAs_ExchangeStartOkNpcTradeMessage(input:ICustomDataInput):void
        {
            this.npcId = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

