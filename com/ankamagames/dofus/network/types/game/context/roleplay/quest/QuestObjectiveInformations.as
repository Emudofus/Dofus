package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class QuestObjectiveInformations extends Object implements INetworkType
   {
      
      public function QuestObjectiveInformations()
      {
         this.dialogParams = new Vector.<String>();
         super();
      }
      
      public static const protocolId:uint = 385;
      
      public var objectiveId:uint = 0;
      
      public var objectiveStatus:Boolean = false;
      
      public var dialogParams:Vector.<String>;
      
      public function getTypeId() : uint
      {
         return 385;
      }
      
      public function initQuestObjectiveInformations(param1:uint = 0, param2:Boolean = false, param3:Vector.<String> = null) : QuestObjectiveInformations
      {
         this.objectiveId = param1;
         this.objectiveStatus = param2;
         this.dialogParams = param3;
         return this;
      }
      
      public function reset() : void
      {
         this.objectiveId = 0;
         this.objectiveStatus = false;
         this.dialogParams = new Vector.<String>();
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_QuestObjectiveInformations(param1);
      }
      
      public function serializeAs_QuestObjectiveInformations(param1:ICustomDataOutput) : void
      {
         if(this.objectiveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectiveId + ") on element objectiveId.");
         }
         else
         {
            param1.writeVarShort(this.objectiveId);
            param1.writeBoolean(this.objectiveStatus);
            param1.writeShort(this.dialogParams.length);
            var _loc2_:uint = 0;
            while(_loc2_ < this.dialogParams.length)
            {
               param1.writeUTF(this.dialogParams[_loc2_]);
               _loc2_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_QuestObjectiveInformations(param1);
      }
      
      public function deserializeAs_QuestObjectiveInformations(param1:ICustomDataInput) : void
      {
         var _loc4_:String = null;
         this.objectiveId = param1.readVarUhShort();
         if(this.objectiveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectiveId + ") on element of QuestObjectiveInformations.objectiveId.");
         }
         else
         {
            this.objectiveStatus = param1.readBoolean();
            var _loc2_:uint = param1.readUnsignedShort();
            var _loc3_:uint = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = param1.readUTF();
               this.dialogParams.push(_loc4_);
               _loc3_++;
            }
            return;
         }
      }
   }
}
