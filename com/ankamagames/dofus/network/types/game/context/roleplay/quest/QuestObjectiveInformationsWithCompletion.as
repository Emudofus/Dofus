package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class QuestObjectiveInformationsWithCompletion extends QuestObjectiveInformations implements INetworkType
    {
        public var curCompletion:uint = 0;
        public var maxCompletion:uint = 0;
        public static const protocolId:uint = 386;

        public function QuestObjectiveInformationsWithCompletion()
        {
            return;
        }// end function

        override public function getTypeId() : uint
        {
            return 386;
        }// end function

        public function initQuestObjectiveInformationsWithCompletion(param1:uint = 0, param2:Boolean = false, param3:uint = 0, param4:uint = 0) : QuestObjectiveInformationsWithCompletion
        {
            super.initQuestObjectiveInformations(param1, param2);
            this.curCompletion = param3;
            this.maxCompletion = param4;
            return this;
        }// end function

        override public function reset() : void
        {
            super.reset();
            this.curCompletion = 0;
            this.maxCompletion = 0;
            return;
        }// end function

        override public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_QuestObjectiveInformationsWithCompletion(param1);
            return;
        }// end function

        public function serializeAs_QuestObjectiveInformationsWithCompletion(param1:IDataOutput) : void
        {
            super.serializeAs_QuestObjectiveInformations(param1);
            if (this.curCompletion < 0)
            {
                throw new Error("Forbidden value (" + this.curCompletion + ") on element curCompletion.");
            }
            param1.writeShort(this.curCompletion);
            if (this.maxCompletion < 0)
            {
                throw new Error("Forbidden value (" + this.maxCompletion + ") on element maxCompletion.");
            }
            param1.writeShort(this.maxCompletion);
            return;
        }// end function

        override public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_QuestObjectiveInformationsWithCompletion(param1);
            return;
        }// end function

        public function deserializeAs_QuestObjectiveInformationsWithCompletion(param1:IDataInput) : void
        {
            super.deserialize(param1);
            this.curCompletion = param1.readShort();
            if (this.curCompletion < 0)
            {
                throw new Error("Forbidden value (" + this.curCompletion + ") on element of QuestObjectiveInformationsWithCompletion.curCompletion.");
            }
            this.maxCompletion = param1.readShort();
            if (this.maxCompletion < 0)
            {
                throw new Error("Forbidden value (" + this.maxCompletion + ") on element of QuestObjectiveInformationsWithCompletion.maxCompletion.");
            }
            return;
        }// end function

    }
}
