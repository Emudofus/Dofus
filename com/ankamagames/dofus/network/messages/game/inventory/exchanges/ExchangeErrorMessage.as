package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeErrorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5513;

        private var _isInitialized:Boolean = false;
        public var errorType:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5513);
        }

        public function initExchangeErrorMessage(errorType:int=0):ExchangeErrorMessage
        {
            this.errorType = errorType;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.errorType = 0;
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
            this.serializeAs_ExchangeErrorMessage(output);
        }

        public function serializeAs_ExchangeErrorMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.errorType);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeErrorMessage(input);
        }

        public function deserializeAs_ExchangeErrorMessage(input:ICustomDataInput):void
        {
            this.errorType = input.readByte();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

