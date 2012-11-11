package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobCrafterDirectoryEntryRequestMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;
        public static const protocolId:uint = 6043;

        public function JobCrafterDirectoryEntryRequestMessage()
        {
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6043;
        }// end function

        public function initJobCrafterDirectoryEntryRequestMessage(param1:uint = 0) : JobCrafterDirectoryEntryRequestMessage
        {
            this.playerId = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.playerId = 0;
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
            this.serializeAs_JobCrafterDirectoryEntryRequestMessage(param1);
            return;
        }// end function

        public function serializeAs_JobCrafterDirectoryEntryRequestMessage(param1:IDataOutput) : void
        {
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
            }
            param1.writeInt(this.playerId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobCrafterDirectoryEntryRequestMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobCrafterDirectoryEntryRequestMessage(param1:IDataInput) : void
        {
            this.playerId = param1.readInt();
            if (this.playerId < 0)
            {
                throw new Error("Forbidden value (" + this.playerId + ") on element of JobCrafterDirectoryEntryRequestMessage.playerId.");
            }
            return;
        }// end function

    }
}
