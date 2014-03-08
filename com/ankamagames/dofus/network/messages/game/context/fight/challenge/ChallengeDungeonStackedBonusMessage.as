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
      
      public function initChallengeDungeonStackedBonusMessage(param1:uint=0, param2:uint=0, param3:uint=0) : ChallengeDungeonStackedBonusMessage {
         this.dungeonId = param1;
         this.xpBonus = param2;
         this.dropBonus = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.dungeonId = 0;
         this.xpBonus = 0;
         this.dropBonus = 0;
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
         this.serializeAs_ChallengeDungeonStackedBonusMessage(param1);
      }
      
      public function serializeAs_ChallengeDungeonStackedBonusMessage(param1:IDataOutput) : void {
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element dungeonId.");
         }
         else
         {
            param1.writeInt(this.dungeonId);
            if(this.xpBonus < 0)
            {
               throw new Error("Forbidden value (" + this.xpBonus + ") on element xpBonus.");
            }
            else
            {
               param1.writeInt(this.xpBonus);
               if(this.dropBonus < 0)
               {
                  throw new Error("Forbidden value (" + this.dropBonus + ") on element dropBonus.");
               }
               else
               {
                  param1.writeInt(this.dropBonus);
                  return;
               }
            }
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ChallengeDungeonStackedBonusMessage(param1);
      }
      
      public function deserializeAs_ChallengeDungeonStackedBonusMessage(param1:IDataInput) : void {
         this.dungeonId = param1.readInt();
         if(this.dungeonId < 0)
         {
            throw new Error("Forbidden value (" + this.dungeonId + ") on element of ChallengeDungeonStackedBonusMessage.dungeonId.");
         }
         else
         {
            this.xpBonus = param1.readInt();
            if(this.xpBonus < 0)
            {
               throw new Error("Forbidden value (" + this.xpBonus + ") on element of ChallengeDungeonStackedBonusMessage.xpBonus.");
            }
            else
            {
               this.dropBonus = param1.readInt();
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
