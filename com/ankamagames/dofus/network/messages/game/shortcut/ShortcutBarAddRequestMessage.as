package com.ankamagames.dofus.network.messages.game.shortcut
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;

    [Trusted]
    public class ShortcutBarAddRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6225;

        private var _isInitialized:Boolean = false;
        public var barType:uint = 0;
        public var shortcut:Shortcut;

        public function ShortcutBarAddRequestMessage()
        {
            this.shortcut = new Shortcut();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6225);
        }

        public function initShortcutBarAddRequestMessage(barType:uint=0, shortcut:Shortcut=null):ShortcutBarAddRequestMessage
        {
            this.barType = barType;
            this.shortcut = shortcut;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.barType = 0;
            this.shortcut = new Shortcut();
            this._isInitialized = false;
        }

        override public function pack(output:IDataOutput):void
        {
            var data:ByteArray = new ByteArray();
            this.serialize(data);
            writePacket(output, this.getMessageId(), data);
        }

        override public function unpack(input:IDataInput, length:uint):void
        {
            this.deserialize(input);
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_ShortcutBarAddRequestMessage(output);
        }

        public function serializeAs_ShortcutBarAddRequestMessage(output:IDataOutput):void
        {
            output.writeByte(this.barType);
            output.writeShort(this.shortcut.getTypeId());
            this.shortcut.serialize(output);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_ShortcutBarAddRequestMessage(input);
        }

        public function deserializeAs_ShortcutBarAddRequestMessage(input:IDataInput):void
        {
            this.barType = input.readByte();
            if (this.barType < 0)
            {
                throw (new Error((("Forbidden value (" + this.barType) + ") on element of ShortcutBarAddRequestMessage.barType.")));
            };
            var _id2:uint = input.readUnsignedShort();
            this.shortcut = ProtocolTypeManager.getInstance(Shortcut, _id2);
            this.shortcut.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.shortcut

