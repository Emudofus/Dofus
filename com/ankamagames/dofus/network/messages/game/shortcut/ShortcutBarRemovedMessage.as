package com.ankamagames.dofus.network.messages.game.shortcut
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutBarRemovedMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var barType:uint = 0;
        public var slot:uint = 0;
        public static const protocolId:uint = 6224;

        public function ShortcutBarRemovedMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6224;
        }// end function

        public function initShortcutBarRemovedMessage(param1:uint = 0, param2:uint = 0) : ShortcutBarRemovedMessage
        {
            this.barType = param1;
            this.slot = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.barType = 0;
            this.slot = 0;
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
            this.serializeAs_ShortcutBarRemovedMessage(param1);
            return;
        }// end function

        public function serializeAs_ShortcutBarRemovedMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.barType);
            if (this.slot < 0 || this.slot > 99)
            {
                throw new Error("Forbidden value (" + this.slot + ") on element slot.");
            }
            param1.writeInt(this.slot);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutBarRemovedMessage(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutBarRemovedMessage(param1:IDataInput) : void
        {
            this.barType = param1.readByte();
            if (this.barType < 0)
            {
                throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarRemovedMessage.barType.");
            }
            this.slot = param1.readInt();
            if (this.slot < 0 || this.slot > 99)
            {
                throw new Error("Forbidden value (" + this.slot + ") on element of ShortcutBarRemovedMessage.slot.");
            }
            return;
        }// end function

    }
}
