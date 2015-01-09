package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemNotInContainer;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeModifiedPaymentForCraftMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5832;

        private var _isInitialized:Boolean = false;
        public var onlySuccess:Boolean = false;
        public var object:ObjectItemNotInContainer;

        public function ExchangeModifiedPaymentForCraftMessage()
        {
            this.object = new ObjectItemNotInContainer();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5832);
        }

        public function initExchangeModifiedPaymentForCraftMessage(onlySuccess:Boolean=false, object:ObjectItemNotInContainer=null):ExchangeModifiedPaymentForCraftMessage
        {
            this.onlySuccess = onlySuccess;
            this.object = object;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.onlySuccess = false;
            this.object = new ObjectItemNotInContainer();
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
            this.serializeAs_ExchangeModifiedPaymentForCraftMessage(output);
        }

        public function serializeAs_ExchangeModifiedPaymentForCraftMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.onlySuccess);
            this.object.serializeAs_ObjectItemNotInContainer(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeModifiedPaymentForCraftMessage(input);
        }

        public function deserializeAs_ExchangeModifiedPaymentForCraftMessage(input:ICustomDataInput):void
        {
            this.onlySuccess = input.readBoolean();
            this.object = new ObjectItemNotInContainer();
            this.object.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

