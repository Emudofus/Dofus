package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TreasureHuntRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TreasureHuntRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6488;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var questLevel:uint = 0;
      
      public var questType:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6488;
      }
      
      public function initTreasureHuntRequestMessage(param1:uint = 0, param2:uint = 0) : TreasureHuntRequestMessage
      {
         this.questLevel = param1;
         this.questType = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.questLevel = 0;
         this.questType = 0;
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
         this.serializeAs_TreasureHuntRequestMessage(param1);
      }
      
      public function serializeAs_TreasureHuntRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.questLevel < 1 || this.questLevel > 200)
         {
            throw new Error("Forbidden value (" + this.questLevel + ") on element questLevel.");
         }
         else
         {
            param1.writeByte(this.questLevel);
            param1.writeByte(this.questType);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntRequestMessage(param1);
      }
      
      public function deserializeAs_TreasureHuntRequestMessage(param1:ICustomDataInput) : void
      {
         this.questLevel = param1.readUnsignedByte();
         if(this.questLevel < 1 || this.questLevel > 200)
         {
            throw new Error("Forbidden value (" + this.questLevel + ") on element of TreasureHuntRequestMessage.questLevel.");
         }
         else
         {
            this.questType = param1.readByte();
            if(this.questType < 0)
            {
               throw new Error("Forbidden value (" + this.questType + ") on element of TreasureHuntRequestMessage.questType.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
