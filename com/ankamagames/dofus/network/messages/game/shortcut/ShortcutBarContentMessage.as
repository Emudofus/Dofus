package com.ankamagames.dofus.network.messages.game.shortcut
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.dofus.network.types.game.shortcut.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class ShortcutBarContentMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var barType:uint = 0;
        public var shortcuts:Vector.<Shortcut>;
        public static const protocolId:uint = 6231;

        public function ShortcutBarContentMessage()
        {
            this.shortcuts = new Vector.<Shortcut>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6231;
        }// end function

        public function initShortcutBarContentMessage(param1:uint = 0, param2:Vector.<Shortcut> = null) : ShortcutBarContentMessage
        {
            this.barType = param1;
            this.shortcuts = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.barType = 0;
            this.shortcuts = new Vector.<Shortcut>;
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
            this.serializeAs_ShortcutBarContentMessage(param1);
            return;
        }// end function

        public function serializeAs_ShortcutBarContentMessage(param1:IDataOutput) : void
        {
            param1.writeByte(this.barType);
            param1.writeShort(this.shortcuts.length);
            var _loc_2:uint = 0;
            while (_loc_2 < this.shortcuts.length)
            {
                
                param1.writeShort((this.shortcuts[_loc_2] as Shortcut).getTypeId());
                (this.shortcuts[_loc_2] as Shortcut).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_ShortcutBarContentMessage(param1);
            return;
        }// end function

        public function deserializeAs_ShortcutBarContentMessage(param1:IDataInput) : void
        {
            var _loc_4:uint = 0;
            var _loc_5:Shortcut = null;
            this.barType = param1.readByte();
            if (this.barType < 0)
            {
                throw new Error("Forbidden value (" + this.barType + ") on element of ShortcutBarContentMessage.barType.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:uint = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(Shortcut, _loc_4);
                _loc_5.deserialize(param1);
                this.shortcuts.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
