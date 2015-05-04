package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ChallengeTargetsListRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChallengeTargetsListRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 5614;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var challengeId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 5614;
      }
      
      public function initChallengeTargetsListRequestMessage(param1:uint = 0) : ChallengeTargetsListRequestMessage
      {
         this.challengeId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengeId = 0;
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
         this.serializeAs_ChallengeTargetsListRequestMessage(param1);
      }
      
      public function serializeAs_ChallengeTargetsListRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         else
         {
            param1.writeVarShort(this.challengeId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeTargetsListRequestMessage(param1);
      }
      
      public function deserializeAs_ChallengeTargetsListRequestMessage(param1:ICustomDataInput) : void
      {
         this.challengeId = param1.readVarUhShort();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeTargetsListRequestMessage.challengeId.");
         }
         else
         {
            return;
         }
      }
   }
}
