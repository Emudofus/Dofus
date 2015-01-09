package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.INetworkType;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;

    public class QuestActiveInformations implements INetworkType 
    {

        public static const protocolId:uint = 381;

        public var questId:uint = 0;


        public function getTypeId():uint
        {
            return (381);
        }

        public function initQuestActiveInformations(questId:uint=0):QuestActiveInformations
        {
            this.questId = questId;
            return (this);
        }

        public function reset():void
        {
            this.questId = 0;
        }

        public function serialize(output:IDataOutput):void
        {
            this.serializeAs_QuestActiveInformations(output);
        }

        public function serializeAs_QuestActiveInformations(output:IDataOutput):void
        {
            if (this.questId < 0)
            {
                throw (new Error((("Forbidden value (" + this.questId) + ") on element questId.")));
            };
            output.writeShort(this.questId);
        }

        public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_QuestActiveInformations(input);
        }

        public function deserializeAs_QuestActiveInformations(input:IDataInput):void
        {
            this.questId = input.readShort();
            if (this.questId < 0)
            {
                throw (new Error((("Forbidden value (" + this.questId) + ") on element of QuestActiveInformations.questId.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.quest

