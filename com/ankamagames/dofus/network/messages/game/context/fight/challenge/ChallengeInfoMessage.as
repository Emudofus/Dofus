package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChallengeInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChallengeInfoMessage() {
         super();
      }
      
      public static const protocolId:uint = 6022;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var challengeId:uint = 0;
      
      public var targetId:int = 0;
      
      public var xpBonus:uint = 0;
      
      public var dropBonus:uint = 0;
      
      override public function getMessageId() : uint {
         return 6022;
      }
      
      public function initChallengeInfoMessage(challengeId:uint = 0, targetId:int = 0, xpBonus:uint = 0, dropBonus:uint = 0) : ChallengeInfoMessage {
         this.challengeId = challengeId;
         this.targetId = targetId;
         this.xpBonus = xpBonus;
         this.dropBonus = dropBonus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.challengeId = 0;
         this.targetId = 0;
         this.xpBonus = 0;
         this.dropBonus = 0;
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
         this.serializeAs_ChallengeInfoMessage(output);
      }
      
      public function serializeAs_ChallengeInfoMessage(output:IDataOutput) : void {
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element challengeId.");
         }
         else
         {
            output.writeShort(this.challengeId);
            output.writeInt(this.targetId);
            if(this.xpBonus < 0)
            {
               throw new Error("Forbidden value (" + this.xpBonus + ") on element xpBonus.");
            }
            else
            {
               output.writeInt(this.xpBonus);
               if(this.dropBonus < 0)
               {
                  throw new Error("Forbidden value (" + this.dropBonus + ") on element dropBonus.");
               }
               else
               {
                  output.writeInt(this.dropBonus);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ChallengeInfoMessage(input);
      }
      
      public function deserializeAs_ChallengeInfoMessage(input:IDataInput) : void {
         this.challengeId = input.readShort();
         if(this.challengeId < 0)
         {
            throw new Error("Forbidden value (" + this.challengeId + ") on element of ChallengeInfoMessage.challengeId.");
         }
         else
         {
            this.targetId = input.readInt();
            this.xpBonus = input.readInt();
            if(this.xpBonus < 0)
            {
               throw new Error("Forbidden value (" + this.xpBonus + ") on element of ChallengeInfoMessage.xpBonus.");
            }
            else
            {
               this.dropBonus = input.readInt();
               if(this.dropBonus < 0)
               {
                  throw new Error("Forbidden value (" + this.dropBonus + ") on element of ChallengeInfoMessage.dropBonus.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
