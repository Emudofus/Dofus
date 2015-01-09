package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import __AS3__.vec.Vector;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;
    import __AS3__.vec.*;

    [Trusted]
    public class JobCrafterDirectoryListMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6046;

        private var _isInitialized:Boolean = false;
        public var listEntries:Vector.<JobCrafterDirectoryListEntry>;

        public function JobCrafterDirectoryListMessage()
        {
            this.listEntries = new Vector.<JobCrafterDirectoryListEntry>();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6046);
        }

        public function initJobCrafterDirectoryListMessage(listEntries:Vector.<JobCrafterDirectoryListEntry>=null):JobCrafterDirectoryListMessage
        {
            this.listEntries = listEntries;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.listEntries = new Vector.<JobCrafterDirectoryListEntry>();
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
            this.serializeAs_JobCrafterDirectoryListMessage(output);
        }

        public function serializeAs_JobCrafterDirectoryListMessage(output:ICustomDataOutput):void
        {
            output.writeShort(this.listEntries.length);
            var _i1:uint;
            while (_i1 < this.listEntries.length)
            {
                (this.listEntries[_i1] as JobCrafterDirectoryListEntry).serializeAs_JobCrafterDirectoryListEntry(output);
                _i1++;
            };
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobCrafterDirectoryListMessage(input);
        }

        public function deserializeAs_JobCrafterDirectoryListMessage(input:ICustomDataInput):void
        {
            var _item1:JobCrafterDirectoryListEntry;
            var _listEntriesLen:uint = input.readUnsignedShort();
            var _i1:uint;
            while (_i1 < _listEntriesLen)
            {
                _item1 = new JobCrafterDirectoryListEntry();
                _item1.deserialize(input);
                this.listEntries.push(_item1);
                _i1++;
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

