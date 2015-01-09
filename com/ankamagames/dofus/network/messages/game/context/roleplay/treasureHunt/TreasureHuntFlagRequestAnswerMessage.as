package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class TreasureHuntFlagRequestAnswerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6507;

        private var _isInitialized:Boolean = false;
        public var questType:uint = 0;
        public var result:uint = 0;
        public var index:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6507);
        }

        public function initTreasureHuntFlagRequestAnswerMessage(questType:uint=0, result:uint=0, index:uint=0):TreasureHuntFlagRequestAnswerMessage
        {
            this.questType = questType;
            this.result = result;
            this.index = index;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.questType = 0;
            this.result = 0;
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
            this.serializeAs_TreasureHuntFlagRequestAnswerMessage(output);
        }

        public function serializeAs_TreasureHuntFlagRequestAnswerMessage(output:IDataOutput):void
        {
            output.writeByte(this.questType);
            output.writeByte(this.result);
            if (this.index < 0)
            {
                throw (new Error((("Forbidden value (" + this.index) + ") on element index.")));
            };
            output.writeByte(this.index);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TreasureHuntFlagRequestAnswerMessage(input);
        }

        public function deserializeAs_TreasureHuntFlagRequestAnswerMessage(input:IDataInput):void
        {
            this.questType = input.readByte();
            if (this.questType < 0)
            {
                throw (new Error((("Forbidden value (" + this.questType) + ") on element of TreasureHuntFlagRequestAnswerMessage.questType.")));
            };
            this.result = input.readByte();
            if (this.result < 0)
            {
                throw (new Error((("Forbidden value (" + this.result) + ") on element of TreasureHuntFlagRequestAnswerMessage.result.")));
            };
            this.index = input.readByte();
            if (this.index < 0)
            {
                throw (new Error((("Forbidden value (" + this.index) + ") on element of TreasureHuntFlagRequestAnswerMessage.index.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt

