package com.ankamagames.dofus.network.messages.game.shortcut
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    [Trusted]
    public class ShortcutBarContentMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6231;

        private var _isInitialized:Boolean = false;
        public var barType:uint = 0;
        public var shortcuts:Vector.<Shortcut>;

        public function ShortcutBarContentMessage()
        {
            this.shortcuts = new Vector.<Shortcut>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6231);
        }

        public function initShortcutBarContentMessage(barType:uint=0, shortcuts:Vector.<Shortcut>=null):ShortcutBarContentMessage
        {
            this.barType = barType;
            this.shortcuts = shortcuts;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.barType = 0;
            this.shortcuts = new Vector.<Shortcut>();
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
            this.serializeAs_ShortcutBarContentMessage(output);
        }

        public function serializeAs_ShortcutBarContentMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.barType);
            output.writeShort(this.shortcuts.length);
            var _i2:uint;
            while (_i2 < this.shortcuts.length)
            {
                output.writeShort((this.shortcuts[_i2] as Shortcut).getTypeId());
                (this.shortcuts[_i2] as Shortcut).serialize(output);
                _i2++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ShortcutBarContentMessage(input);
        }

        public function deserializeAs_ShortcutBarContentMessage(input:ICustomDataInput):void
        {
            var _id2:uint;
            var _item2:Shortcut;
            this.barType = input.readByte();
            if (this.barType < 0)
            {
                throw (new Error((("Forbidden value (" + this.barType) + ") on element of ShortcutBarContentMessage.barType.")));
            };
            var _shortcutsLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _shortcutsLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(Shortcut, _id2);
                _item2.deserialize(input);
                this.shortcuts.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.shortcut

