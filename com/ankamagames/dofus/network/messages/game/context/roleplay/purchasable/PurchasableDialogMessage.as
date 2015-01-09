package com.ankamagames.dofus.network.messages.game.context.roleplay.purchasable
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PurchasableDialogMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5739;

        private var _isInitialized:Boolean = false;
        public var buyOrSell:Boolean = false;
        public var purchasableId:uint = 0;
        public var price:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5739);
        }

        public function initPurchasableDialogMessage(buyOrSell:Boolean=false, purchasableId:uint=0, price:uint=0):PurchasableDialogMessage
        {
            this.buyOrSell = buyOrSell;
            this.purchasableId = purchasableId;
            this.price = price;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.buyOrSell = false;
            this.purchasableId = 0;
            this.price = 0;
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
            this.serializeAs_PurchasableDialogMessage(output);
        }

        public function serializeAs_PurchasableDialogMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.buyOrSell);
            if (this.purchasableId < 0)
            {
                throw (new Error((("Forbidden value (" + this.purchasableId) + ") on element purchasableId.")));
            };
            output.writeVarInt(this.purchasableId);
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element price.")));
            };
            output.writeVarInt(this.price);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PurchasableDialogMessage(input);
        }

        public function deserializeAs_PurchasableDialogMessage(input:ICustomDataInput):void
        {
            this.buyOrSell = input.readBoolean();
            this.purchasableId = input.readVarUhInt();
            if (this.purchasableId < 0)
            {
                throw (new Error((("Forbidden value (" + this.purchasableId) + ") on element of PurchasableDialogMessage.purchasableId.")));
            };
            this.price = input.readVarUhInt();
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element of PurchasableDialogMessage.price.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.purchasable

