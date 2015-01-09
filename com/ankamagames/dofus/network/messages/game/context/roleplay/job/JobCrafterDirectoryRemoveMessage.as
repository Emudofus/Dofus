package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class JobCrafterDirectoryRemoveMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5653;

        private var _isInitialized:Boolean = false;
        public var jobId:uint = 0;
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5653);
        }

        public function initJobCrafterDirectoryRemoveMessage(jobId:uint=0, playerId:uint=0):JobCrafterDirectoryRemoveMessage
        {
            this.jobId = jobId;
            this.playerId = playerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.jobId = 0;
            this.playerId = 0;
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
            this.serializeAs_JobCrafterDirectoryRemoveMessage(output);
        }

        public function serializeAs_JobCrafterDirectoryRemoveMessage(output:ICustomDataOutput):void
        {
            if (this.jobId < 0)
            {
                throw (new Error((("Forbidden value (" + this.jobId) + ") on element jobId.")));
            };
            output.writeByte(this.jobId);
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobCrafterDirectoryRemoveMessage(input);
        }

        public function deserializeAs_JobCrafterDirectoryRemoveMessage(input:ICustomDataInput):void
        {
            this.jobId = input.readByte();
            if (this.jobId < 0)
            {
                throw (new Error((("Forbidden value (" + this.jobId) + ") on element of JobCrafterDirectoryRemoveMessage.jobId.")));
            };
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of JobCrafterDirectoryRemoveMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

