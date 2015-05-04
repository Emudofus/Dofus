package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class QuestStepStartedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestStepStartedMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6096;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var questId:uint = 0;
      
      public var stepId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6096;
      }
      
      public function initQuestStepStartedMessage(param1:uint = 0, param2:uint = 0) : QuestStepStartedMessage
      {
         this.questId = param1;
         this.stepId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questId = 0;
         this.stepId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:ICustomDataOutput) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(_loc2_));
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:ICustomDataInput, param2:uint) : void
      {
         this.deserialize(param1);
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_QuestStepStartedMessage(param1);
      }
      
      public function serializeAs_QuestStepStartedMessage(param1:ICustomDataOutput) : void
      {
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         else
         {
            param1.writeVarShort(this.questId);
            if(this.stepId < 0)
            {
               throw new Error("Forbidden value (" + this.stepId + ") on element stepId.");
            }
            else
            {
               param1.writeVarShort(this.stepId);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_QuestStepStartedMessage(param1);
      }
      
      public function deserializeAs_QuestStepStartedMessage(param1:ICustomDataInput) : void
      {
         this.questId = param1.readVarUhShort();
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestStepStartedMessage.questId.");
         }
         else
         {
            this.stepId = param1.readVarUhShort();
            if(this.stepId < 0)
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
