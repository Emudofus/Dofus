package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import flash.utils.ByteArray;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class InventoryWeightMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryWeightMessage()
      {
         super();
      }
      
      public static const protocolId:uint = 3009;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      public var weight:uint = 0;
      
      public var weightMax:uint = 0;
      
      override public function getMessageId() : uint
      {
         return 3009;
      }
      
      public function initInventoryWeightMessage(param1:uint = 0, param2:uint = 0) : InventoryWeightMessage
      {
         this.weight = param1;
         this.weightMax = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.weight = 0;
         this.weightMax = 0;
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
         this.serializeAs_InventoryWeightMessage(param1);
      }
      
      public function serializeAs_InventoryWeightMessage(param1:ICustomDataOutput) : void
      {
         if(this.weight < 0)
         {
            throw new Error("Forbidden value (" + this.weight + ") on element weight.");
         }
         else
         {
            param1.writeVarInt(this.weight);
            if(this.weightMax < 0)
            {
               throw new Error("Forbidden value (" + this.weightMax + ") on element weightMax.");
            }
            else
            {
               param1.writeVarInt(this.weightMax);
               return;
            }
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_InventoryWeightMessage(param1);
      }
      
      public function deserializeAs_InventoryWeightMessage(param1:ICustomDataInput) : void
      {
         this.weight = param1.readVarUhInt();
         if(this.weight < 0)
         {
            throw new Error("Forbidden value (" + this.weight + ") on element of InventoryWeightMessage.weight.");
         }
         else
         {
            this.weightMax = param1.readVarUhInt();
            if(this.weightMax < 0)
            {
               throw new Error("Forbidden value (" + this.weightMax + ") on element of InventoryWeightMessage.weightMax.");
            }
            else
            {
               return;
            }
         }
      }
   }
}
