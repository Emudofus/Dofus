package com.ankamagames.dofus.network.messages.game.shortcut
{
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.shortcut.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutBarAddRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var barType:uint = 0;
        public var shortcut:Shortcut;
        public static const protocolId:uint = 6225;

        public function ShortcutBarAddRequestMessage()
        {
            this.shortcut = new Shortcut();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6225;
        }// end function

        public function initShortcutBarAddRequestMessage(param1:uint = 0, param2:Shortcut = null) : ShortcutBarAddRequestMessage
        {
            this.barType = param1;
            this.shortcut = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.barType = 0;
            this.shortcut = new Shortcut();
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
            this.serializeAs_ShortcutBarAddRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_ShortcutBarAddRequestMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.barType);
            param1.writeShort(this.shortcut.getTypeId());
            this.shortcut.serialize(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutBarAddRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutBarAddRequestMessage(param1:IDataInput) : void
        {
            this.barType = param1.readByte();
            if (this.barType < 0)
            {
                throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarAddRequestMessage.barType.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            this.shortcut = ProtocolTypeManager.getInstance(Shortcut, _loc_2);
            this.shortcut.deserialize(param1);
            return;
        }// end function

    }
}
