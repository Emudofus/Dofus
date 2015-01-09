package com.ankamagames.dofus.network.messages.game.inventory.items
{
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class MimicryObjectFeedAndAssociateRequestMessage extends SymbioticObjectAssociateRequestMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6460;

        private var _isInitialized:Boolean = false;
        public var foodUID:uint = 0;
        public var foodPos:uint = 0;
        public var preview:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (((super.isInitialized) && (this._isInitialized)));
        }

        override public function getMessageId():uint
        {
            return (6460);
        }

        public function initMimicryObjectFeedAndAssociateRequestMessage(symbioteUID:uint=0, symbiotePos:uint=0, hostUID:uint=0, hostPos:uint=0, foodUID:uint=0, foodPos:uint=0, preview:Boolean=false):MimicryObjectFeedAndAssociateRequestMessage
        {
            super.initSymbioticObjectAssociateRequestMessage(symbioteUID, symbiotePos, hostUID, hostPos);
            this.foodUID = foodUID;
            this.foodPos = foodPos;
            this.preview = preview;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.foodUID = 0;
            this.foodPos = 0;
            this.preview = false;
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

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_MimicryObjectFeedAndAssociateRequestMessage(output);
        }

        public function serializeAs_MimicryObjectFeedAndAssociateRequestMessage(output:IDataOutput):void
        {
            super.serializeAs_SymbioticObjectAssociateRequestMessage(output);
            if (this.foodUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.foodUID) + ") on element foodUID.")));
            };
            output.writeInt(this.foodUID);
            if ((((this.foodPos < 0)) || ((this.foodPos > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.foodPos) + ") on element foodPos.")));
            };
            output.writeByte(this.foodPos);
            output.writeBoolean(this.preview);
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(input);
        }

        public function deserializeAs_MimicryObjectFeedAndAssociateRequestMessage(input:IDataInput):void
        {
            super.deserialize(input);
            this.foodUID = input.readInt();
            if (this.foodUID < 0)
            {
                throw (new Error((("Forbidden value (" + this.foodUID) + ") on element of MimicryObjectFeedAndAssociateRequestMessage.foodUID.")));
            };
            this.foodPos = input.readUnsignedByte();
            if ((((this.foodPos < 0)) || ((this.foodPos > 0xFF))))
            {
                throw (new Error((("Forbidden value (" + this.foodPos) + ") on element of MimicryObjectFeedAndAssociateRequestMessage.foodPos.")));
            };
            this.preview = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.inventory.items

