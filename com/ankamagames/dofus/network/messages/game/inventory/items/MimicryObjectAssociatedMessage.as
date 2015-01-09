package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class MimicryObjectAssociatedMessage extends SymbioticObjectAssociatedMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6462;

        private var _isInitialized:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6462);
        }

        public function initMimicryObjectAssociatedMessage(hostUID:uint=0):MimicryObjectAssociatedMessage
        {
            super.initSymbioticObjectAssociatedMessage(hostUID);
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
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

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_MimicryObjectAssociatedMessage(output);
        }

        public function serializeAs_MimicryObjectAssociatedMessage(output:ICustomDataOutput):void
        {
            super.serializeAs_SymbioticObjectAssociatedMessage(output);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_MimicryObjectAssociatedMessage(input);
        }

        public function deserializeAs_MimicryObjectAssociatedMessage(input:ICustomDataInput):void
        {
            super.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

