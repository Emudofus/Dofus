package com.ankamagames.dofus.network.messages.game.pvp
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class AlignmentRankUpdateMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var alignmentRank:uint = 0;
        public var verbose:Boolean = false;
        public static const protocolId:uint = 6058;

        public function AlignmentRankUpdateMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6058;
        }// end function

        public function initAlignmentRankUpdateMessage(param1:uint = 0, param2:Boolean = false) : AlignmentRankUpdateMessage
        {
            this.alignmentRank = param1;
            this.verbose = param2;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.alignmentRank = 0;
            this.verbose = false;
            this._isInitialized = false;
            return;
        }// end function

        override public function pack(param1:IDataOutput) : void
        {
            var _loc_2:* = new ByteArray();
            this.serialize(_loc_2);
            writePacket(param1, this.getMessageId(), _loc_2);
            return;
        }// end function

        override public function unpack(param1:IDataInput, param2:uint) : void
        {
            this.deserialize(param1);
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_AlignmentRankUpdateMessage(param1);
            return;
        }// end function

        public function serializeAs_AlignmentRankUpdateMessage(param1:IDataOutput) : void
        {
            if (this.alignmentRank < 0)
            {
                throw new Error("Forbidden value (" + this.alignmentRank + ") on element alignmentRank.");
            }
            param1.writeByte(this.alignmentRank);
            param1.writeBoolean(this.verbose);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_AlignmentRankUpdateMessage(param1);
            return;
        }// end function

        public function deserializeAs_AlignmentRankUpdateMessage(param1:IDataInput) : void
        {
            this.alignmentRank = param1.readByte();
            if (this.alignmentRank < 0)
            {
                throw new Error("Forbidden value (" + this.alignmentRank + ") on element of AlignmentRankUpdateMessage.alignmentRank.");
            }
            this.verbose = param1.readBoolean();
            return;
        }// end function

    }
}
