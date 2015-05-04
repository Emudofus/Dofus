package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   
   public class QuestActiveDetailedInformations extends QuestActiveInformations implements INetworkType
   {
      
      public function QuestActiveDetailedInformations()
      {
         this.objectives = new Vector.<QuestObjectiveInformations>();
         super();
      }
      
      public static const protocolId:uint = 382;
      
      public var stepId:uint = 0;
      
      public var objectives:Vector.<QuestObjectiveInformations>;
      
      override public function getTypeId() : uint
      {
         return 382;
      }
      
      public function initQuestActiveDetailedInformations(param1:uint = 0, param2:uint = 0, param3:Vector.<QuestObjectiveInformations> = null) : QuestActiveDetailedInformations
      {
         super.initQuestActiveInformations(param1);
         this.stepId = param2;
         this.objectives = param3;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.stepId = 0;
         this.objectives = new Vector.<QuestObjectiveInformations>();
      }
      
      override public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_QuestActiveDetailedInformations(param1);
      }
      
      public function serializeAs_QuestActiveDetailedInformations(param1:ICustomDataOutput) : void
      {
         super.serializeAs_QuestActiveInformations(param1);
         if(this.stepId < 0)
         {
            throw new Error("Forbidden value (" + this.stepId + ") on element stepId.");
         }
         else
         {
            param1.writeVarShort(this.stepId);
            param1.writeShort(this.objectives.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.objectives.length)
            {
               param1.writeShort((this.objectives[_loc2_] as QuestObjectiveInformations).getTypeId());
               (this.objectives[_loc2_] as QuestObjectiveInformations).serialize(param1);
               _loc2_++;
            }
            return;
         }
      }
      
      override public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_QuestActiveDetailedInformations(param1);
      }
      
      public function deserializeAs_QuestActiveDetailedInformations(param1:ICustomDataInput) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:QuestObjectiveInformations = null;
         super.deserialize(param1);
         this.stepId = param1.readVarUhShort();
         if(this.stepId < 0)
         {
            throw new Error("Forbidden value (" + this.stepId + ") on element of QuestActiveDetailedInformations.stepId.");
         }
         else
         {
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUnsignedShort();
               _loc5_ = ProtocolTypeManager.getInstance(QuestObjectiveInformations,_loc4_);
               _loc5_.deserialize(param1);
               this.objectives.push(_loc5_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
