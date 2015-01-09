package com.ankamagames.dofus.network.messages.game.pvp
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class AlignmentRankUpdateMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6058;

        private var _isInitialized:Boolean = false;
        public var alignmentRank:uint = 0;
        public var verbose:Boolean = false;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6058);
        }

        public function initAlignmentRankUpdateMessage(alignmentRank:uint=0, verbose:Boolean=false):AlignmentRankUpdateMessage
        {
            this.alignmentRank = alignmentRank;
            this.verbose = verbose;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.alignmentRank = 0;
            this.verbose = false;
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
            this.serializeAs_AlignmentRankUpdateMessage(output);
        }

        public function serializeAs_AlignmentRankUpdateMessage(output:IDataOutput):void
        {
            if (this.alignmentRank < 0)
            {
                throw (new Error((("Forbidden value (" + this.alignmentRank) + ") on element alignmentRank.")));
            };
            output.writeByte(this.alignmentRank);
            output.writeBoolean(this.verbose);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_AlignmentRankUpdateMessage(input);
        }

        public function deserializeAs_AlignmentRankUpdateMessage(input:IDataInput):void
        {
            this.alignmentRank = input.readByte();
            if (this.alignmentRank < 0)
            {
                throw (new Error((("Forbidden value (" + this.alignmentRank) + ") on element of AlignmentRankUpdateMessage.alignmentRank.")));
            };
            this.verbose = input.readBoolean();
        }


    }
}//package com.ankamagames.dofus.network.messages.game.pvp

