package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class QuestObjectiveInformationsWithCompletion extends QuestObjectiveInformations implements INetworkType
   {
      
      public function QuestObjectiveInformationsWithCompletion()
      {
         super();
      }
      
      public static const protocolId:uint = 386;
      
      public var curCompletion:uint = 0;
      
      public var maxCompletion:uint = 0;
      
      override public function getTypeId() : uint
      {
         return 386;
      }
      
      public function initQuestObjectiveInformationsWithCompletion(param1:uint = 0, param2:Boolean = false, param3:Vector.<String> = null, param4:uint = 0, param5:uint = 0) : QuestObjectiveInformationsWithCompletion
      {
         super.initQuestObjectiveInformations(param1,param2,param3);
         this.curCompletion = param4;
         this.maxCompletion = param5;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.curCompletion = 0;
         this.maxCompletion = 0;
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_QuestObjectiveInformationsWithCompletion(param1);
      }
      
      public function serializeAs_QuestObjectiveInformationsWithCompletion(param1:ICustomDataOutput) : void
      {
         super.serializeAs_QuestObjectiveInformations(param1);
         if(this.curCompletion < 0)
         {
            throw new Error("Forbidden value (" + this.curCompletion + ") on element curCompletion.");
         }
         else
         {
            param1.writeVarShort(this.curCompletion);
            if(this.maxCompletion < 0)
            {
               throw new Error("Forbidden value (" + this.maxCompletion + ") on element maxCompletion.");
            }
            else
            {
               param1.writeVarShort(this.maxCompletion);
               return;
            }
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_QuestObjectiveInformationsWithCompletion(param1);
      }
      
      public function deserializeAs_QuestObjectiveInformationsWithCompletion(param1:ICustomDataInput) : void
      {
         super.deserialize(param1);
         this.curCompletion = param1.readVarUhShort();
         if(this.curCompletion < 0)
         {
            throw new Error("Forbidden value (" + this.curCompletion + ") on element of QuestObjectiveInformationsWithCompletion.curCompletion.");
         }
         else
         {
            this.maxCompletion = param1.readVarUhShort();
            if(this.maxCompletion < 0)
            {
               throw new Error("Forbidden value (" + this.maxCompletion + ") on element of QuestObjectiveInformationsWithCompletion.maxCompletion.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
