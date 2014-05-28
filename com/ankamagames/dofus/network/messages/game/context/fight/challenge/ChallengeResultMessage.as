package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChallengeResultMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChallengeResultMessage() {
         super();
      }
      
      public static const protocolId:uint = 6019;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var challengeId:uint = 0;
      
      public var success:Boolean = false;
      
      override public function getMessageId() : uint {
         return 6019;
      }
      
      public function initChallengeResultMessage(challengeId:uint = 0, success:Boolean = false) : ChallengeResultMessage {
         this.challengeId = challengeId;
         this.success = success;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.challengeId = 0;
         this.success = false;
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
         this.serializeAs_ChallengeResultMessage(output);
      }
      
      public function serializeAs_ChallengeResultMessage(output:IDataOutput) : void {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         else
         {
            output.writeShort(this.challengeId);
            output.writeBoolean(this.success);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChallengeResultMessage(input);
      }
      
      public function deserializeAs_ChallengeResultMessage(input:IDataInput) : void {
         this.challengeId = input.readShort();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeResultMessage.challengeId.");
         }
         else
         {
            this.success = input.readBoolean();
            return;
         }
      }
   }
}
