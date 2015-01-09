package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class HouseSellRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5697;

        private var _isInitialized:Boolean = false;
        public var amount:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5697);
        }

        public function initHouseSellRequestMessage(amount:uint=0):HouseSellRequestMessage
        {
            this.amount = amount;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.amount = 0;
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
            this.serializeAs_HouseSellRequestMessage(output);
        }

        public function serializeAs_HouseSellRequestMessage(output:IDataOutput):void
        {
            if (this.amount < 0)
            {
                throw (new Error((("Forbidden value (" + this.amount) + ") on element amount.")));
            };
            output.writeInt(this.amount);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_HouseSellRequestMessage(input);
        }

        public function deserializeAs_HouseSellRequestMessage(input:IDataInput):void
        {
            this.amount = input.readInt();
            if (this.amount < 0)
            {
                throw (new Error((("Forbidden value (" + this.amount) + ") on element of HouseSellRequestMessage.amount.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.houses

