package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeBidHouseInListRemovedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5950;

        private var _isInitialized:Boolean = false;
        public var itemUID:int = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5950);
        }

        public function initExchangeBidHouseInListRemovedMessage(itemUID:int=0):ExchangeBidHouseInListRemovedMessage
        {
            this.itemUID = itemUID;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.itemUID = 0;
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
            this.serializeAs_ExchangeBidHouseInListRemovedMessage(output);
        }

        public function serializeAs_ExchangeBidHouseInListRemovedMessage(output:ICustomDataOutput):void
        {
            output.writeInt(this.itemUID);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBidHouseInListRemovedMessage(input);
        }

        public function deserializeAs_ExchangeBidHouseInListRemovedMessage(input:ICustomDataInput):void
        {
            this.itemUID = input.readInt();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

