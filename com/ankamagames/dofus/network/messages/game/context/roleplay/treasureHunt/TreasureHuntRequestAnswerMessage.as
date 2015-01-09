package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class TreasureHuntRequestAnswerMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6489;

        private var _isInitialized:Boolean = false;
        public var questType:uint = 0;
        public var result:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6489);
        }

        public function initTreasureHuntRequestAnswerMessage(questType:uint=0, result:uint=0):TreasureHuntRequestAnswerMessage
        {
            this.questType = questType;
            this.result = result;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.questType = 0;
            this.result = 0;
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
            this.serializeAs_TreasureHuntRequestAnswerMessage(output);
        }

        public function serializeAs_TreasureHuntRequestAnswerMessage(output:IDataOutput):void
        {
            output.writeByte(this.questType);
            output.writeByte(this.result);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_TreasureHuntRequestAnswerMessage(input);
        }

        public function deserializeAs_TreasureHuntRequestAnswerMessage(input:IDataInput):void
        {
            this.questType = input.readByte();
            if (this.questType < 0)
            {
                throw (new Error((("Forbidden value (" + this.questType) + ") on element of TreasureHuntRequestAnswerMessage.questType.")));
            };
            this.result = input.readByte();
            if (this.result < 0)
            {
                throw (new Error((("Forbidden value (" + this.result) + ") on element of TreasureHuntRequestAnswerMessage.result.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt

