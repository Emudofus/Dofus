package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class QuestObjectiveValidatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestObjectiveValidatedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6098;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questId:uint = 0;
      
      public var objectiveId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6098;
      }
      
      public function initQuestObjectiveValidatedMessage(questId:uint=0, objectiveId:uint=0) : QuestObjectiveValidatedMessage {
         this.questId = questId;
         this.objectiveId = objectiveId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.questId = 0;
         this.objectiveId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_QuestObjectiveValidatedMessage(output);
      }
      
      public function serializeAs_QuestObjectiveValidatedMessage(output:IDataOutput) : void {
         if((this.questId < 0) || (this.questId > 65535))
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         else
         {
            output.writeShort(this.questId);
            if((this.objectiveId < 0) || (this.objectiveId > 65535))
            {
               throw new Error("Forbidden value (" + this.objectiveId + ") on element objectiveId.");
            }
            else
            {
               output.writeShort(this.objectiveId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_QuestObjectiveValidatedMessage(input);
      }
      
      public function deserializeAs_QuestObjectiveValidatedMessage(input:IDataInput) : void {
         this.questId = input.readUnsignedShort();
         if((this.questId < 0) || (this.questId > 65535))
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestObjectiveValidatedMessage.questId.");
         }
         else
         {
            this.objectiveId = input.readUnsignedShort();
            if((this.objectiveId < 0) || (this.objectiveId > 65535))
            {
               throw new Error("Forbidden value (" + this.objectiveId + ") on element of QuestObjectiveValidatedMessage.objectiveId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
