package com.ankamagames.dofus.network.messages.game.inventory.preset
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class InventoryPresetItemUpdateErrorMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6211;

        private var _isInitialized:Boolean = false;
        public var code:uint = 1;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6211);
        }

        public function initInventoryPresetItemUpdateErrorMessage(code:uint=1):InventoryPresetItemUpdateErrorMessage
        {
            this.code = code;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.code = 1;
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
            this.serializeAs_InventoryPresetItemUpdateErrorMessage(output);
        }

        public function serializeAs_InventoryPresetItemUpdateErrorMessage(output:ICustomDataOutput):void
        {
            output.writeByte(this.code);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_InventoryPresetItemUpdateErrorMessage(input);
        }

        public function deserializeAs_InventoryPresetItemUpdateErrorMessage(input:ICustomDataInput):void
        {
            this.code = input.readByte();
            if (this.code < 0)
            {
                throw (new Error((("Forbidden value (" + this.code) + ") on element of InventoryPresetItemUpdateErrorMessage.code.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.preset

