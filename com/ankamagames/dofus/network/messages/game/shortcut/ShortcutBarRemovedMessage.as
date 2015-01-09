package com.ankamagames.dofus.network.messages.game.shortcut
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ShortcutBarRemovedMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6224;

        private var _isInitialized:Boolean = false;
        public var barType:uint = 0;
        public var slot:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6224);
        }

        public function initShortcutBarRemovedMessage(barType:uint=0, slot:uint=0):ShortcutBarRemovedMessage
        {
            this.barType = barType;
            this.slot = slot;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.barType = 0;
            this.slot = 0;
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
            this.serializeAs_ShortcutBarRemovedMessage(output);
        }

        public function serializeAs_ShortcutBarRemovedMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.barType);
            if ((((this.slot < 0)) || ((this.slot > 99))))
            {
                throw (new Error((("Forbidden value (" + this.slot) + ") on element slot.")));
            };
            output.writeByte(this.slot);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ShortcutBarRemovedMessage(input);
        }

        public function deserializeAs_ShortcutBarRemovedMessage(input:ICustomDataInput):void
        {
            this.barType = input.readByte();
            if (this.barType < 0)
            {
                throw (new Error((("Forbidden value (" + this.barType) + ") on element of ShortcutBarRemovedMessage.barType.")));
            };
            this.slot = input.readByte();
            if ((((this.slot < 0)) || ((this.slot > 99))))
            {
                throw (new Error((("Forbidden value (" + this.slot) + ") on element of ShortcutBarRemovedMessage.slot.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.shortcut

