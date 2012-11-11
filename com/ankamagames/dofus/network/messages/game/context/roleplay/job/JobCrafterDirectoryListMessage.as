package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class JobCrafterDirectoryListMessage extends NetworkMessage implements INetworkMessage
    {
        private var _isInitialized:Boolean = false;
        public var listEntries:Vector.<JobCrafterDirectoryListEntry>;
        public static const protocolId:uint = 6046;

        public function JobCrafterDirectoryListMessage()
        {
            this.listEntries = new Vector.<JobCrafterDirectoryListEntry>;
            return;
        }// end function

        override public function get isInitialized() : Boolean
        {
            return this._isInitialized;
        }// end function

        override public function getMessageId() : uint
        {
            return 6046;
        }// end function

        public function initJobCrafterDirectoryListMessage(param1:Vector.<JobCrafterDirectoryListEntry> = null) : JobCrafterDirectoryListMessage
        {
            this.listEntries = param1;
            this._isInitialized = true;
            return this;
        }// end function

        override public function reset() : void
        {
            this.listEntries = new Vector.<JobCrafterDirectoryListEntry>;
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
            this.serializeAs_JobCrafterDirectoryListMessage(param1);
            return;
        }// end function

        public function serializeAs_JobCrafterDirectoryListMessage(param1:IDataOutput) : void
        {
            param1.writeShort(this.listEntries.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.listEntries.length)
            {
                
                (this.listEntries[_loc_2] as JobCrafterDirectoryListEntry).serializeAs_JobCrafterDirectoryListEntry(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_JobCrafterDirectoryListMessage(param1);
            return;
        }// end function

        public function deserializeAs_JobCrafterDirectoryListMessage(param1:IDataInput) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = new JobCrafterDirectoryListEntry();
                _loc_4.deserialize(param1);
                this.listEntries.push(_loc_4);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
