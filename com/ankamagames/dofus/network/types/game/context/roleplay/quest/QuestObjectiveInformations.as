package com.ankamagames.dofus.network.types.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class QuestObjectiveInformations extends Object implements INetworkType
   {
      
      public function QuestObjectiveInformations() {
         this.dialogParams = new Vector.<String>();
         super();
      }
      
      public static const protocolId:uint = 385;
      
      public var objectiveId:uint = 0;
      
      public var objectiveStatus:Boolean = false;
      
      public var dialogParams:Vector.<String>;
      
      public function getTypeId() : uint {
         return 385;
      }
      
      public function initQuestObjectiveInformations(objectiveId:uint = 0, objectiveStatus:Boolean = false, dialogParams:Vector.<String> = null) : QuestObjectiveInformations {
         this.objectiveId = objectiveId;
         this.objectiveStatus = objectiveStatus;
         this.dialogParams = dialogParams;
         return this;
      }
      
      public function reset() : void {
         this.objectiveId = 0;
         this.objectiveStatus = false;
         this.dialogParams = new Vector.<String>();
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_QuestObjectiveInformations(output);
      }
      
      public function serializeAs_QuestObjectiveInformations(output:IDataOutput) : void {
         if(this.objectiveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectiveId + ") on element objectiveId.");
         }
         else
         {
            output.writeShort(this.objectiveId);
            output.writeBoolean(this.objectiveStatus);
            output.writeShort(this.dialogParams.length);
            _i3 = 0;
            while(_i3 < this.dialogParams.length)
            {
               output.writeUTF(this.dialogParams[_i3]);
               _i3++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_QuestObjectiveInformations(input);
      }
      
      public function deserializeAs_QuestObjectiveInformations(input:IDataInput) : void {
         var _val3:String = null;
         this.objectiveId = input.readShort();
         if(this.objectiveId < 0)
         {
            throw new Error("Forbidden value (" + this.objectiveId + ") on element of QuestObjectiveInformations.objectiveId.");
         }
         else
         {
            this.objectiveStatus = input.readBoolean();
            _dialogParamsLen = input.readUnsignedShort();
            _i3 = 0;
            while(_i3 < _dialogParamsLen)
            {
               _val3 = input.readUTF();
               this.dialogParams.push(_val3);
               _i3++;
            }
            return;
         }
      }
   }
}
