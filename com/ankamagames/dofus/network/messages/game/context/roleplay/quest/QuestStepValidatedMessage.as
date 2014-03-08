package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class QuestStepValidatedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestStepValidatedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6099;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questId:uint = 0;
      
      public var stepId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6099;
      }
      
      public function initQuestStepValidatedMessage(questId:uint=0, stepId:uint=0) : QuestStepValidatedMessage {
         this.questId = questId;
         this.stepId = stepId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.questId = 0;
         this.stepId = 0;
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
         this.serializeAs_QuestStepValidatedMessage(output);
      }
      
      public function serializeAs_QuestStepValidatedMessage(output:IDataOutput) : void {
         if((this.questId < 0) || (this.questId > 65535))
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         else
         {
            output.writeShort(this.questId);
            if((this.stepId < 0) || (this.stepId > 65535))
            {
               throw new Error("Forbidden value (" + this.stepId + ") on element stepId.");
            }
            else
            {
               output.writeShort(this.stepId);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_QuestStepValidatedMessage(input);
      }
      
      public function deserializeAs_QuestStepValidatedMessage(input:IDataInput) : void {
         this.questId = input.readUnsignedShort();
         if((this.questId < 0) || (this.questId > 65535))
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestStepValidatedMessage.questId.");
         }
         else
         {
            this.stepId = input.readUnsignedShort();
            if((this.stepId < 0) || (this.stepId > 65535))
            {
               throw new Error("Forbidden value (" + this.stepId + ") on element of QuestStepValidatedMessage.stepId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
