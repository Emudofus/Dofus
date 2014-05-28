package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class QuestStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestStartedMessage() {
         super();
      }
      
      public static const protocolId:uint = 6091;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6091;
      }
      
      public function initQuestStartedMessage(questId:uint = 0) : QuestStartedMessage {
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
         this.serializeAs_QuestStartedMessage(output);
      }
      
      public function serializeAs_QuestStartedMessage(output:IDataOutput) : void {
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
         this.deserializeAs_QuestStartedMessage(input);
      }
      
      public function deserializeAs_QuestStartedMessage(input:IDataInput) : void {
         this.questId = input.readUnsignedShort();
         if((this.questId < 0) || (this.questId > 65535))
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestStartedMessage.questId.");
         }
         else
         {
            return;
         }
      }
   }
}
