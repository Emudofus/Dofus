package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.NetworkMessage;
    import com.ankamagames.jerakine.network.INetworkMessage;
    import flash.utils.ByteArray;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    [Trusted]
    public class QuestObjectiveValidationMessage extends NetworkMessage implements INetworkMessage 
    {

        public static const protocolId:uint = 6085;

        private var _isInitialized:Boolean = false;
        public var questId:uint = 0;
        public var objectiveId:uint = 0;


        override public function get isInitialized():Boolean
        {
            return (this._isInitialized);
        }

        override public function getMessageId():uint
        {
            return (6085);
        }

        public function initQuestObjectiveValidationMessage(questId:uint=0, objectiveId:uint=0):QuestObjectiveValidationMessage
        {
            this.questId = questId;
            this.objectiveId = objectiveId;
            this._isInitialized = true;
            return (this);
        }

        override public function reset():void
        {
            this.questId = 0;
            this.objectiveId = 0;
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
            this.serializeAs_QuestObjectiveValidationMessage(output);
        }

        public function serializeAs_QuestObjectiveValidationMessage(output:IDataOutput):void
        {
            if (this.questId < 0)
            {
                throw (new Error((("Forbidden value (" + this.questId) + ") on element questId.")));
            };
            output.writeShort(this.questId);
            if (this.objectiveId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectiveId) + ") on element objectiveId.")));
            };
            output.writeShort(this.objectiveId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_QuestObjectiveValidationMessage(input);
        }

        public function deserializeAs_QuestObjectiveValidationMessage(input:IDataInput):void
        {
            this.questId = input.readShort();
            if (this.questId < 0)
            {
                throw (new Error((("Forbidden value (" + this.questId) + ") on element of QuestObjectiveValidationMessage.questId.")));
            };
            this.objectiveId = input.readShort();
            if (this.objectiveId < 0)
            {
                throw (new Error((("Forbidden value (" + this.objectiveId) + ") on element of QuestObjectiveValidationMessage.objectiveId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.messages.game.context.roleplay.quest

