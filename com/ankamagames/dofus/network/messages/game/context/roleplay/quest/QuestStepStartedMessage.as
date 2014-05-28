package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class QuestStepStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestStepStartedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6096;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questId:uint = 0;
      
      public var stepId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6096;
      }
      
      public function initQuestStepStartedMessage(questId:uint = 0, stepId:uint = 0) : QuestStepStartedMessage {
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
         this.serializeAs_QuestStepStartedMessage(output);
      }
      
      public function serializeAs_QuestStepStartedMessage(output:IDataOutput) : void {
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
         this.deserializeAs_QuestStepStartedMessage(input);
      }
      
      public function deserializeAs_QuestStepStartedMessage(input:IDataInput) : void {
         this.questId = input.readUnsignedShort();
         if((this.questId < 0) || (this.questId > 65535))
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestStepStartedMessage.questId.");
         }
         else
         {
            this.stepId = input.readUnsignedShort();
            if((this.stepId < 0) || (this.stepId > 65535))
            {
               throw new Error("Forbidden value (" + this.stepId + ") on element of QuestStepStartedMessage.stepId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
