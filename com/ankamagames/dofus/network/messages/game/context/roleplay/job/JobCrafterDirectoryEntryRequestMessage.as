package com.ankamagames.dofus.network.messages.game.context.roleplay.job
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class JobCrafterDirectoryEntryRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6043;

        private var _isInitialized:Boolean = false;
        public var playerId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6043);
        }

        public function initJobCrafterDirectoryEntryRequestMessage(playerId:uint=0):JobCrafterDirectoryEntryRequestMessage
        {
            this.playerId = playerId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
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
            this.serializeAs_JobCrafterDirectoryEntryRequestMessage(output);
        }

        public function serializeAs_JobCrafterDirectoryEntryRequestMessage(output:ICustomDataOutput):void
        {
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element playerId.")));
            };
            output.writeVarInt(this.playerId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_JobCrafterDirectoryEntryRequestMessage(input);
        }

        public function deserializeAs_JobCrafterDirectoryEntryRequestMessage(input:ICustomDataInput):void
        {
            this.playerId = input.readVarUhInt();
            if (this.playerId < 0)
            {
                throw (new Error((("Forbidden value (" + this.playerId) + ") on element of JobCrafterDirectoryEntryRequestMessage.playerId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.job

