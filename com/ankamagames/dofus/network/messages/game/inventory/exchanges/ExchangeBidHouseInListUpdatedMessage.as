package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeBidHouseInListUpdatedMessage extends ExchangeBidHouseInListAddedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6337;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6337);
        }

        public function initExchangeBidHouseInListUpdatedMessage(itemUID:int=0, objGenericId:int=0, effects:Vector.<ObjectEffect>=null, prices:Vector.<uint>=null):ExchangeBidHouseInListUpdatedMessage
        {
            super.initExchangeBidHouseInListAddedMessage(itemUID, objGenericId, effects, prices);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_ExchangeBidHouseInListUpdatedMessage(output);
        }

        public function serializeAs_ExchangeBidHouseInListUpdatedMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeBidHouseInListAddedMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeBidHouseInListUpdatedMessage(input);
        }

        public function deserializeAs_ExchangeBidHouseInListUpdatedMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

