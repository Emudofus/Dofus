package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class QuestObjectiveInformations extends Object implements INetworkType
    {
        public var objectiveId:uint = 0;
        public var objectiveStatus:Boolean = false;
        public static const protocolId:uint = 385;

        public function QuestObjectiveInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 385;
        }// end function

        public function initQuestObjectiveInformations(param1:uint = 0, param2:Boolean = false) : QuestObjectiveInformations
        {
            this.objectiveId = param1;
            this.objectiveStatus = param2;
            return this;
        }// end function

        public function reset() : void
        {
            this.objectiveId = 0;
            this.objectiveStatus = false;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_QuestObjectiveInformations(param1);
            return;
        }// end function

        public function serializeAs_QuestObjectiveInformations(param1:IDataOutput) : void
        {
            if (this.objectiveId < 0)
            {
                throw new Error("Forbidden value (" + this.objectiveId + ") on element objectiveId.");
            }
            param1.writeShort(this.objectiveId);
            param1.writeBoolean(this.objectiveStatus);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_QuestObjectiveInformations(param1);
            return;
        }// end function

        public function deserializeAs_QuestObjectiveInformations(param1:IDataInput) : void
        {
            this.objectiveId = param1.readShort();
            if (this.objectiveId < 0)
            {
                throw new Error("Forbidden value (" + this.objectiveId + ") on element of QuestObjectiveInformations.objectiveId.");
            }
            this.objectiveStatus = param1.readBoolean();
            return;
        }// end function

    }
}
