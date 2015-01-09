package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItemNotInContainer;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ExchangeCraftResultWithObjectDescMessage extends ExchangeCraftResultMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5999;

        private var _isInitialized:Boolean = false;
        public var objectInfo:ObjectItemNotInContainer;

        public function ExchangeCraftResultWithObjectDescMessage()
        {
            this.objectInfo = new ObjectItemNotInContainer();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (5999);
        }

        public function initExchangeCraftResultWithObjectDescMessage(craftResult:uint=0, objectInfo:ObjectItemNotInContainer=null):ExchangeCraftResultWithObjectDescMessage
        {
            super.initExchangeCraftResultMessage(craftResult);
            this.objectInfo = objectInfo;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.objectInfo = new ObjectItemNotInContainer();
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
            this.serializeAs_ExchangeCraftResultWithObjectDescMessage(output);
        }

        public function serializeAs_ExchangeCraftResultWithObjectDescMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_ExchangeCraftResultMessage(output);
            this.objectInfo.serializeAs_ObjectItemNotInContainer(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ExchangeCraftResultWithObjectDescMessage(input);
        }

        public function deserializeAs_ExchangeCraftResultWithObjectDescMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.objectInfo = new ObjectItemNotInContainer();
            this.objectInfo.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.exchanges

