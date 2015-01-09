package com.ankamagames.dofus.network.messages.game.prism
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class PrismFightSwapRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5901;

        private var _isInitialized:Boolean = false;
        public var subAreaId:uint = 0;
        public var targetId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5901);
        }

        public function initPrismFightSwapRequestMessage(subAreaId:uint=0, targetId:uint=0):PrismFightSwapRequestMessage
        {
            this.subAreaId = subAreaId;
            this.targetId = targetId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.subAreaId = 0;
            this.targetId = 0;
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
            this.serializeAs_PrismFightSwapRequestMessage(output);
        }

        public function serializeAs_PrismFightSwapRequestMessage(output:IDataOutput):void
        {
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element subAreaId.")));
            };
            output.writeShort(this.subAreaId);
            if (this.targetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.targetId) + ") on element targetId.")));
            };
            output.writeInt(this.targetId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_PrismFightSwapRequestMessage(input);
        }

        public function deserializeAs_PrismFightSwapRequestMessage(input:IDataInput):void
        {
            this.subAreaId = input.readShort();
            if (this.subAreaId < 0)
            {
                throw (new Error((("Forbidden value (" + this.subAreaId) + ") on element of PrismFightSwapRequestMessage.subAreaId.")));
            };
            this.targetId = input.readInt();
            if (this.targetId < 0)
            {
                throw (new Error((("Forbidden value (" + this.targetId) + ") on element of PrismFightSwapRequestMessage.targetId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.prism

