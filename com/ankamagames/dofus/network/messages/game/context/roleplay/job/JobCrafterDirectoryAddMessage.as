package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobCrafterDirectoryAddMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var listEntry:JobCrafterDirectoryListEntry;
        public static const protocolId:uint = 5651;

        public function JobCrafterDirectoryAddMessage()
        {
            this.listEntry = new JobCrafterDirectoryListEntry();
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 5651;
        }// end function

        public function initJobCrafterDirectoryAddMessage(param1:JobCrafterDirectoryListEntry = null) : JobCrafterDirectoryAddMessage
        {
            this.listEntry = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.listEntry = new JobCrafterDirectoryListEntry();
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
            this.serializeAs_JobCrafterDirectoryAddMessage(param1);
            return;
        }// end function

        public function serializeAs_JobCrafterDirectoryAddMessage(param1:IDataOutput) : void
        {
            this.listEntry.serializeAs_JobCrafterDirectoryListEntry(param1);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobCrafterDirectoryAddMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobCrafterDirectoryAddMessage(param1:IDataInput) : void
        {
            this.listEntry = new JobCrafterDirectoryListEntry();
            this.listEntry.deserialize(param1);
            return;
        }// end function

    }
}
