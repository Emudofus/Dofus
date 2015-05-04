package com.ankamagames.dofus.network.messages.game.context.roleplay.quest
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class QuestStartRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function QuestStartRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5643;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var questId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5643;
      }
      
      public function initQuestStartRequestMessage(param1:uint = 0) : QuestStartRequestMessage
      {
         this.questId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questId = 0;
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
         this.serializeAs_QuestStartRequestMessage(param1);
      }
      
      public function serializeAs_QuestStartRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element questId.");
         }
         else
         {
            param1.writeVarShort(this.questId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_QuestStartRequestMessage(param1);
      }
      
      public function deserializeAs_QuestStartRequestMessage(param1:ICustomDataInput) : void
      {
         this.questId = param1.readVarUhShort();
         if(this.questId < 0)
         {
            throw new Error("Forbidden value (" + this.questId + ") on element of QuestStartRequestMessage.questId.");
         }
         else
         {
            return;
         }
      }
   }
}
