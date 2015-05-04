package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class QuestActiveInformations extends Object implements INetworkType
   {
      
      public function QuestActiveInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 381;
      
      public var questId:uint = 0;
      
      public function getTypeId() : uint
      {
         return 381;
      }
      
      public function initQuestActiveInformations(param1:uint = 0) : QuestActiveInformations
      {
         this.questId = param1;
         return this;
      }
      
      public function reset() : void
      {
         this.questId = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_QuestActiveInformations(param1);
      }
      
      public function serializeAs_QuestActiveInformations(param1:ICustomDataOutput) : void
      {
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         else
         {
            param1.writeVarShort(this.questId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_QuestActiveInformations(param1);
      }
      
      public function deserializeAs_QuestActiveInformations(param1:ICustomDataInput) : void
      {
         this.questId = param1.readVarUhShort();
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestActiveInformations.questId.");
         }
         else
         {
            return;
         }
      }
   }
}
