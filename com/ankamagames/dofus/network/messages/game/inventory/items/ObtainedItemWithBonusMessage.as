package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class ObtainedItemWithBonusMessage extends ObtainedItemMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6520;

        private var _isInitialized:Boolean = false;
        public var bonusQuantity:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6520);
        }

        public function initObtainedItemWithBonusMessage(genericId:uint=0, baseQuantity:uint=0, bonusQuantity:uint=0):ObtainedItemWithBonusMessage
        {
            super.initObtainedItemMessage(genericId, baseQuantity);
            this.bonusQuantity = bonusQuantity;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.bonusQuantity = 0;
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

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ObtainedItemWithBonusMessage(output);
        }

        public function serializeAs_ObtainedItemWithBonusMessage(output:IDataOutput):void
        {
            super.serializeAs_ObtainedItemMessage(output);
            if (this.bonusQuantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.bonusQuantity) + ") on element bonusQuantity.")));
            };
            output.writeInt(this.bonusQuantity);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ObtainedItemWithBonusMessage(input);
        }

        public function deserializeAs_ObtainedItemWithBonusMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.bonusQuantity = input.readInt();
            if (this.bonusQuantity < 0)
            {
                throw (new Error((("Forbidden value (" + this.bonusQuantity) + ") on element of ObtainedItemWithBonusMessage.bonusQuantity.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

