package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import __AS3__.vec.*;
    import com.ankamagames.dofus.network.*;
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class QuestActiveDetailedInformations extends QuestActiveInformations implements INetworkType
    {
        public var stepId:uint = 0;
        public var objectives:Vector.<QuestObjectiveInformations>;
        public static const protocolId:uint = 382;

        public function QuestActiveDetailedInformations()
        {
            this.objectives = new Vector.<QuestObjectiveInformations>;
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 382;
        }// end function

        public function initQuestActiveDetailedInformations(param1:uint = 0, param2:uint = 0, param3:Vector.<QuestObjectiveInformations> = null) : QuestActiveDetailedInformations
        {
            super.initQuestActiveInformations(param1);
            this.stepId = param2;
            this.objectives = param3;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.stepId = 0;
            this.objectives = new Vector.<QuestObjectiveInformations>;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_QuestActiveDetailedInformations(param1);
            return;
        }// end function

        public function serializeAs_QuestActiveDetailedInformations(param1:IDataOutput) : void
        {
            super.serializeAs_QuestActiveInformations(param1);
            if (this.stepId < 0)
            {
                throw new Error("Forbidden value (" + this.stepId + ") on element stepId.");
            }
            param1.writeShort(this.stepId);
            param1.writeShort(this.objectives.length);
            var _loc_2:* = 0;
            while (_loc_2 < this.objectives.length)
            {
                
                param1.writeShort((this.objectives[_loc_2] as QuestObjectiveInformations).getTypeId());
                (this.objectives[_loc_2] as QuestObjectiveInformations).serialize(param1);
                _loc_2 = _loc_2 + 1;
            }
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_QuestActiveDetailedInformations(param1);
            return;
        }// end function

        public function deserializeAs_QuestActiveDetailedInformations(param1:IDataInput) : void
        {
            var _loc_4:* = 0;
            var _loc_5:* = null;
            super.deserialize(param1);
            this.stepId = param1.readShort();
            if (this.stepId < 0)
            {
                throw new Error("Forbidden value (" + this.stepId + ") on element of QuestActiveDetailedInformations.stepId.");
            }
            var _loc_2:* = param1.readUnsignedShort();
            var _loc_3:* = 0;
            while (_loc_3 < _loc_2)
            {
                
                _loc_4 = param1.readUnsignedShort();
                _loc_5 = ProtocolTypeManager.getInstance(QuestObjectiveInformations, _loc_4);
                _loc_5.deserialize(param1);
                this.objectives.push(_loc_5);
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

    }
}
