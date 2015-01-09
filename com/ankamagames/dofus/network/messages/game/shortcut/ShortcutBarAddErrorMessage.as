package com.ankamagames.dofus.network.messages.game.shortcut
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class ShortcutBarAddErrorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6227;

        private var _isInitialized:Boolean = false;
        public var error:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6227);
        }

        public function initShortcutBarAddErrorMessage(error:uint=0):ShortcutBarAddErrorMessage
        {
            this.error = error;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.error = 0;
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
            this.serializeAs_ShortcutBarAddErrorMessage(output);
        }

        public function serializeAs_ShortcutBarAddErrorMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.error);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_ShortcutBarAddErrorMessage(input);
        }

        public function deserializeAs_ShortcutBarAddErrorMessage(input:ICustomDataInput):void
        {
            this.error = input.readByte();
            if (this.error < 0)
            {
                throw (new Error((("Forbidden value (" + this.error) + ") on element of ShortcutBarAddErrorMessage.error.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.shortcut

