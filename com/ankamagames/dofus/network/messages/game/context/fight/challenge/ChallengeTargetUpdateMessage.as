package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChallengeTargetUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChallengeTargetUpdateMessage() {
         super();
      }
      
      public static const protocolId:uint = 6123;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var challengeId:uint = 0;
      
      public var targetId:int = 0;
      
      override public function getMessageId() : uint {
         return 6123;
      }
      
      public function initChallengeTargetUpdateMessage(challengeId:uint=0, targetId:int=0) : ChallengeTargetUpdateMessage {
         this.challengeId = challengeId;
         this.targetId = targetId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.challengeId = 0;
         this.targetId = 0;
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
         this.serializeAs_ChallengeTargetUpdateMessage(output);
      }
      
      public function serializeAs_ChallengeTargetUpdateMessage(output:IDataOutput) : void {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         else
         {
            output.writeShort(this.challengeId);
            output.writeInt(this.targetId);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChallengeTargetUpdateMessage(input);
      }
      
      public function deserializeAs_ChallengeTargetUpdateMessage(input:IDataInput) : void {
         this.challengeId = input.readShort();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeTargetUpdateMessage.challengeId.");
         }
         else
         {
            this.targetId = input.readInt();
            return;
         }
      }
   }
}
