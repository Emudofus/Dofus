package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class PaddockSellBuyDialogMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6018;

        private var _isInitialized:Boolean = false;
        public var bsell:Boolean = false;
        public var ownerId:uint = 0;
        public var price:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6018);
        }

        public function initPaddockSellBuyDialogMessage(bsell:Boolean=false, ownerId:uint=0, price:uint=0):PaddockSellBuyDialogMessage
        {
            this.bsell = bsell;
            this.ownerId = ownerId;
            this.price = price;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.bsell = false;
            this.ownerId = 0;
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
            this.serializeAs_PaddockSellBuyDialogMessage(output);
        }

        public function serializeAs_PaddockSellBuyDialogMessage(output:ICustomDataOutput):void
        {
            output.writeBoolean(this.bsell);
            if (this.ownerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.ownerId) + ") on element ownerId.")));
            };
            output.writeVarInt(this.ownerId);
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element price.")));
            };
            output.writeVarInt(this.price);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_PaddockSellBuyDialogMessage(input);
        }

        public function deserializeAs_PaddockSellBuyDialogMessage(input:ICustomDataInput):void
        {
            this.bsell = input.readBoolean();
            this.ownerId = input.readVarUhInt();
            if (this.ownerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.ownerId) + ") on element of PaddockSellBuyDialogMessage.ownerId.")));
            };
            this.price = input.readVarUhInt();
            if (this.price < 0)
            {
                throw (new Error((("Forbidden value (" + this.price) + ") on element of PaddockSellBuyDialogMessage.price.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock

