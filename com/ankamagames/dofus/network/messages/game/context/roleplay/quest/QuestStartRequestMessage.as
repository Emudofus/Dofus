package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import com.ankamagames.jerakine.network.CustomDataWrapper;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    [Trusted]
    public class QuestStartRequestMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 5643;

        private var _isInitialized:Boolean = false;
        public var questId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (5643);
        }

        public function initQuestStartRequestMessage(questId:uint=0):QuestStartRequestMessage
        {
            this.questId = questId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.questId = 0;
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
            this.serializeAs_QuestStartRequestMessage(output);
        }

        public function serializeAs_QuestStartRequestMessage(output:ICustomDataOutput):void
        {
            if (this.questId < 0)
            {
                throw (new Error((("Forbidden value (" + this.questId) + ") on element questId.")));
            };
            output.writeVarShort(this.questId);
        }

        public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_QuestStartRequestMessage(input);
        }

        public function deserializeAs_QuestStartRequestMessage(input:ICustomDataInput):void
        {
            this.questId = input.readVarUhShort();
            if (this.questId < 0)
            {
                throw (new Error((("Forbidden value (" + this.questId) + ") on element of QuestStartRequestMessage.questId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.quest

