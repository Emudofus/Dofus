package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
    import com.ankamagames.jerakine.network.*;
    import flash.utils.*;

    public class QuestActiveInformations extends Object implements INetworkType
    {
        public var questId:uint = 0;
        public static const protocolId:uint = 381;

        public function QuestActiveInformations()
        {
            return;
        }// end function

        public function getTypeId() : uint
        {
            return 381;
        }// end function

        public function initQuestActiveInformations(param1:uint = 0) : QuestActiveInformations
        {
            this.questId = param1;
            return this;
        }// end function

        public function reset() : void
        {
            this.questId = 0;
            return;
        }// end function

        public function serialize(param1:IDataOutput) : void
        {
            this.serializeAs_QuestActiveInformations(param1);
            return;
        }// end function

        public function serializeAs_QuestActiveInformations(param1:IDataOutput) : void
        {
            if (this.questId < 0)
            {
                throw new Error("Forbidden value (" + this.questId + ") on element questId.");
            }
            param1.writeShort(this.questId);
            return;
        }// end function

        public function deserialize(param1:IDataInput) : void
        {
            this.deserializeAs_QuestActiveInformations(param1);
            return;
        }// end function

        public function deserializeAs_QuestActiveInformations(param1:IDataInput) : void
        {
            this.questId = param1.readShort();
            if (this.questId < 0)
            {
                throw new Error("Forbidden value (" + this.questId + ") on element of QuestActiveInformations.questId.");
            }
            return;
        }// end function

    }
}
