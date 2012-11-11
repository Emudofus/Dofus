package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class InventoryWeightMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var weight:uint = 0;
        public var weightMax:uint = 0;
        public static const protocolId:uint = 3009;

        public function InventoryWeightMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 3009;
        }// end function

        public function initInventoryWeightMessage(param1:uint = 0, param2:uint = 0) : InventoryWeightMessage
        {
            this.weight = param1;
            this.weightMax = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.weight = 0;
            this.weightMax = 0;
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
            this.serializeAs_InventoryWeightMessage(param1);
            return;
        }// end function

        public function serializeAs_InventoryWeightMessage(param1:IDataOutput) : void
        {
            if (this.weight < 0)
            {
                throw new Error("Forbidden value (" + this.weight + ") on element weight.");
            }
            param1.writeInt(this.weight);
            if (this.weightMax < 0)
            {
                throw new Error("Forbidden value (" + this.weightMax + ") on element weightMax.");
            }
            param1.writeInt(this.weightMax);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_InventoryWeightMessage(param1);
            return;
        }// end function

        public function deserializeAs_InventoryWeightMessage(param1:IDataInput) : void
        {
            this.weight = param1.readInt();
            if (this.weight < 0)
            {
                throw new Error("Forbidden value (" + this.weight + ") on element of InventoryWeightMessage.weight.");
            }
            this.weightMax = param1.readInt();
            if (this.weightMax < 0)
            {
                throw new Error("Forbidden value (" + this.weightMax + ") on element of InventoryWeightMessage.weightMax.");
            }
            return;
        }// end function

    }
}
