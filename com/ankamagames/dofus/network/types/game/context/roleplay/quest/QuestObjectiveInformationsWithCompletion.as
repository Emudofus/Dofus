package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import com.ankamagames.jerakine.network.ICustomDataOutput;
    import com.ankamagames.jerakine.network.ICustomDataInput;

    public class QuestObjectiveInformationsWithCompletion extends QuestObjectiveInformations implements INetworkType 
    {

        public static const protocolId:uint = 386;

        public var curCompletion:uint = 0;
        public var maxCompletion:uint = 0;


        override public function getTypeId():uint
        {
            return (386);
        }

        public function initQuestObjectiveInformationsWithCompletion(objectiveId:uint=0, objectiveStatus:Boolean=false, dialogParams:Vector.<String>=null, curCompletion:uint=0, maxCompletion:uint=0):QuestObjectiveInformationsWithCompletion
        {
            super.initQuestObjectiveInformations(objectiveId, objectiveStatus, dialogParams);
            this.curCompletion = curCompletion;
            this.maxCompletion = maxCompletion;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.curCompletion = 0;
            this.maxCompletion = 0;
        }

        override public function serialize(output:ICustomDataOutput):void
        {
            this.serializeAs_QuestObjectiveInformationsWithCompletion(output);
        }

        public function serializeAs_QuestObjectiveInformationsWithCompletion(output:ICustomDataOutput):void
        {
            super.serializeAs_QuestObjectiveInformations(output);
            if (this.curCompletion < 0)
            {
                throw (new Error((("Forbidden value (" + this.curCompletion) + ") on element curCompletion.")));
            };
            output.writeVarShort(this.curCompletion);
            if (this.maxCompletion < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxCompletion) + ") on element maxCompletion.")));
            };
            output.writeVarShort(this.maxCompletion);
        }

        override public function deserialize(input:ICustomDataInput):void
        {
            this.deserializeAs_QuestObjectiveInformationsWithCompletion(input);
        }

        public function deserializeAs_QuestObjectiveInformationsWithCompletion(input:ICustomDataInput):void
        {
            super.deserialize(input);
            this.curCompletion = input.readVarUhShort();
            if (this.curCompletion < 0)
            {
                throw (new Error((("Forbidden value (" + this.curCompletion) + ") on element of QuestObjectiveInformationsWithCompletion.curCompletion.")));
            };
            this.maxCompletion = input.readVarUhShort();
            if (this.maxCompletion < 0)
            {
                throw (new Error((("Forbidden value (" + this.maxCompletion) + ") on element of QuestObjectiveInformationsWithCompletion.maxCompletion.")));
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.quest

