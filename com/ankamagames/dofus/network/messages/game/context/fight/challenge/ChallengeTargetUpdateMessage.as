package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class ChallengeTargetUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChallengeTargetUpdateMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6123;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var challengeId:uint = 0;
      
      public var targetId:int = 0;
      
      override public function getMessageId() : uint
      {
         return 6123;
      }
      
      public function initChallengeTargetUpdateMessage(param1:uint = 0, param2:int = 0) : ChallengeTargetUpdateMessage
      {
         this.challengeId = param1;
         this.targetId = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.challengeId = 0;
         this.targetId = 0;
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
         this.serializeAs_ChallengeTargetUpdateMessage(param1);
      }
      
      public function serializeAs_ChallengeTargetUpdateMessage(param1:ICustomDataOutput) : void
      {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         else
         {
            param1.writeVarShort(this.challengeId);
            param1.writeInt(this.targetId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_ChallengeTargetUpdateMessage(param1);
      }
      
      public function deserializeAs_ChallengeTargetUpdateMessage(param1:ICustomDataInput) : void
      {
         this.challengeId = param1.readVarUhShort();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeTargetUpdateMessage.challengeId.");
         }
         else
         {
            this.targetId = param1.readInt();
            return;
         }
      }
   }
}
