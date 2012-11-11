package com.ankamagames.dofus.network.messages.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutBarSwapRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var barType:uint = 0;
        public var firstSlot:uint = 0;
        public var secondSlot:uint = 0;
        public static const protocolId:uint = 6230;

        public function ShortcutBarSwapRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6230;
        }// end function

        public function initShortcutBarSwapRequestMessage(param1:uint = 0, param2:uint = 0, param3:uint = 0) : ShortcutBarSwapRequestMessage
        {
            this.barType = param1;
            this.firstSlot = param2;
            this.secondSlot = param3;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.barType = 0;
            this.firstSlot = 0;
            this.secondSlot = 0;
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
            this.serializeAs_ShortcutBarSwapRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_ShortcutBarSwapRequestMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.barType);
            if (this.firstSlot < 0 || this.firstSlot > 99)
            {
                throw new Error("Forbidden value (" + this.firstSlot + ") on element firstSlot.");
            }
            param1.writeInt(this.firstSlot);
            if (this.secondSlot < 0 || this.secondSlot > 99)
            {
                throw new Error("Forbidden value (" + this.secondSlot + ") on element secondSlot.");
            }
            param1.writeInt(this.secondSlot);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutBarSwapRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutBarSwapRequestMessage(param1:IDataInput) : void
        {
            this.barType = param1.readByte();
            if (this.barType < 0)
            {
                throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarSwapRequestMessage.barType.");
            }
            this.firstSlot = param1.readInt();
            if (this.firstSlot < 0 || this.firstSlot > 99)
            {
                throw new Error("Forbidden value (" + this.firstSlot + ") on element of ShortcutBarSwapRequestMessage.firstSlot.");
            }
            this.secondSlot = param1.readInt();
            if (this.secondSlot < 0 || this.secondSlot > 99)
            {
                throw new Error("Forbidden value (" + this.secondSlot + ") on element of ShortcutBarSwapRequestMessage.secondSlot.");
            }
            return;
        }// end function

    }
}
