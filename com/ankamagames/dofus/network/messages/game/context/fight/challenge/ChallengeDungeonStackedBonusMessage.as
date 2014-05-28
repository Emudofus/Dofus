package com.ankamagames.dofus.network.messages.game.context.fight.challenge
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ChallengeDungeonStackedBonusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function ChallengeDungeonStackedBonusMessage() {
         super();
      }
      
      public static const protocolId:uint = 6151;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var dungeonId:uint = 0;
      
      public var xpBonus:uint = 0;
      
      public var dropBonus:uint = 0;
      
      override public function getMessageId() : uint {
         return 6151;
      }
      
      public function initChallengeDungeonStackedBonusMessage(dungeonId:uint = 0, xpBonus:uint = 0, dropBonus:uint = 0) : ChallengeDungeonStackedBonusMessage {
         this.dungeonId = dungeonId;
         this.xpBonus = xpBonus;
         this.dropBonus = dropBonus;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
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
         this.serializeAs_ChallengeDungeonStackedBonusMessage(output);
      }
      
      public function serializeAs_ChallengeDungeonStackedBonusMessage(output:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            output.writeInt(this.dungeonId);
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
         this.deserializeAs_ChallengeDungeonStackedBonusMessage(input);
      }
      
      public function deserializeAs_ChallengeDungeonStackedBonusMessage(input:IDataInput) : void {
         this.dungeonId = input.readInt();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of ChallengeDungeonStackedBonusMessage.dungeonId.");
         }
         else
         {
            this.xpBonus = input.readInt();
            if(this.xpBonus < 0)
            {
               throw new Error("Forbidden value (" + this.xpBonus + ") on element of ChallengeDungeonStackedBonusMessage.xpBonus.");
            }
            else
            {
               this.dropBonus = input.readInt();
               if(this.dropBonus < 0)
               {
                  throw new Error("Forbidden value (" + this.dropBonus + ") on element of ChallengeDungeonStackedBonusMessage.dropBonus.");
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
