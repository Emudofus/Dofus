package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobCrafterDirectoryListEntry;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class JobCrafterDirectoryAddMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5651;

        private var _isInitialized:Boolean = false;
        public var listEntry:JobCrafterDirectoryListEntry;

        public function JobCrafterDirectoryAddMessage()
        {
            this.listEntry = new JobCrafterDirectoryListEntry();
            super();
        }

        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5651);
        }

        public function initJobCrafterDirectoryAddMessage(listEntry:JobCrafterDirectoryListEntry=null):JobCrafterDirectoryAddMessage
        {
            this.listEntry = listEntry;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.listEntry = new JobCrafterDirectoryListEntry();
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
            this.serializeAs_JobCrafterDirectoryAddMessage(output);
        }

        public function serializeAs_JobCrafterDirectoryAddMessage(output:ICustomDataOutput):void
        {
            this.listEntry.serializeAs_JobCrafterDirectoryListEntry(output);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobCrafterDirectoryAddMessage(input);
        }

        public function deserializeAs_JobCrafterDirectoryAddMessage(input:ICustomDataInput):void
        {
            this.listEntry = new JobCrafterDirectoryListEntry();
            this.listEntry.deserialize(input);
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

