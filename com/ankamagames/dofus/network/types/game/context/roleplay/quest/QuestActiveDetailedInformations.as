package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.INetworkType;
    import __AS3__.vec.Vector;
    import flash.utils.IDataOutput;
    import flash.utils.IDataInput;
    import com.ankamagames.dofus.network.ProtocolTypeManager;
    import __AS3__.vec.*;

    public class QuestActiveDetailedInformations extends QuestActiveInformations implements INetworkType 
    {

        public static const protocolId:uint = 382;

        public var stepId:uint = 0;
        public var objectives:Vector.<QuestObjectiveInformations>;

        public function QuestActiveDetailedInformations()
        {
            this.objectives = new Vector.<QuestObjectiveInformations>();
            super();
        }

        override public function getTypeId():uint
        {
            return (382);
        }

        public function initQuestActiveDetailedInformations(questId:uint=0, stepId:uint=0, objectives:Vector.<QuestObjectiveInformations>=null):QuestActiveDetailedInformations
        {
            super.initQuestActiveInformations(questId);
            this.stepId = stepId;
            this.objectives = objectives;
            return (this);
        }

        override public function reset():void
        {
            super.reset();
            this.stepId = 0;
            this.objectives = new Vector.<QuestObjectiveInformations>();
        }

        override public function serialize(output:IDataOutput):void
        {
            this.serializeAs_QuestActiveDetailedInformations(output);
        }

        public function serializeAs_QuestActiveDetailedInformations(output:IDataOutput):void
        {
            super.serializeAs_QuestActiveInformations(output);
            if (this.stepId < 0)
            {
                throw (new Error((("Forbidden value (" + this.stepId) + ") on element stepId.")));
            };
            output.writeShort(this.stepId);
            output.writeShort(this.objectives.length);
            var _i2:uint;
            while (_i2 < this.objectives.length)
            {
                output.writeShort((this.objectives[_i2] as QuestObjectiveInformations).getTypeId());
                (this.objectives[_i2] as QuestObjectiveInformations).serialize(output);
                _i2++;
            };
        }

        override public function deserialize(input:IDataInput):void
        {
            this.deserializeAs_QuestActiveDetailedInformations(input);
        }

        public function deserializeAs_QuestActiveDetailedInformations(input:IDataInput):void
        {
            var _id2:uint;
            var _item2:QuestObjectiveInformations;
            super.deserialize(input);
            this.stepId = input.readShort();
            if (this.stepId < 0)
            {
                throw (new Error((("Forbidden value (" + this.stepId) + ") on element of QuestActiveDetailedInformations.stepId.")));
            };
            var _objectivesLen:uint = input.readUnsignedShort();
            var _i2:uint;
            while (_i2 < _objectivesLen)
            {
                _id2 = input.readUnsignedShort();
                _item2 = ProtocolTypeManager.getInstance(QuestObjectiveInformations, _id2);
                _item2.deserialize(input);
                this.objectives.push(_item2);
                _i2++;
            };
        }


    }
}//package com.ankamagames.dofus.network.types.game.context.roleplay.quest

