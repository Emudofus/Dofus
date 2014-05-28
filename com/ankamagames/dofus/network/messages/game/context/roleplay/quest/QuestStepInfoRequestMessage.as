package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class QuestStepInfoRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestStepInfoRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5622;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questId:uint = 0;
      
      override public function getMessageId() : uint {
         return 5622;
      }
      
      public function initQuestStepInfoRequestMessage(questId:uint = 0) : QuestStepInfoRequestMessage {
         this.questId = questId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.questId = 0;
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
         this.serializeAs_QuestStepInfoRequestMessage(output);
      }
      
      public function serializeAs_QuestStepInfoRequestMessage(output:IDataOutput) : void {
         if((this.questId < 0) || (this.questId > 65535))
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         else
         {
            output.writeShort(this.questId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_QuestStepInfoRequestMessage(input);
      }
      
      public function deserializeAs_QuestStepInfoRequestMessage(input:IDataInput) : void {
         this.questId = input.readUnsignedShort();
         if((this.questId < 0) || (this.questId > 65535))
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestStepInfoRequestMessage.questId.");
         }
         else
         {
            return;
         }
      }
   }
}
