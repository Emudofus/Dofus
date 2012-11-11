package com.ankamagames.dofus.network.messages.game.context.roleplay.purchasable
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PurchasableDialogMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var buyOrSell:Boolean = false;
        public var purchasableId:uint = 0;
        public var price:uint = 0;
        public static const protocolId:uint = 5739;

        public function PurchasableDialogMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5739;
        }// end function

        public function initPurchasableDialogMessage(param1:Boolean = false, param2:uint = 0, param3:uint = 0) : PurchasableDialogMessage
        {
            this.buyOrSell = param1;
            this.purchasableId = param2;
            this.price = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.buyOrSell = false;
            this.purchasableId = 0;
            this.price = 0;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_PurchasableDialogMessage(param1);
            return;
        }// end function

        public function serializeAs_PurchasableDialogMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.buyOrSell);
            if (this.purchasableId < 0)
            {
                throw new Error("Forbidden value (" + this.purchasableId + ") on element purchasableId.");
            }
            param1.writeInt(this.purchasableId);
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element price.");
            }
            param1.writeInt(this.price);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PurchasableDialogMessage(param1);
            return;
        }// end function

        public function deserializeAs_PurchasableDialogMessage(param1:IDataInput) : void
        {
            this.buyOrSell = param1.readBoolean();
            this.purchasableId = param1.readInt();
            if (this.purchasableId < 0)
            {
                throw new Error("Forbidden value (" + this.purchasableId + ") on element of PurchasableDialogMessage.purchasableId.");
            }
            this.price = param1.readInt();
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element of PurchasableDialogMessage.price.");
            }
            return;
        }// end function

    }
}
