package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class TreasureHuntLegendaryRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6499;

        private var _isInitialized:Boolean = false;
        public var legendaryId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6499);
        }

        public function initTreasureHuntLegendaryRequestMessage(legendaryId:uint=0):TreasureHuntLegendaryRequestMessage
        {
            this.legendaryId = legendaryId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.legendaryId = 0;
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
            this.serializeAs_TreasureHuntLegendaryRequestMessage(output);
        }

        public function serializeAs_TreasureHuntLegendaryRequestMessage(output:IDataOutput):void
        {
            if (this.legendaryId < 0)
            {
                throw (new Error((("Forbidden value (" + this.legendaryId) + ") on element legendaryId.")));
            };
            output.writeShort(this.legendaryId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TreasureHuntLegendaryRequestMessage(input);
        }

        public function deserializeAs_TreasureHuntLegendaryRequestMessage(input:IDataInput):void
        {
            this.legendaryId = input.readShort();
            if (this.legendaryId < 0)
            {
                throw (new Error((("Forbidden value (" + this.legendaryId) + ") on element of TreasureHuntLegendaryRequestMessage.legendaryId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt

