package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MimicryObjectPreviewMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6458;

        private var _isInitialized:Boolean = false;
        public var result:ObjectItem;

        public function MimicryObjectPreviewMessage()
        {
            this.result = new ObjectItem();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6458);
        }

        public function initMimicryObjectPreviewMessage(result:ObjectItem=null):MimicryObjectPreviewMessage
        {
            this.result = result;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.result = new ObjectItem();
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
            this.serializeAs_MimicryObjectPreviewMessage(output);
        }

        public function serializeAs_MimicryObjectPreviewMessage(output:ICustomDataOutput):void
        {
            this.result.serializeAs_ObjectItem(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MimicryObjectPreviewMessage(input);
        }

        public function deserializeAs_MimicryObjectPreviewMessage(input:ICustomDataInput):void
        {
            this.result = new ObjectItem();
            this.result.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

