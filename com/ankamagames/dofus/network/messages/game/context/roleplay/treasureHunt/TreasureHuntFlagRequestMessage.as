package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class TreasureHuntFlagRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6508;

        private var _isInitialized:Boolean = false;
        public var questType:uint = 0;
        public var index:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6508);
        }

        public function initTreasureHuntFlagRequestMessage(questType:uint=0, index:uint=0):TreasureHuntFlagRequestMessage
        {
            this.questType = questType;
            this.index = index;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.questType = 0;
            this.index = 0;
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
            this.serializeAs_TreasureHuntFlagRequestMessage(output);
        }

        public function serializeAs_TreasureHuntFlagRequestMessage(output:IDataOutput):void
        {
            output.writeByte(this.questType);
            if (this.index < 0)
            {
                throw (new Error((("Forbidden value (" + this.index) + ") on element index.")));
            };
            output.writeByte(this.index);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TreasureHuntFlagRequestMessage(input);
        }

        public function deserializeAs_TreasureHuntFlagRequestMessage(input:IDataInput):void
        {
            this.questType = input.readByte();
            if (this.questType < 0)
            {
                throw (new Error((("Forbidden value (" + this.questType) + ") on element of TreasureHuntFlagRequestMessage.questType.")));
            };
            this.index = input.readByte();
            if (this.index < 0)
            {
                throw (new Error((("Forbidden value (" + this.index) + ") on element of TreasureHuntFlagRequestMessage.index.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt

