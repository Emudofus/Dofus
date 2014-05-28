package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class QuestObjectiveInformationsWithCompletion extends QuestObjectiveInformations implements INetworkType
   {
      
      public function QuestObjectiveInformationsWithCompletion() {
         super();
      }
      
      public static const protocolId:uint = 386;
      
      public var curCompletion:uint = 0;
      
      public var maxCompletion:uint = 0;
      
      override public function getTypeId() : uint {
         return 386;
      }
      
      public function initQuestObjectiveInformationsWithCompletion(objectiveId:uint = 0, objectiveStatus:Boolean = false, dialogParams:Vector.<String> = null, curCompletion:uint = 0, maxCompletion:uint = 0) : QuestObjectiveInformationsWithCompletion {
         super.initQuestObjectiveInformations(objectiveId,objectiveStatus,dialogParams);
         this.curCompletion = curCompletion;
         this.maxCompletion = maxCompletion;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.curCompletion = 0;
         this.maxCompletion = 0;
      }
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_QuestObjectiveInformationsWithCompletion(output);
      }
      
      public function serializeAs_QuestObjectiveInformationsWithCompletion(output:IDataOutput) : void {
         super.serializeAs_QuestObjectiveInformations(output);
         if(this.curCompletion < 0)
         {
            throw new Error("Forbidden value (" + this.curCompletion + ") on element curCompletion.");
         }
         else
         {
            output.writeShort(this.curCompletion);
            if(this.maxCompletion < 0)
            {
               throw new Error("Forbidden value (" + this.maxCompletion + ") on element maxCompletion.");
            }
            else
            {
               output.writeShort(this.maxCompletion);
               return;
            }
         }
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_QuestObjectiveInformationsWithCompletion(input);
      }
      
      public function deserializeAs_QuestObjectiveInformationsWithCompletion(input:IDataInput) : void {
         super.deserialize(input);
         this.curCompletion = input.readShort();
         if(this.curCompletion < 0)
         {
            throw new Error("Forbidden value (" + this.curCompletion + ") on element of QuestObjectiveInformationsWithCompletion.curCompletion.");
         }
         else
         {
            this.maxCompletion = input.readShort();
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
