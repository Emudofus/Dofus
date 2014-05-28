package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class InventoryWeightMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function InventoryWeightMessage() {
         super();
      }
      
      public static const protocolId:uint = 3009;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var weight:uint = 0;
      
      public var weightMax:uint = 0;
      
      override public function getMessageId() : uint {
         return 3009;
      }
      
      public function initInventoryWeightMessage(weight:uint = 0, weightMax:uint = 0) : InventoryWeightMessage {
         this.weight = weight;
         this.weightMax = weightMax;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.weight = 0;
         this.weightMax = 0;
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
         this.serializeAs_InventoryWeightMessage(output);
      }
      
      public function serializeAs_InventoryWeightMessage(output:IDataOutput) : void {
         if(this.weight < 0)
         {
            throw new Error("Forbidden value (" + this.weight + ") on element weight.");
         }
         else
         {
            output.writeInt(this.weight);
            if(this.weightMax < 0)
            {
               throw new Error("Forbidden value (" + this.weightMax + ") on element weightMax.");
            }
            else
            {
               output.writeInt(this.weightMax);
               return;
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_InventoryWeightMessage(input);
      }
      
      public function deserializeAs_InventoryWeightMessage(input:IDataInput) : void {
         this.weight = input.readInt();
         if(this.weight < 0)
         {
            throw new Error("Forbidden value (" + this.weight + ") on element of InventoryWeightMessage.weight.");
         }
         else
         {
            this.weightMax = input.readInt();
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
