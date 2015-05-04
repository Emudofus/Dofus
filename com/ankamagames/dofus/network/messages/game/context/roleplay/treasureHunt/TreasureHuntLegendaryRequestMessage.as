package com.ankamagames.dofus.network.messages.game.context.roleplay.treasureHunt
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class TreasureHuntLegendaryRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function TreasureHuntLegendaryRequestMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 6499;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var legendaryId:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 6499;
      }
      
      public function initTreasureHuntLegendaryRequestMessage(param1:uint = 0) : TreasureHuntLegendaryRequestMessage
      {
         this.legendaryId = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.legendaryId = 0;
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
         this.serializeAs_TreasureHuntLegendaryRequestMessage(param1);
      }
      
      public function serializeAs_TreasureHuntLegendaryRequestMessage(param1:ICustomDataOutput) : void
      {
         if(this.legendaryId < 0)
         {
            throw new Error("Forbidden value (" + this.legendaryId + ") on element legendaryId.");
         }
         else
         {
            param1.writeVarShort(this.legendaryId);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_TreasureHuntLegendaryRequestMessage(param1);
      }
      
      public function deserializeAs_TreasureHuntLegendaryRequestMessage(param1:ICustomDataInput) : void
      {
         this.legendaryId = param1.readVarUhShort();
         if(this.legendaryId < 0)
         {
            throw new Error("Forbidden value (" + this.legendaryId + ") on element of TreasureHuntLegendaryRequestMessage.legendaryId.");
         }
         else
         {
            return;
         }
      }
   }
}
