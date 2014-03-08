package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class QuestObjectiveValidationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestObjectiveValidationMessage() {
         super();
      }
      
      public static const protocolId:uint = 6085;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var questId:uint = 0;
      
      public var objectiveId:uint = 0;
      
      override public function getMessageId() : uint {
         return 6085;
      }
      
      public function initQuestObjectiveValidationMessage(param1:uint=0, param2:uint=0) : QuestObjectiveValidationMessage {
         this.questId = param1;
         this.objectiveId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.questId = 0;
         this.objectiveId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_QuestObjectiveValidationMessage(param1);
      }
      
      public function serializeAs_QuestObjectiveValidationMessage(param1:IDataOutput) : void {
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         else
         {
            param1.writeShort(this.questId);
            if(this.objectiveId < 0)
            {
               throw new Error("Forbidden value (" + this.objectiveId + ") on element objectiveId.");
            }
            else
            {
               param1.writeShort(this.objectiveId);
               return;
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_QuestObjectiveValidationMessage(param1);
      }
      
      public function deserializeAs_QuestObjectiveValidationMessage(param1:IDataInput) : void {
         this.questId = param1.readShort();
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestObjectiveValidationMessage.questId.");
         }
         else
         {
            this.objectiveId = param1.readShort();
            if(this.objectiveId < 0)
            {
               throw new Error("Forbidden value (" + this.objectiveId + ") on element of QuestObjectiveValidationMessage.objectiveId.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
