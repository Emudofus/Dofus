package com.ankamagames.dofus.network.messages.game.context.roleplay.paddock
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class PaddockSellBuyDialogMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var bsell:Boolean = false;
        public var ownerId:uint = 0;
        public var price:uint = 0;
        public static const protocolId:uint = 6018;

        public function PaddockSellBuyDialogMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6018;
        }// end function

        public function initPaddockSellBuyDialogMessage(param1:Boolean = false, param2:uint = 0, param3:uint = 0) : PaddockSellBuyDialogMessage
        {
            this.bsell = param1;
            this.ownerId = param2;
            this.price = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.bsell = false;
            this.ownerId = 0;
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
            this.serializeAs_PaddockSellBuyDialogMessage(param1);
            return;
        }// end function

        public function serializeAs_PaddockSellBuyDialogMessage(param1:IDataOutput) : void
        {
            param1.writeBoolean(this.bsell);
            if (this.ownerId < 0)
            {
                throw new Error("Forbidden value (" + this.ownerId + ") on element ownerId.");
            }
            param1.writeInt(this.ownerId);
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element price.");
            }
            param1.writeInt(this.price);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_PaddockSellBuyDialogMessage(param1);
            return;
        }// end function

        public function deserializeAs_PaddockSellBuyDialogMessage(param1:IDataInput) : void
        {
            this.bsell = param1.readBoolean();
            this.ownerId = param1.readInt();
            if (this.ownerId < 0)
            {
                throw new Error("Forbidden value (" + this.ownerId + ") on element of PaddockSellBuyDialogMessage.ownerId.");
            }
            this.price = param1.readInt();
            if (this.price < 0)
            {
                throw new Error("Forbidden value (" + this.price + ") on element of PaddockSellBuyDialogMessage.price.");
            }
            return;
        }// end function

    }
}
