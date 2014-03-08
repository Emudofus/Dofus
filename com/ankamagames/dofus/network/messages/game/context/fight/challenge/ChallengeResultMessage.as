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
      
      public function initChallengeResultMessage(param1:uint=0, param2:Boolean=false) : ChallengeResultMessage {
         this.challengeId = param1;
         this.success = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.challengeId = 0;
         this.success = false;
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
         this.serializeAs_ChallengeResultMessage(param1);
      }
      
      public function serializeAs_ChallengeResultMessage(param1:IDataOutput) : void {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         else
         {
            param1.writeShort(this.challengeId);
            param1.writeBoolean(this.success);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChallengeResultMessage(param1);
      }
      
      public function deserializeAs_ChallengeResultMessage(param1:IDataInput) : void {
         this.challengeId = param1.readShort();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeResultMessage.challengeId.");
         }
         else
         {
            this.success = param1.readBoolean();
            return;
         }
      }
   }
}
