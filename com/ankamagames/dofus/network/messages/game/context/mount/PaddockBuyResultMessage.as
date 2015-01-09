package com.ankamagames.dofus.network.messages.game.context.mount
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class PaddockBuyResultMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6516;

        private var _isInitialized:Boolean = false;
        public var paddockId:int = 0;
        public var bought:Boolean = false;
        public var realPrice:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6516);
        }

        public function initPaddockBuyResultMessage(paddockId:int=0, bought:Boolean=false, realPrice:uint=0):PaddockBuyResultMessage
        {
            this.paddockId = paddockId;
            this.bought = bought;
            this.realPrice = realPrice;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.paddockId = 0;
            this.bought = false;
            this.realPrice = 0;
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
            this.serializeAs_PaddockBuyResultMessage(output);
        }

        public function serializeAs_PaddockBuyResultMessage(output:IDataOutput):void
        {
            output.writeInt(this.paddockId);
            output.writeBoolean(this.bought);
            if (this.realPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.realPrice) + ") on element realPrice.")));
            };
            output.writeInt(this.realPrice);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PaddockBuyResultMessage(input);
        }

        public function deserializeAs_PaddockBuyResultMessage(input:IDataInput):void
        {
            this.paddockId = input.readInt();
            this.bought = input.readBoolean();
            this.realPrice = input.readInt();
            if (this.realPrice < 0)
            {
                throw (new Error((("Forbidden value (" + this.realPrice) + ") on element of PaddockBuyResultMessage.realPrice.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.mount

